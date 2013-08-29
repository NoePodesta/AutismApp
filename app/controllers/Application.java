package controllers;


import com.avaje.ebean.Ebean;
import models.Therapist;
import play.data.Form;
import play.mvc.*;
import views.html.*;

import javax.persistence.EntityManager;

import static play.data.Form.form;

public class Application extends Controller {

    public static Result index() {
        return ok(index.render("This is the home page"));
    }

    public static Result login() {
        return ok(login.render());
    }

    public static Result createTherapist() {
        Form<Therapist> therapistForm = form(Therapist.class);
        return ok(
                createForm.render(therapistForm)
        );
    }
    public static Result saveTherapist() {

        Form<Therapist> therapistForm = form(Therapist.class).bindFromRequest();
        if(therapistForm.hasErrors()) {
            return badRequest(createForm.render(therapistForm));
        }
        Therapist therapistFromForm = therapistForm.get();
        Therapist therapist = new Therapist(therapistFromForm.name, therapistFromForm.surname, therapistFromForm.telephone,
                therapistFromForm.address, therapistFromForm.dni, therapistFromForm.mail,therapistFromForm.birthday,
                therapistFromForm.nm, therapistFromForm.pass);
        therapist.save();
        Ebean.save(therapist);
        flash("success", "Computer " + therapistForm.get().name + " has been created");
        return index();
    }
}