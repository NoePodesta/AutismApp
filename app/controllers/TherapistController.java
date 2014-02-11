package controllers;

import com.avaje.ebean.Ebean;
import models.*;
import msg.Msg;
import play.data.Form;
import play.mvc.Controller;
import play.mvc.Result;
import play.mvc.Security;
import views.html.signUpAdmin;


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
                    views.html.therapist.createTherapistForm.render(therapistForm)
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
        ArrayList<Therapist> therapistsToShow = new ArrayList<Therapist>();
        Therapist current = Therapist.findTherapistByDNI(session().get("dni"));
        for(Therapist therapist : Therapist.findByInstitution(institution)){
            if(therapist.id != current.id){
                therapistsToShow.add(therapist);
            }
        }
        return ok(views.html.therapist.therapists.render(therapistsToShow));
    }

    public static Result therapistList() {
        ArrayList<Therapist> therapistsToShow = new ArrayList<Therapist>();
        Therapist current = Therapist.findTherapistByDNI(session().get("dni"));
        for(Therapist therapist : Therapist.findByInstitution(current.institution)){
            if(therapist.id != current.id){
                therapistsToShow.add(therapist);
            }
        }
        return ok(views.html.therapist.therapists.render(therapistsToShow));
    }

    public static Result saveTherapist(){
        return saveTherapist(TherapistType.NO_PRIVILEGES, form(Therapist.class).bindFromRequest(), false,
                Application.getCurrentTherapist().institution);
    }

    public static Result updateTherapistImage(){

        Therapist therapist = Therapist.findTherapistByDNI(session().get(Msg.DNI));
        String pathFile = ImageController.getUserImagePathName(therapist, therapist.gender);
        therapist.image = pathFile;
        Ebean.save(therapist);

        return profile();

    }

    public static Result saveTherapist(TherapistType type, Form<Therapist> therapistForm, boolean autoLogin,
                                       Institution institution) {


        Therapist therapistFromForm = null;
        String hashed = "";
        if(type == TherapistType.NO_PRIVILEGES){
            if(therapistForm.hasErrors()) {
                return badRequest(views.html.therapist.createTherapistForm.render(therapistForm));
            }else{
                if(Therapist.findTherapistByDNI(therapistForm.get().dni) != null) {
                    therapistForm.reject(Msg.DNI, Msg.CHECK_DNI);
                }
            }
            therapistFromForm = therapistForm.get();
            String newPassword = "";
            try {
                newPassword = RandomStringGenerator.generateRandomString(6, RandomStringGenerator.Mode.ALPHANUMERIC);
                sendNewUserEmail(therapistFromForm.mail, newPassword);
            } catch (Exception e) {
                e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
            }
            hashed =  BCrypt.hashpw(newPassword, BCrypt.gensalt());
        }else{
             therapistFromForm = therapistForm.get();
             hashed = BCrypt.hashpw(therapistFromForm.password, BCrypt.gensalt());
        }


        Gender gender = (therapistForm.data().get(Msg.GENERO).equals(Gender.FEMALE.toString()) ? Gender.FEMALE : Gender.MALE);
        String pathFile = ImageController.getUserImagePathName(therapistFromForm, gender);

        Address address = new Address(therapistFromForm.address.street, therapistFromForm.address.number,
                therapistFromForm.address.floor, therapistFromForm.address.depto, therapistFromForm.address.cp,
                therapistFromForm.address.locality, therapistFromForm.address.province);
        Therapist therapist = new Therapist(therapistFromForm.name, therapistFromForm.surname, therapistFromForm.telephone,
                therapistFromForm.cellphone,address, therapistFromForm.dni, therapistFromForm.mail,therapistFromForm.birthday,
                gender, therapistFromForm.nm, hashed, pathFile, type, institution);


        Ebean.save(address);
        Ebean.save(therapist);
        flash(Msg.SUCCESS, Msg.ADDED(Msg.THERAPIST,therapistForm.get().name,therapistForm.get().surname));

        if(autoLogin){
            session().clear();
            session(Msg.DNI, therapist.dni);

        }

        return therapistList(institution);
    }

    private static void sendNewUserEmail(String email, String password) {
        MailService.sendNewUserEmail(email, password);
    }

    public static Result editTherapist(int id) {
        Therapist therapistToFill = Therapist.findTherapistById(id);
        Form<Therapist> therapistForm = form(Therapist.class).fill(therapistToFill);
        if(therapistToFill.dni.equals(session().get(Msg.DNI))){
            return ok(views.html.therapist.editTherapistForm.render(id, therapistForm, true));
        }else{
            return ok(views.html.therapist.editTherapistForm.render(id, therapistForm, false));
        }
    }


    /**
     * Handle the 'edit form' submission
     *
     *
     */
    public static Result updateTherapist() {
        Form<Therapist> therapistForm = form(Therapist.class).bindFromRequest();
        //Declarado asi por un bug de play
        if(therapistForm.hasErrors()) {
            String id = therapistForm.data().get(Msg.ID);
            Therapist therapist = Therapist.findTherapistById(Integer.parseInt(id));
            if(therapist.dni.equals(session().get(Msg.DNI))){
                return badRequest(views.html.therapist.editTherapistForm.render(therapist.id, therapistForm, true));
            }else{
                return badRequest(views.html.therapist.editTherapistForm.render(therapist.id, therapistForm, false));
            }

        }
        Therapist therapist = therapistForm.get();
        String newPassword = BCrypt.hashpw(therapist.password, BCrypt.gensalt());
        therapist.password = newPassword;

        Address address = Address.findById(Therapist.findTherapistById(therapist.id).address.id);

        Address addressForm = therapist.address;
        address.street = addressForm.street;
        address.number = addressForm.number;
        address.floor = addressForm.floor;
        address.depto = addressForm.depto;
        address.cp = addressForm.cp;
        address.locality = addressForm.locality;
        address.province = addressForm.province;

        therapist.address = address;

        Ebean.update(address);
        Ebean.update(therapist);


        flash(Msg.SUCCESS, Msg.CHANGES_SAVED);
        return therapistList();
    }

    public static Result updateTherapistPassword() {
        Form<Therapist> therapistForm = form(Therapist.class).bindFromRequest();
        //Declarado asi por un bug de play

        if(therapistForm.hasErrors()) {
            return TODO;

        }

        Therapist therapist = therapistForm.get();
        String newPassword = BCrypt.hashpw(therapist.password, BCrypt.gensalt());
        therapist.password = newPassword;


        Ebean.update(therapist);

        flash(Msg.SUCCESS, Msg.CHANGES_SAVED);
        return therapistList();
    }

    public static Result editTherapistPassword(int id){
        Therapist therapistToFill = Therapist.findTherapistById(id);
        Form<Therapist> therapistForm = form(Therapist.class).fill(therapistToFill);
        return ok(views.html.therapist.editTherapistPassword.render(id, therapistForm));
    }

    public static Result removeTherapist(int id) {
        if(Therapist.delete(id)){
            flash(Msg.SUCCESS, Msg.REMOVE(Msg.THERAPIST));
        }else{
            //Do Error Message
        }
        return therapistList();
    }

    public static Therapist getTherapistByDNI(String dni) {
        return Therapist.findTherapistByDNI(dni);
    }


    public static String updatePassword(Therapist therapist) {
        String newPassword = "";
        try {
            newPassword = RandomStringGenerator.generateRandomString(6, RandomStringGenerator.Mode.ALPHANUMERIC);
        } catch (Exception e) {
            e.printStackTrace();
        }
        therapist.password = BCrypt.hashpw(newPassword, BCrypt.gensalt());
        Ebean.update(therapist);

        return newPassword;
    }

    public static Result profile() {
        return ok(views.html.therapist.profile.render(Application.getCurrentTherapist()));
    }

    public static Result therapistProfile(int id){
        Therapist therapist = Therapist.findTherapistById(id);
        return ok(views.html.therapist.profile.render(therapist));
    }

    public static Therapist getTherapistById(int id) {
        return Therapist.findTherapistById(id);  //To change body of created methods use File | Settings | File Templates.
    }
}
