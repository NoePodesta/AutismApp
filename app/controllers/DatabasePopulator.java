package controllers;

import com.avaje.ebean.Ebean;
import models.*;
import play.mvc.Controller;
import play.mvc.Result;

import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: Juanola
 * Date: 10/15/13
 * Time: 2:23 PM
 * To change this template use File | Settings | File Templates.
 */
public class DatabasePopulator extends Controller {

    public static Result populateTherapistDatabase(){
        Address institutionAddress = new Address("Libertad","1250","3","D","1638","Vicente Lopez","Buenos Aires");
        Address therapistAddress = new Address("Cabildo","1250","3","D","1638","Vicente Lopez","Buenos Aires");
        Institution institution = new Institution("Dacaid",institutionAddress,"47911234");

        Therapist therapist = new Therapist("Juan","Molteni","47911306","123",therapistAddress,"33850398","juanignaciomolteni@gmail.com",new Date(), Gender.MALE,"asd",BCrypt.hashpw("123456", BCrypt.gensalt()),"", TherapistType.ADMIN,institution);

        Ebean.save(institutionAddress);
        Ebean.save(therapistAddress);
        Ebean.save(institution);
        Ebean.save(therapist);


        Therapist therapist3 = new Therapist("Juan","Molteni","47911306","123",therapistAddress,"33850396","juanignaciomolteni@gmail.com",new Date(), Gender.MALE,"asd",BCrypt.hashpw("123456", BCrypt.gensalt()),"", TherapistType.NO_PRIVILEGES,institution);
        Therapist therapist2 = new Therapist("Juan","Molteni","47911306","123",therapistAddress,"33850397","juanignaciomolteni@gmail.com",new Date(), Gender.MALE,"asd",BCrypt.hashpw("123456", BCrypt.gensalt()),"", TherapistType.NO_PRIVILEGES,institution);

        Ebean.save(therapist3);
        Ebean.save(therapist2);

        return Application.login();
    }
}
