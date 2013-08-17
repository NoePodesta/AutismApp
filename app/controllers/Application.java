package controllers;

import play.mvc.*;

import views.html.*;

public class Application extends Controller {

    public static Result index() {
        return ok(index.render("Your new application is ready."));
    }

    public static Result therapists() {
        return TODO;
    }

    public static Result newTherapist() {
        return TODO;
    }

    public static Result deleteTherapist(Long id) {
        return TODO;
    }

}