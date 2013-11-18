package controllers;


import models.Institution;
import models.Therapist;
import models.TherapistType;
import msg.Msg;
import play.data.Form;
import play.mvc.Controller;
import play.mvc.Result;

import views.html.loginPage;
import views.html.signUpInstitution;


import static play.data.Form.form;

public class Application extends Controller {


    private static Therapist currentTherapist;
    private static Form<PartialSignUp> partialSignUpForm;
    private static Form<PartialSignUp> signUpForm;

    public static Form<PartialSignUp> getPartialSignUpForm() {
        return partialSignUpForm;
    }

    public static class Login {
        public String dni;
        public String password;

        public String validate() {
            if (!Therapist.authenticate(dni, password))
                return Msg.INVALID;
            return null;
        }
    }

    public static class PartialSignUp {
        public String dni;
        public String password;
        public String mail;
    }

    public static class RecoverPassword {
        public String dni;
        public String mail;
    }

//    public static Result signUpPartial(){
//        partialSignUpForm = form(PartialSignUp.class).bindFromRequest();
//        return signUpInstitution();
//    }

//    public static Result signUp(){
//        return signUp(form(PartialSignUp.class));
//    }

    public static Result signUpInstitution(){
        Form<Institution> institutionForm = form(Institution.class);
        return ok(signUpInstitution.render(institutionForm));
    }

//    public static Result signUp(Form<PartialSignUp> partialSignUpForm) {
//        Form<Institution> institutionForm = form(Institution.class);
//        return ok(signUpInstitution.render(institutionForm, partialSignUpForm));
//    }


    public static Result index() {
        //return ok(therapists.render(Therapist.findByInstitutionId()));
        return login();
    }

    public static Result login(){
        return ok(loginPage.render(form(Login.class), form(PartialSignUp.class), form(RecoverPassword.class)));
    }


    public static Result authenticate() {
        Form<Login> loginForm = form(Login.class).bindFromRequest();
        if (loginForm.hasErrors()) {
            return badRequest(loginPage.render(loginForm, form(PartialSignUp.class), form(RecoverPassword.class)));
        } else {
            session().clear();
            String dni = loginForm.get().dni;
            session(Msg.DNI, dni);
            //currentTherapist = Therapist.findTherapistByDNI(dni);
            return TherapistController.profile();
        }
    }



    public static Result logout() {
        session().clear();
        currentTherapist = null;
        flash(Msg.SUCCESS, Msg.LOGOUT);
        return redirect(
                routes.Application.login()
        );
    }

    public static Result recoverPassword(){
        RecoverPassword recoverPassword = form(RecoverPassword.class).bindFromRequest().get();

        if(MailService.recoverPassword(recoverPassword.dni, recoverPassword.mail)){
            flash(Msg.SUCCESS, Msg.MAIL_SENT);
        }else{
            flash(Msg.SUCCESS, Msg.INVALID_INFO);
        }
        return login();
    }

    public static Therapist getCurrentTherapist() {
        return Therapist.findTherapistByDNI(session().get("dni"));
    }

}