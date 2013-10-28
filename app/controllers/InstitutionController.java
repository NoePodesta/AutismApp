package controllers;

import com.avaje.ebean.Ebean;
import models.Address;
import models.Institution;
import models.Therapist;
import play.data.Form;
import play.mvc.Result;
import play.mvc.Controller;

import static play.data.Form.form;

/**
 * Created with IntelliJ IDEA.
 * User: Juanola
 * Date: 10/8/13
 * Time: 4:24 PM
 * To change this template use File | Settings | File Templates.
 */
public class InstitutionController extends Controller {

    public static Institution getInsitutionById(int id){
        return Institution.getById(id);
    }

    public static Result editInstitution(int id){
        Institution insitutionToFill = getInsitutionById(TherapistController.getTherapistById(id).institution.id);
        Form<Institution> institutionForm = form(Institution.class).fill(insitutionToFill);
        return ok(views.html.institution.editInstitution.render(institutionForm));

    }

    public static Result profile(){
        Therapist current = Therapist.findTherapistByDNI(session().get("dni"));
        Institution institution = current.institution;
        Form<Institution> institutionForm = form(Institution.class).fill(institution);
        return ok(views.html.institution.institutionProfile.render(institutionForm));

    }

    public static Result updateInstitution(){

        Form<Institution> institutionForm = form(Institution.class).bindFromRequest();
        Institution institutionFromForm = institutionForm.get();

        if(institutionForm.hasErrors()) {
            return badRequest(views.html.institution.institutionProfile.render(institutionForm));
        }

        Address address = Address.findById(getInsitutionById(institutionFromForm.id).address.id);

        Address addressForm = institutionFromForm.address;
        address.street = addressForm.street;
        address.number = addressForm.number;
        address.floor = addressForm.floor;
        address.depto = addressForm.depto;
        address.cp = addressForm.cp;
        address.locality = addressForm.locality;
        address.province = addressForm.province;

        institutionFromForm.address = address;

        Ebean.update(address);
        Ebean.update(institutionFromForm);
        return profile();

    }
}
