package controllers;


import models.Patient;
import models.Therapist;
import models.TherapistType;
import play.data.Form;
import play.mvc.Controller;
import play.mvc.Result;
import views.html.*;

import static play.data.Form.form;

public class Application extends Controller {

    public static class Login {
        public String dni;
        public String password;

        public String validate() {
            if (Therapist.authenticate(dni, password) == null) {
                return "Invalid user or password";
            }
            return null;
        }

    }

    public static Result signUp() {
        Form<Therapist> therapistForm = form(Therapist.class);
        return ok(signUp.render("Sign Up Form", therapistForm));
    }

    public static Result registerAdmin() {
        return TherapistController.saveTherapist(TherapistType.ADMIN_COORDINATOR);
    }

    public static Result index() {
        return ok(therapists.render(Therapist.all()));
    }

    public static Result login(){
        return ok(login.render(form(Login.class)));
    }


    public static Result authenticate() {
        Form<Login> loginForm = form(Login.class).bindFromRequest();
        if (loginForm.hasErrors()) {
            return badRequest(login.render(loginForm));
        } else {
            session().clear();
            session("dni", loginForm.get().dni);
            return redirect(routes.Application.index());
        }
    }



    public static Result createPatient() {
        Form<Patient> patientForm = form(Patient.class);
        return ok(
                createPatientForm.render(patientForm)
        );
    }



    public static Result patientList() {
        return ok(
                patients.render(Patient.all()));
    }

    public static Result profile() {
        return ok();
    }

    public static Result logout() {
        session().clear();
        flash("success", "You've been logged out");
        return redirect(
                routes.Application.login()
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