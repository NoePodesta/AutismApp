package controllers;

import models.Patient;
import play.data.Form;
import play.mvc.Controller;
import play.mvc.Result;

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

//        Form<Patient> patientForm = form(Patient.class).bindFromRequest();
//        if(patientForm.hasErrors()) {
//            return badRequest(createPatientForm.render(patientForm));
//        }
//        Patient pacientFromForm = patientForm.get();
//        Therapist pacient = new Therapist(pacientFromForm.name, pacientFromForm.surname, pacientFromForm.telephone,
//                pacientFromForm.address, pacientFromForm.dni, pacientFromForm.mail,pacientFromForm.birthday,
//                pacientFromForm.nm, pacientFromForm.pass);
//        pacient.save();
//        Ebean.save(pacient);
//        flash("success", "La terapeuta " + patientForm.get().name + " " + patientForm.get().surname + " ya ha sido " +
//                "dada de alta");
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
