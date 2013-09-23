package controllers;

import com.avaje.ebean.Ebean;
import models.Patient;
import models.Team;

import models.Therapist;
import models.TherapistRole;
import models.Therapist_Role;
import play.data.Form;
import play.mvc.Result;
import views.html.createTeamForm;

import java.util.ArrayList;

import static play.data.Form.form;
import static play.mvc.Controller.flash;
import static play.mvc.Results.badRequest;
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
//        if (Secured.isAdmin()) {
            Form<Team> teamForm = form(Team.class);
            return ok(
                    createTeamForm.render(teamForm)
            );
//        }else{
//            return forbidden();
//        }
    }

    public static Result saveTeam() {

        Form<Team> teamForm = form(Team.class).bindFromRequest();

        if(teamForm.hasErrors()) {
            return badRequest(createTeamForm.render(teamForm));
        }

        Team team = new Team();
        Ebean.save(team);

        //Patient
        String patientDni = teamForm.data().get("paciente");
        String[] patientArray = patientDni.split("-");
        Patient patient = Patient.findPatientByDNI(patientArray[1]);
        team.patient = patient;

        patient.team = team;
        Ebean.save(patient);

        //Supervisor
        String supervisorDni = teamForm.data().get("supervisor");
        String[] supervisorArray = supervisorDni.split("-");
        Therapist supervisor = Therapist.findTherapistByDNI(supervisorArray[1].trim());

        Therapist_Role supervisorRole = new Therapist_Role(supervisor, TherapistRole.SUPERVISOR, team);
        Ebean.save(supervisorRole);

        if(supervisor.team == null){
            supervisor.team = new ArrayList<Therapist_Role>();
        }
        supervisor.team.add(supervisorRole);
        Ebean.save(supervisor);

        //Coordinator
        String coordinatorDni = teamForm.data().get("coordinator");
        String[] coordinatorArray = coordinatorDni.split("-");
        Therapist coordinator = Therapist.findTherapistByDNI(coordinatorArray[1].trim());

        Therapist_Role coordinatorRole = new Therapist_Role(coordinator, TherapistRole.COORDINATOR, team);
        Ebean.save(coordinatorRole);

        if(coordinator.team == null){
            coordinator.team = new ArrayList<Therapist_Role>();
        }
        coordinator.team.add(coordinatorRole);
        Ebean.save(coordinator);


        //Integrator
        String integratorDni = teamForm.data().get("integrator");
        String[] integratorArray = integratorDni.split("-");
        Therapist integrator = Therapist.findTherapistByDNI(integratorArray[1].trim());

        Therapist_Role integratorRole = new Therapist_Role(integrator, TherapistRole.INTEGRATOR, team);
        Ebean.save(integratorRole);

        if(integrator.team == null){
            integrator.team = new ArrayList<Therapist_Role>();
        }
        integrator.team.add(integratorRole);
        Ebean.save(integrator);


        //Therapist
        String therapistDni = teamForm.data().get("therapist");
        String[] therapistArray = therapistDni.split("-");
        Therapist therapist = Therapist.findTherapistByDNI(therapistArray[1].trim());

        Therapist_Role therapistRole = new Therapist_Role(therapist, TherapistRole.THERAPIST, team);
        Ebean.save(therapistRole);

        if(therapist.team == null){
            therapist.team = new ArrayList<Therapist_Role>();
        }
        therapist.team.add(therapistRole);
        Ebean.save(therapist);



        team.therapists.add(supervisorRole);
        team.therapists.add(coordinatorRole);
        team.therapists.add(integratorRole);
        team.therapists.add(therapistRole);

        Ebean.save(team);




        flash("success", "El equipo de trabajo ha sido creado");

        return teamList();
    }

    public static Result teamList() {
        return ok(
                views.html.teams.render(Team.all())
        );

    }


}
