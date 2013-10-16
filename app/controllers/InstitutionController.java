package controllers;

import com.avaje.ebean.Ebean;
import models.Address;
import models.Institution;
import models.Therapist;
import play.data.Form;
import play.mvc.Result;
import play.mvc.Controller;
import views.html.editInstitution;

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
        return ok(editInstitution.render(institutionForm));

    }

    public static Result updateInstitution(){
        Institution institutionFromForm = form(Institution.class).bindFromRequest().get();

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
        return TherapistController.profile();

    }
}
