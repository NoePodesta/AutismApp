package controllers;


import models.Institution;
import models.Therapist;
import models.TherapistType;
import msg.Msg;
import play.data.Form;
import play.mvc.Controller;
import play.mvc.Result;

import views.html.comercialHtml;
import views.html.loginPage;
import views.html.signUpAdmin;
import views.html.signUpInstitution;


import static play.data.Form.form;

public class Application extends Controller {


    private static Therapist currentTherapist;


    public static class Login {
        public String dni;
        public String password;

        public String validate() {
            if (!Therapist.authenticate(dni, password))
                return Msg.INVALID;
            return null;
        }
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
        Form<Institution> institutionForm = form(Institution.class).bindFromRequest();
        return ok(signUpInstitution.render(institutionForm));
    }

    public static Result signUpAdmin(){

        Form<Therapist> form = form(Therapist.class).bindFromRequest();

        Integer institutionId = Integer.valueOf(form().bindFromRequest().get("institutionId"));

        System.out.print(institutionId);
        if(form.hasErrors()) {
            flash(Msg.ERRORS, Msg.ERROR);
            return badRequest(signUpAdmin.render(form, institutionId));
        }

        // Check if the dni is valid
        if(!form.hasErrors()) {
            if(Therapist.findTherapistByDNI(form.get().dni) != null) {
                form.reject(Msg.DNI, Msg.CHECK_DNI);
                flash(Msg.ERRORS, Msg.ERROR);
                return  badRequest(signUpAdmin.render(form,institutionId));
            }
        }

        // Check repeated password
        if(!form.field("password").valueOr("").isEmpty()) {
            if(!form.field("password").valueOr("").equals(form.field("repeatPassword").value())) {
                form.reject("repeatPassword", "La contraseña no coincide");
                flash(Msg.ERRORS, Msg.ERROR);
                return  badRequest(signUpAdmin.render(form,institutionId));
            }
        }



        Institution institution = Institution.getById(institutionId);

        return TherapistController.saveTherapist(TherapistType.ADMIN, form(Therapist.class).bindFromRequest(),
                true, institution);
    }

//    public static Result signUp(Form<PartialSignUp> partialSignUpForm) {
//        Form<Institution> institutionForm = form(Institution.class);
//        return ok(signUpInstitution.render(institutionForm, partialSignUpForm));
//    }


    public static Result index() {
        return ok(comercialHtml.render(form(Institution.class)));
    }

    public static Result login(){
        return ok(loginPage.render(form(Login.class), form(RecoverPassword.class)));
    }

    public static Result partialSignUp(){
        return Application.signUpInstitution();
    }


    public static Result authenticate() {
        Form<Login> loginForm = form(Login.class).bindFromRequest();
        if (loginForm.hasErrors()) {
            return badRequest(loginPage.render(loginForm, form(RecoverPassword.class)));
        } else {
            session().clear();
            String dni = loginForm.get().dni;
            session(Msg.DNI, dni);
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