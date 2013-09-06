package controllers;


import models.Patient;
import models.Therapist;
import play.data.Form;
import play.mvc.Controller;
import play.mvc.Result;
import play.mvc.Security;
import views.html.createPatientForm;
import views.html.login;
import views.html.patients;
import views.html.therapists;

import static play.data.Form.form;

public class Application extends Controller {

    public static class Login {
        public int dni;
        public String password;

        public String validate() {
            if (Therapist.authenticate(dni, password) == null) {
                return "Invalid user or password";
            }
            return null;
        }

    }

    @Security.Authenticated(Secured.class)
    public static Result index() {
        return ok(therapists.render("Autism Application", Therapist.all()));
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
            session("dni", Integer.toString(loginForm.get().dni));
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
                patients.render("Pacientes", Patient.all()));
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