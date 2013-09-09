package controllers;


import models.Therapist;
import play.mvc.Http.Context;
import play.mvc.Result;
import play.mvc.Security;

/**
 * Created with IntelliJ IDEA.
 * User: Juani
 * Date: 9/6/13
 * Time: 1:41 AM
 * To change this template use File | Settings | File Templates.
 */
public class Secured extends Security.Authenticator {

    @Override
    public String getUsername(Context ctx) {
        return ctx.session().get("dni");
    }

    @Override
    public Result onUnauthorized(Context ctx) {
        return redirect(routes.Application.login());
    }

    public static boolean isAdmin() {
        return Therapist.isAdmin(Context.current().request().username());
    }
}
