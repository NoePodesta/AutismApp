package controllers;

import com.avaje.ebean.Ebean;
import models.Gender;
import models.Patient;
import models.Therapist;
import models.User;
import org.apache.commons.io.FileUtils;
import play.data.Form;
import play.mvc.Controller;
import play.mvc.Http;
import play.mvc.Result;
import views.html.createPatientForm;

import java.io.File;
import java.io.IOException;

import static play.data.Form.form;

/**
 * Created with IntelliJ IDEA.
 * User: NoePodesta
 * Date: 03/09/13
 * Time: 12:15
 */

public class PatientController
        extends Controller {

    public static Result createPatient() {
        Form<Patient> patientForm = form(Patient.class);
        return ok(
                views.html.createPatientForm.render(patientForm)
        );
    }

    public static Result patientList() {
        return ok(
                views.html.patients.render(Patient.all())
        );
    }

    public static Result savePatient() {

        Form<Patient> patientForm = form(Patient.class).bindFromRequest();

        // Check if the username is valid
        if(!patientForm.hasErrors()) {
            if(Therapist.findTherapistByDNI(patientForm.get().dni) != null) {
                patientForm.reject("dni", "Ya se ha ingresado este dni");
            }
        }

        if(patientForm.hasErrors()) {
            return badRequest(createPatientForm.render(patientForm));
        }

        Patient patientFromForm = patientForm.get();

        Gender gender = (patientFromForm.gender.equals(Gender.FEMALE.toString()) ? Gender.FEMALE : Gender.MALE);

        Http.MultipartFormData body = request().body().asMultipartFormData();
        Http.MultipartFormData.FilePart picture = body.getFile("picture");


        String pathFile;

        if(picture != null){

            String fileName = picture.getFilename();
            File file = picture.getFile();

            File destinationFile = new File(play.Play.application().path().toString() + "//public//uploads//"
                    + patientFromForm.name + patientFromForm.surname + "//" + fileName);

            try {
                FileUtils.copyFile(file, destinationFile);

            } catch (IOException e) {
                e.printStackTrace();
            }

            pathFile = "/assets/uploads/" + patientFromForm.name + patientFromForm.surname + "/" + fileName;
        }else{
            pathFile = gender.isFemale() ? "/assets/uploads/female.jpg" : "/assets/uploads/male.jpg";

        }

        User.Address address = new User.Address(patientFromForm.address.street,patientFromForm.address.number,
                patientFromForm.address.floor, patientFromForm.address.depto,patientFromForm.address.cp,
                patientFromForm.address.locality,patientFromForm.address.province);

        Patient patient = new Patient(patientFromForm.name, patientFromForm.surname, patientFromForm.telephone,
                patientFromForm.cellphone,address, patientFromForm.dni, patientFromForm.gender, patientFromForm.mail,
                patientFromForm.birthday, patientFromForm.medicalCoverage,patientFromForm.nMedicalCoverage,patientFromForm.disease,
                patientFromForm.gradeDisease,pathFile);

        Ebean.save(address);
        Ebean.save(patient);
        flash("success", "La terapeuta " + patientForm.get().name +" " + patientForm.get().surname + " ya ha sido " +
                "dada de alta");
        return patientList();
    }

    public static Result removePatient(int id) {
        Patient patient = Patient.find.ref(id);
        if(patient != null){
            patient.delete();
            flash("success", "El paciente ha sido eliminado");
        }
        return patientList();
    }
}
