package controllers;

import com.avaje.ebean.Ebean;
import models.*;
import play.data.Form;
import play.mvc.Controller;
import play.mvc.Result;
import play.mvc.Security;

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
        return ok(
                views.html.patient.patients.render(Patient.findPatientByInstitution(Therapist.findTherapistByDNI(session().get("dni")).institution))
        );
    }

    public static Result savePatient() {

        Form<Patient> patientForm = form(Patient.class).bindFromRequest();


        if(patientForm.hasErrors()) {
            return badRequest(views.html.patient.createPatientForm.render(patientForm));
        }

        // Check if the dni is valid
        if(!patientForm.hasErrors()) {
            if(Patient.findPatientByDNI(patientForm.get().dni) != null) {
                patientForm.reject("dni", "Ya se ha ingresado este dni");
            }
        }


        Patient patientFromForm = patientForm.get();


        Gender gender = (patientForm.data().get("genero").equals(Gender.FEMALE.toString()) ? Gender.FEMALE : Gender.MALE);

        String pathFile = UserController.getPathName(patientFromForm,gender);

        Institution institution = InstitutionController.getInsitutionById(Therapist.findTherapistByDNI(session().get("dni")).institution.id);

        Address address = new Address(patientFromForm.address.street, patientFromForm.address.number,
                patientFromForm.address.floor, patientFromForm.address.depto, patientFromForm.address.cp,
                patientFromForm.address.locality, patientFromForm.address.province);

        Patient patient = new Patient(patientFromForm.name, patientFromForm.surname, patientFromForm.telephone,
                patientFromForm.cellphone,address, patientFromForm.dni, patientFromForm.gender, patientFromForm.mail,
                patientFromForm.birthday, patientFromForm.medicalCoverage,patientFromForm.nMedicalCoverage,patientFromForm.disease,
                patientFromForm.gradeDisease,pathFile, institution);

        Ebean.save(address);
        Ebean.save(patient);
        flash("success", "El paciente " + patientForm.get().name +" " + patientForm.get().surname + " ya ha sido " +
                "dada de alta");





        return patientList();
    }

    public static Result removePatient(int id) {
        if(Patient.delete(id)){
            flash("success", "El terapeuta ha sido eliminado");
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
                patientForm.reject("dni", "Ya se ha ingresado este dni");
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
        flash("success", "Sus cambios han sido guardados");



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
}
