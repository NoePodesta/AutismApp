package controllers;


import com.avaje.ebean.Ebean;
import models.Patient;
import models.Therapist;
import play.data.Form;
import play.mvc.Controller;
import play.mvc.Result;

import java.util.Date;

import views.html.*;

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

    public static Result index() {
        return ok(therapists.render("Autism Application", Therapist.all()));
    }

    public static Result login(){
        Therapist therapist = new Therapist("Juan", "Molteni", "47911306",
                "Calle Flase 123", 123, "j@j.com",new Date(),
                123, "asd");
        therapist.save();
        Ebean.save(therapist);
        return ok(login.render(form(Login.class)));
    }


    public static Result authenticate() {
        Form<Login> loginForm = form(Login.class).bindFromRequest();
        if (loginForm.hasErrors()) {
            return TODO;
            //return badRequest(login.render(loginForm));
        } else {
            session().clear();
            session("dni", Integer.toString(loginForm.get().dni));
            return redirect(routes.Application.index());
        }
    }

    public static Result createTherapist() {
        Form<Therapist> therapistForm = form(Therapist.class);
        return ok(
                createTherapistForm.render(therapistForm)
        );
    }

    public static Result createPatient() {
        Form<Patient> patientForm = form(Patient.class);
        return ok(
                createPatientForm.render(patientForm)
        );
    }

    public static Result therapistList() {
        return ok(
                therapists.render("Terapeutas", Therapist.all()));
    }

    public static Result patientList() {
        return ok(
                patients.render("Pacientes", Patient.all()));
    }

    public static Result profile() {
        return ok();
    }

    public static Result saveTherapist() {

        Form<Therapist> therapistForm = form(Therapist.class).bindFromRequest();
        if(therapistForm.hasErrors()) {
            return badRequest(createTherapistForm.render(therapistForm));
        }
        Therapist therapistFromForm = therapistForm.get();
        Therapist therapist = new Therapist(therapistFromForm.name, therapistFromForm.surname, therapistFromForm.telephone,
                therapistFromForm.address, therapistFromForm.dni, therapistFromForm.mail,therapistFromForm.birthday,
                therapistFromForm.nm, therapistFromForm.password);
        therapist.save();
        Ebean.save(therapist);
        flash("success", "La terapeuta " + therapistForm.get().name +" " + therapistForm.get().surname + " ya ha sido " +
                "dada de alta");
        return therapistList();
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

    public static Result removeTherapist(int id) {
        Therapist.find.ref(id).delete();
        flash("success", "El terapeuta ha sido eliminado");
        return therapistList();
    }


    public static Result removePatient(int id) {
        Therapist.find.ref(id).delete();
        flash("success", "El paciente ha sido eliminado");
        return patientList();
    }
}