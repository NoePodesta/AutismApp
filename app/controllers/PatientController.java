package controllers;

import com.avaje.ebean.Ebean;
import models.*;
import msg.Msg;
import play.data.Form;
import play.mvc.Controller;
import play.mvc.Result;
import play.mvc.Security;
import views.html.patient.patientProfile;

import java.util.ArrayList;
import java.util.List;

import static play.data.Form.form;


/**
 * Created with IntelliJ IDEA.
 * User: NoePodesta
 * Date: 03/09/13
 * Time: 12:15
 */
@Security.Authenticated(Secured.class)
public class PatientController
        extends Controller {

    public static Result createPatient() {
        Form<Patient> patientForm = form(Patient.class);

        return ok(
                views.html.patient.createPatientForm.render(patientForm)
        );
    }

    public static Result patientList() {
        return ok(views.html.patient.patients.render(Patient.findPatientByInstitution(
                        Therapist.findTherapistByDNI(session().get(Msg.DNI)).institution))
        );
    }

    public static Result myPatients() {
        Therapist therapist = Therapist.findTherapistByDNI(session().get(Msg.DNI));
        List<Team> assignedTeams = therapist.getAssignedTeams();
        List<Patient> patients = new ArrayList<Patient>();
        for(Team team : assignedTeams){
            patients.add(team.getPatient());
        }

        return ok(views.html.patient.patients.render(patients));
    }

    public static Result savePatient() {

        Form<Patient> patientForm = form(Patient.class).bindFromRequest();


        if(patientForm.hasErrors()) {
            return badRequest(views.html.patient.createPatientForm.render(patientForm));
        }

        // Check if the dni is valid
        if(!patientForm.hasErrors()) {
            if(Patient.findPatientByDNI(patientForm.get().dni) != null) {
                patientForm.reject(Msg.DNI, Msg.CHECK_DNI);
            }
        }


        Patient patientFromForm = patientForm.get();


        Gender gender = (patientForm.data().get(Msg.GENERO).equals(Gender.FEMALE.toString()) ? Gender.FEMALE :
                Gender.MALE);

        String pathFile = ImageController.getUserImagePathName(patientFromForm, gender);

        Institution institution = InstitutionController.getInsitutionById(Application.getCurrentTherapist().institution.id);

        Address address = new Address(patientFromForm.address.street, patientFromForm.address.number,
                patientFromForm.address.floor, patientFromForm.address.depto, patientFromForm.address.cp,
                patientFromForm.address.locality, patientFromForm.address.province);

        Patient patient = new Patient(patientFromForm.name, patientFromForm.surname, patientFromForm.telephone,
                patientFromForm.cellphone,address, patientFromForm.dni, patientFromForm.gender, patientFromForm.mail,
                patientFromForm.birthday, patientFromForm.medicalCoverage,patientFromForm.nMedicalCoverage,
                patientFromForm.disease,
                patientFromForm.gradeDisease,pathFile, institution);

        Ebean.save(address);
        Ebean.save(patient);
        flash(Msg.SUCCESS, Msg.ADDED(Msg.PATIENT, patient.name, patient.surname));





        return patientList();
    }

    public static Result removePatient(int id) {
        if(Patient.delete(id)){
            flash(Msg.SUCCESS, Msg.REMOVE(Msg.PATIENT));
        }else{
            //Do Error Message
        }
        return patientList();
    }

    public static Result updatePatient(){
        Form<Patient> patientForm = form(Patient.class).bindFromRequest();


        if(patientForm.hasErrors()) {
            return badRequest(views.html.patient.createPatientForm.render(patientForm));
        }

        // Check if the dni is valid
        if(!patientForm.hasErrors()) {
            if(Patient.findPatientByDNI(patientForm.get().dni) != null) {
                patientForm.reject(Msg.DNI, Msg.CHECK_DNI);
            }
        }

        Patient patientFromForm = patientForm.get();
        Address address = Address.findById(Patient.findPatientById(patientFromForm.id).address.id);
        Address addressForm = patientFromForm.address;
        address.street = addressForm.street;
        address.number = addressForm.number;
        address.floor = addressForm.floor;
        address.depto = addressForm.depto;
        address.cp = addressForm.cp;
        address.locality = addressForm.locality;
        address.province = addressForm.province;
        patientFromForm.address = address;
        Ebean.update(address);
        Ebean.update(patientFromForm);
        flash(Msg.SUCCESS, Msg.CHANGES_SAVED);



        return patientList();
    }

    public static Result editPatient(int id) {
        Patient patientToFill = Patient.findPatientById(id);
        Form<Patient> patientForm = form(Patient.class).fill(patientToFill);
        return ok(views.html.patient.editPatientForm.render(patientForm));
    }

    public static Patient getByTeam(Team team){
        return Patient.findByTeam(team);
    }

    public static Patient getPatientById(int id) {
        return Patient.findPatientById(id);
    }

    public static List<String> allPatientsByNameAndDni(String dni) {
        List<String> patients = new ArrayList<String>();
        for(Patient patient : Patient.findPatientByInstitution(Application.getCurrentTherapist().institution)){
            patients.add(patient.name + " " + patient.surname + " - " + patient.dni);
        }

        return patients;
    }

    public static Result patientProfile(int id){
        Patient patient = Patient.findPatientById(id);
        return ok(views.html.patient.patientProfile.render(patient));    }
}
