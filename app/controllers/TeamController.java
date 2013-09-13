package controllers;

import models.Team;
import play.data.Form;
import play.mvc.Result;
import views.html.createTeamForm;

import static play.data.Form.form;
import static play.mvc.Results.forbidden;
import static play.mvc.Results.ok;

/**
 * Created with IntelliJ IDEA.
 * User: NoePodesta
 * Date: 12/09/13
 * Time: 20:47
 * To change this template use File | Settings | File Templates.
 */
public class TeamController {

    public static Result createTeam() {
        if (Secured.isAdmin()) {
            Form<Team> teamForm = form(Team.class);
            return ok(
                    createTeamForm.render(teamForm)
            );
        }else{
            return forbidden();
        }
    }
    public static Result teamList() {
        return ok(
                views.html.teams.render(Team.all())
        );

    }
}
