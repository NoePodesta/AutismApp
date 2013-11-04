package controllers;

import models.Patient;
import models.Therapist;
import org.codehaus.jackson.node.ArrayNode;
import org.codehaus.jackson.node.ObjectNode;
import play.mvc.Controller;
import play.mvc.Result;
import play.libs.Json;

import java.util.ArrayList;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: Juanola
 * Date: 10/18/13
 * Time: 4:49 AM
 * To change this template use File | Settings | File Templates.
 */
public class MobileApplicationController extends Controller {

    public static Result testConnection(){
        return ok("Prueba Completa");
    }

    public static Result loginMobile(){
        final Map<String, String[]> values = request().body().asFormUrlEncoded();
        String username = values.get("username")[0];
        String password = values.get("password")[0];
        ObjectNode result = Json.newObject();
        if(Therapist.authenticate(username,password)){
            Therapist therapist = Therapist.findTherapistByDNI(username);

            if(therapist.getTeam() != null){

                for(int i = 0;i<therapist.team.size();i++){
                    Patient patient = PatientController.getByTeam(therapist.team.get(i).team);

                }


            }

            result.put("loggedComplete", true);
            result.put("name",therapist.name);
            result.put("surname", therapist.surname);


            return ok(result);
       }else{
           result.put("loggedComplete", false);
           return ok(result);
       }
    }
}
