package controllers;


import models.Therapist;
import models.TherapistType;
import play.data.Form;
import play.mvc.Controller;
import play.mvc.Result;

import views.html.login;
import views.html.signUp;
import views.html.therapists;


import static play.data.Form.form;

public class Application extends Controller {


    public static class Login {
        public String dni;
        public String password;

        public String validate() {
            if (Therapist.authenticate(dni, password) == null) return "Invalid user or password";
            return null;
        }
    }

    public static class PartialSignUp {
        public String dni;
        public String password;
        public String mail;
    }

    public static Result signUpPartial(){
        Form<PartialSignUp> partialSignUpForm = form(PartialSignUp.class).bindFromRequest();
        return signUp(partialSignUpForm);
    }

    public static Result signUp(){
        return signUp(form(PartialSignUp.class));
    }

    public static Result signUp(Form<PartialSignUp> partialSignUpForm) {
        Form<Therapist> therapistForm = form(Therapist.class);
        return ok(signUp.render("Sign Up Form", therapistForm, partialSignUpForm));
    }

    public static Result registerAdmin() {
        return TherapistController.saveTherapist(TherapistType.ADMIN, form(Therapist.class).bindFromRequest());
    }

    public static Result index() {
        return ok(therapists.render(Therapist.all()));
    }

    public static Result login(){
        return ok(login.render(form(Login.class), form(PartialSignUp.class)));
    }


    public static Result authenticate() {
        Form<Login> loginForm = form(Login.class).bindFromRequest();
        if (loginForm.hasErrors()) {
            return badRequest(login.render(form(Login.class), form(PartialSignUp.class)));
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