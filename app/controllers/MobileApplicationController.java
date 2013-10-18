package controllers;

import models.Therapist;
import play.mvc.Controller;
import play.mvc.Result;

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

        if(Therapist.authenticate(username,password)){
           return ok("Login Successfull");
       }else{
           return ok("Login failed");
       }
    }
}
