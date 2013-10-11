package controllers;

import com.avaje.ebean.Ebean;
import models.*;
import play.data.Form;
import play.mvc.Controller;
import play.mvc.Result;
import play.mvc.Security;
import views.html.createTherapistForm;
import views.html.editTherapistForm;
import views.html.therapists;


import java.util.ArrayList;
import java.util.List;

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

    public static List<String> allTherapistsByNameAndDni(String dni) {
        List<String> therapists = new ArrayList<String>();
        for(Therapist therapist : Therapist.findByInstitution(Therapist.findTherapistByDNI(dni).institution)){
            therapists.add(therapist.name + " " + therapist.surname + " - " + therapist.dni);
        }

        return therapists;
    }

    public static Result therapistList(Institution institution) {
        return ok(therapists.render(Therapist.findByInstitution(institution)));
    }

    public static Result therapistList() {
        return ok(therapists.render(Therapist.all()));
    }

    public static Result saveTherapist(){
        return saveTherapist(TherapistType.NO_PRIVILEGES, form(Therapist.class).bindFromRequest(), false);
    }

    public static Result saveTherapist(TherapistType type, Form<Therapist> form, boolean autoLogin) {


        Form<Therapist> therapistForm = form;

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

        String hashed = "";
        Institution institution = null;
        if(type == TherapistType.NO_PRIVILEGES){
            String newPassword = "";
            try {
                newPassword = RandomStringGenerator.generateRandomString(6, RandomStringGenerator.Mode.ALPHANUMERIC);
                sendNewUserEmail(therapistFromForm.mail, newPassword);
            } catch (Exception e) {
                e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
            }
            hashed =  BCrypt.hashpw(therapistFromForm.password, BCrypt.gensalt());
            institution = InstitutionController.getInsitutionById(Therapist.findTherapistByDNI(session().get("dni")).institution.id);
        }else{
             hashed = BCrypt.hashpw(therapistFromForm.password, BCrypt.gensalt());
             Address institutionAddress = therapistFromForm.institution.address;
             institution = therapistFromForm.institution;
             Ebean.save(institutionAddress);
             Ebean.save(institution);
        }


        Gender gender = (therapistForm.data().get("genero").equals(Gender.FEMALE.toString()) ? Gender.FEMALE : Gender.MALE);
        String pathFile = UserController.getPathName(therapistFromForm, gender);

        Address address = new Address(therapistFromForm.address.street, therapistFromForm.address.number,
                therapistFromForm.address.floor, therapistFromForm.address.depto, therapistFromForm.address.cp,
                therapistFromForm.address.locality, therapistFromForm.address.province);
        Therapist therapist = new Therapist(therapistFromForm.name, therapistFromForm.surname, therapistFromForm.telephone,
                therapistFromForm.cellphone,address, therapistFromForm.dni, therapistFromForm.mail,therapistFromForm.birthday,
                gender, therapistFromForm.nm, hashed, pathFile, type, institution);


        Ebean.save(address);
        Ebean.save(therapist);
        flash("success", "La terapeuta " + therapistForm.get().name +" " + therapistForm.get().surname + " ya ha sido " +
                "dada de alta");

        if(autoLogin){
            session().clear();
            session("dni", therapist.dni);

        }

        return therapistList(institution);
    }

    private static void sendNewUserEmail(String email, String password) {
        MailService.sendNewUserEmail(email, password);
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
        Address addressForm = therapist.address;
        Address address = realTherapist.address;
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
