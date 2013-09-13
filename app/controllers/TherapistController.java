package controllers;

import com.avaje.ebean.Ebean;
import models.Patient;
import models.Therapist;
import models.TherapistType;
import org.apache.commons.io.FileUtils;
import play.data.Form;
import play.data.validation.ValidationError;
import play.mvc.Controller;
import play.mvc.Http;
import play.mvc.Result;
import play.mvc.Security;
import views.html.createTherapistForm;
import views.html.editTherapistForm;
import views.html.therapists;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import static play.data.Form.form;

/**
 * Created with IntelliJ IDEA.
 * User: Juani
 * Date: 9/4/13
 * Time: 11:27 PM
 * To change this template use File | Settings | File Templates.
 */
@Security.Authenticated(Secured.class)
public class TherapistController extends Controller {


    public static Result createTherapist() {
        if (Secured.isAdmin()) {
            Form<Therapist> therapistForm = form(Therapist.class);
            return ok(
                    createTherapistForm.render(therapistForm)
            );
        }else{
            return forbidden();
        }
    }

    public static Result therapistList() {
        return ok(therapists.render(Therapist.all()));
    }

    public static Result saveTherapist(){
        return saveTherapist(TherapistType.NO_PRIVILEGES);
    }

    public static Result saveTherapist(TherapistType type) {

        Form<Therapist> therapistForm = form(Therapist.class).bindFromRequest();

        // Check repeated password
        if(!therapistForm.field("password").valueOr("").isEmpty()) {
            if(!therapistForm.field("password").valueOr("").equals(therapistForm.field("repeatPassword").value())) {
                therapistForm.reject("repeatPassword", "La contraseña no coincide");
            }
        }

        // Check if the username is valid
        if(!therapistForm.hasErrors()) {
            if(Therapist.findTherapistByDNI(therapistForm.get().dni) != null) {
                therapistForm.reject("dni", "Ya se ha ingresado este dni");
            }
        }

        if(therapistForm.hasErrors()) {
            return badRequest(createTherapistForm.render(therapistForm));
        }

        Therapist therapistFromForm = therapistForm.get();


        Http.MultipartFormData body = request().body().asMultipartFormData();
        Http.MultipartFormData.FilePart picture = body.getFile("picture");


        String pathFile = null;

        if(picture != null){

            String fileName = picture.getFilename();
            File file = picture.getFile();

            File destinationFile = new File(play.Play.application().path().toString() + "//public//uploads//"
                    + therapistFromForm.name + therapistFromForm.surname + "//" + fileName);

            try {
                FileUtils.copyFile(file, destinationFile);

            } catch (IOException e) {
                e.printStackTrace();
            }

            pathFile = "/assets/uploads/" + therapistFromForm.name + therapistFromForm.surname + "/" + fileName;
        }

        Therapist therapist = new Therapist(therapistFromForm.name, therapistFromForm.surname, therapistFromForm.telephone,
                therapistFromForm.cellphone,therapistFromForm.address, therapistFromForm.dni, therapistFromForm.mail,therapistFromForm.birthday,
                therapistFromForm.nm, therapistFromForm.password, pathFile, type);

        Ebean.save(therapist);
        flash("success", "La terapeuta " + therapistForm.get().name +" " + therapistForm.get().surname + " ya ha sido " +
                "dada de alta");
        return therapistList();
    }


    public static Result editTherapist(int id) {
        Form<Therapist> therapistForm = form(Therapist.class).fill(
                Therapist.findTherapistById(id)
        );
        return ok(
                editTherapistForm.render(id, therapistForm)
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
            return badRequest(editTherapistForm.render(id, therapistForm));
        }
        Therapist.updateTherapist(id, therapistForm.get());
        flash("success", "Sus cambios han sido guardados");
        return therapistList();
    }

    public static Result removeTherapist(int id) {
        if(Therapist.deleteTherapist(id)){
            flash("success", "El terapeuta ha sido eliminado");
        }else{
            //Do Error Message
        }
        return therapistList();
    }





}
