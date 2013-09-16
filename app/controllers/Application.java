package controllers;


import models.Patient;
import models.Team;
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
        return TherapistController.saveTherapist(TherapistType.ADMIN);
    }

    public static Result index() {
        return ok(therapists.render(Therapist.all()));
    }

    public static Result login(){
        return ok(login.render(form(Login.class),form(Therapist.class)));
    }


    public static Result authenticate() {
        Form<Login> loginForm = form(Login.class).bindFromRequest();
        if (loginForm.hasErrors()) {
            return badRequest(login.render(loginForm,form(Therapist.class)));
        } else {
            session().clear();
            session("dni", loginForm.get().dni);
            return redirect(routes.Application.index());
        }
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

}