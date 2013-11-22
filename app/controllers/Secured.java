package controllers;


import models.Therapist;
import msg.Msg;
import play.mvc.Http.Context;
import play.mvc.Result;
import play.mvc.Security;

/**
 * Created with IntelliJ IDEA.
 * User: Juani
 * Date: 9/6/13
 * Time: 1:41 AM
 */

public class Secured extends Security.Authenticator {

    @Override
    public String getUsername(Context ctx) {
        return ctx.session().get(Msg.DNI);
    }

    @Override
    public Result onUnauthorized(Context ctx) {
        return redirect(routes.Application.login());
    }

    public static boolean isAdmin() {
        return Therapist.isAdmin(Application.getCurrentTherapist().dni);
    }
}
