package controllers;

import com.avaje.ebean.Ebean;
import models.Gender;
import models.Therapist;
import models.TherapistType;
import models.User;
import play.data.Form;
import play.mvc.Controller;
import play.mvc.Result;
import play.mvc.Security;
import views.html.createTherapistForm;
import views.html.editTherapistForm;
import views.html.therapists;


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

        // Check if the dni is valid
        if(!therapistForm.hasErrors()) {
            if(Therapist.findTherapistByDNI(therapistForm.get().dni) != null) {
                therapistForm.reject("dni", "Ya se ha ingresado este dni");
            }
        }

        if(therapistForm.hasErrors()) {
            return badRequest(createTherapistForm.render(therapistForm));
        }

        Therapist therapistFromForm = therapistForm.get();

        Gender gender = (therapistForm.data().get("genero").equals(Gender.FEMALE.toString()) ? Gender.FEMALE : Gender.MALE);

        String pathFile = UserController.getPathName(therapistFromForm, gender);

        User.Address address = new User.Address(therapistFromForm.address.street,therapistFromForm.address.number,
                therapistFromForm.address.floor, therapistFromForm.address.depto,therapistFromForm.address.cp,
                therapistFromForm.address.locality,therapistFromForm.address.province);

        Therapist therapist = new Therapist(therapistFromForm.name, therapistFromForm.surname, therapistFromForm.telephone,
                therapistFromForm.cellphone,address, therapistFromForm.dni, therapistFromForm.mail,therapistFromForm.birthday,
                gender, therapistFromForm.nm, therapistFromForm.password, pathFile, type);

        Ebean.save(address);
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

        Therapist realTherapist = Therapist.findTherapistById(id);
        Therapist therapist = therapistForm.get();
        User.Address addressForm = therapist.address;
        User.Address address = realTherapist.address;
        address.street = addressForm.street;
        address.number = addressForm.number;
        address.floor = addressForm.floor;
        address.depto = addressForm.depto;
        address.cp = addressForm.cp;
        address.locality = addressForm.locality;
        address.province = addressForm.province;

        Ebean.update(realTherapist.address);
        Ebean.update(realTherapist);


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
