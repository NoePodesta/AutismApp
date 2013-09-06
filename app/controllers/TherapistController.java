package controllers;

import com.avaje.ebean.Ebean;
import models.Therapist;
import org.apache.commons.io.FileUtils;
import play.data.Form;
import play.mvc.Controller;
import play.mvc.Http;
import play.mvc.Result;
import views.html.createTherapistForm;
import views.html.editTherapistForm;
import views.html.therapists;

import java.io.File;
import java.io.IOException;

import static play.data.Form.form;

/**
 * Created with IntelliJ IDEA.
 * User: Juani
 * Date: 9/4/13
 * Time: 11:27 PM
 * To change this template use File | Settings | File Templates.
 */
public class TherapistController extends Controller {


    public static Result createTherapist() {
        Form<Therapist> therapistForm = form(Therapist.class);
        return ok(
                createTherapistForm.render(therapistForm)
        );
    }

    public static Result therapistList() {
        return ok(
                therapists.render("Terapeutas", Therapist.all()));
    }

    public static Result saveTherapist() {

        Form<Therapist> therapistForm = form(Therapist.class).bindFromRequest();
        if(therapistForm.hasErrors()) {
            return badRequest(createTherapistForm.render(therapistForm));
        }
        Therapist therapistFromForm = therapistForm.get();


        Http.MultipartFormData body = request().body().asMultipartFormData();
        Http.MultipartFormData.FilePart picture = body.getFile("picture");

        String fileName = null;

        if(picture != null){

            fileName = picture.getFilename();
            File file = picture.getFile();

            File destinationFile = new File(play.Play.application().path().toString() + "//public//uploads//"
                    + therapistFromForm.name + therapistFromForm.surname + "//" + fileName);

            try {
                FileUtils.copyFile(file, destinationFile);

            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        Therapist therapist = new Therapist(therapistFromForm.name, therapistFromForm.surname, therapistFromForm.telephone,
                therapistFromForm.address, therapistFromForm.dni, therapistFromForm.mail,therapistFromForm.birthday,
                therapistFromForm.nm, therapistFromForm.password, "/assets/uploads/" + therapistFromForm.name +
                therapistFromForm.surname + "//" + fileName);


        therapist.save();
        Ebean.save(therapist);
        flash("success", "La terapeuta " + therapistForm.get().name +" " + therapistForm.get().surname + " ya ha sido " +
                "dada de alta");
        return therapistList();
    }


    public static Result editTherapist(int id) {
        Form<Therapist> therapistForm = form(Therapist.class).fill(
                Therapist.find.byId(id)
        );
        return ok(
                editTherapistForm.render("Editar", id, therapistForm)
        );
    }

    /**
     * Handle the 'edit form' submission
     *
     * @param id Id of the computer to edit
     */
    public static Result updateTherapist(int id) {
        Form<Therapist> therapistForm = form(Therapist.class).bindFromRequest();
        if(therapistForm.hasErrors()) {
            return badRequest(editTherapistForm.render("Editar", id, therapistForm));
        }
        therapistForm.get().update(id);
        flash("success", "Sus cambios han sido guardados");
        return therapistList();
    }

    public static Result removeTherapist(int id) {
        Therapist therapist = Therapist.find.ref(id);
        if(therapist != null){
            therapist.delete();
            flash("success", "El terapeuta ha sido eliminado");
        }
        return therapistList();
    }

}
