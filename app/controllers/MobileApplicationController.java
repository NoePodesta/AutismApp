package controllers;

import com.avaje.ebean.Ebean;
import models.*;
import org.codehaus.jackson.node.ArrayNode;
import org.codehaus.jackson.node.JsonNodeFactory;

import models.Therapist;
import msg.Msg;
import org.codehaus.jackson.node.ObjectNode;
import play.mvc.Controller;
import play.mvc.Result;
import java.util.Date;

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
        JsonNodeFactory factory = JsonNodeFactory.instance;
        ObjectNode result = new ObjectNode(factory);
        ArrayNode patients = new ArrayNode(factory);
        ArrayNode patientsId = new ArrayNode(factory);
        ArrayNode packages = new ArrayNode(factory);

        if(Therapist.authenticate(username,password)){
            Therapist therapist = Therapist.findTherapistByDNI(username);

            if(therapist.getAssignedTeams() != null){
                for(Team team : therapist.getAssignedTeams()){
                    patients.add(team.patient.name);
                    patientsId.add(team.patient.id);
                }
            }


           for(GamePackage gamePackage : GamePackage.findByTherapist(therapist)){
                ObjectNode gamePackageJson =  new ObjectNode(factory);
                gamePackageJson.put("packageName", gamePackage.getPackageName());
                gamePackageJson.put("packageUrl", gamePackage.getPackageUrl());
                gamePackageJson.put("packageType",gamePackage.getGameType().toString());
                packages.add(gamePackageJson);
           }


            result.put("id", therapist.id);
            result.put("dni", therapist.dni);
            result.put("loggedComplete", true);
            result.put("name",therapist.name);
            result.put("surname", therapist.surname);
            result.put("patients",patients);
            result.put("patientsId",patientsId);
            result.put("packages", packages);

            return ok(result);
       }else{
           result.put("loggedComplete", false);
           return ok(result);

       }
    }
    public static Result saveResults(){
        final Map<String, String[]> values = request().body().asFormUrlEncoded();
        String gameType = values.get("gameType")[0];
        String therapistId = values.get("therapistId")[0];
        String patientId = values.get("patientId")[0];
        Date date = new Date(values.get("currentDate")[0]);
        TestResult testResult;
        if(!gameType.equals(Game.BITACORA)){
            String correctAnswers = values.get("correctAnswers")[0];
            String wrongAnswers =  values.get("wrongAnswers")[0];


            testResult = new TestResult(Game.valueOf(gameType),Patient.findPatientById(Integer.parseInt(patientId)),
                                                         Therapist.findTherapistById(Integer.parseInt(therapistId)),Integer.parseInt(correctAnswers),
                                                        Integer.parseInt(wrongAnswers), date, GamePackage.findPackageById(1),"");
            Ebean.save(testResult);
        }else{
            String bitacoraText = values.get("bitacoraText")[0];
            testResult =   new TestResult(Game.valueOf(gameType),Patient.findPatientById(Integer.parseInt(patientId)),
                    Therapist.findTherapistById(Integer.parseInt(therapistId)),-1,
                   -1, date, GamePackage.findPackageById(1),bitacoraText);

         }

        return ok("save complete");
    }
}
