package controllers;

import com.avaje.ebean.Ebean;
import models.*;

import msg.Msg;
import play.data.Form;
import play.mvc.Controller;
import play.mvc.Http;
import play.mvc.Result;
import play.mvc.Security;


import java.util.ArrayList;


import static play.data.Form.form;
/**
 * Created with IntelliJ IDEA.
 * User: NoePodesta
 * Date: 12/09/13
 * Time: 20:47
 * To change this template use File | Settings | File Templates.
 */
@Security.Authenticated(Secured.class)
public class TeamController extends Controller {

    public static Result createTeam(int patientId) {
        if (Secured.isAdmin()) {
            Form<Team> teamForm = form(Team.class);
            return ok(
                    views.html.team.createTeamForm.render(teamForm, Patient.findPatientById(patientId)));
        }else{
            return forbidden();
        }
    }

    public static Result saveTeam() {
        Form<Team> teamForm = form(Team.class).bindFromRequest();

        String patientId = teamForm.data().get(Msg.PATIENT);
        Patient patient = Patient.findPatientById(patientId);


        if(teamForm.hasErrors()) {
            return badRequest( views.html.team.createTeamForm.render(teamForm, patient));
        }

        Team team = new Team();


        //Patient
        team.patient = patient;
        patient.team = team;

        String patientName =  patient.name + " " + patient.surname;

        //Institution
        team.institution = patient.institution;
        Ebean.save(team);

        //Supervisor
        String supervisorDni = teamForm.data().get(Msg.SUPERVISOR);
        String[] supervisorArray = supervisorDni.split("-");
        Therapist supervisor = Therapist.findTherapistByDNI(supervisorArray[1].trim());
        if(supervisor.getAssignedTeams()!=null){
            supervisor.addToTeam(team);
        }else{
            supervisor.setAssignedTeams(new ArrayList<Team>());
            supervisor.getAssignedTeams().add(team);
        }
        TeamRoles supervisorRole = new TeamRoles();
        supervisorRole.role = TherapistRole.SUPERVISOR.toString();
        supervisorRole.therapist = supervisor;
        supervisorRole.team = team;
        Ebean.save(supervisorRole);
        team.getTeamRoles().add(supervisorRole);
        MailService.sendNewTeamMail(Msg.SUPERVISOR, supervisor.mail, patientName);
        Ebean.update(supervisor);

        //Coordinator
        String coordinatorDni = teamForm.data().get(Msg.COORDINATOR);
        String[] coordinatorArray = coordinatorDni.split("-");
        Therapist coordinator = Therapist.findTherapistByDNI(coordinatorArray[1].trim());
        if(coordinator.getAssignedTeams()!=null){
            coordinator.addToTeam(team);
        }else{
            coordinator.setAssignedTeams(new ArrayList<Team>());
            coordinator.getAssignedTeams().add(team);
        }
        // team.getAssignedTherapists().add(1, coordinator);
        TeamRoles coordinatorRole = new TeamRoles();
        coordinatorRole.role = TherapistRole.COORDINATOR.toString();
        coordinatorRole.therapist = coordinator;
        coordinatorRole.team = team;
        Ebean.save(coordinatorRole);
        team.getTeamRoles().add(coordinatorRole);
        MailService.sendNewTeamMail(Msg.COORDINADOR, coordinator.mail, patientName);
        Ebean.update(coordinator);


        //Integrator
        String integratorDni = teamForm.data().get(Msg.INTEGRATOR);
        String[] integratorArray = integratorDni.split("-");
        Therapist integrator = Therapist.findTherapistByDNI(integratorArray[1].trim());
        if(integrator.getAssignedTeams()!=null){
            integrator.addToTeam(team);
        }else{
            integrator.setAssignedTeams(new ArrayList<Team>());
            integrator.getAssignedTeams().add(team);
        }
        TeamRoles integratorRole = new TeamRoles();
        integratorRole.role = TherapistRole.INTEGRATOR.toString();
        integratorRole.therapist = integrator;
        integratorRole.team = team;
        Ebean.save(integratorRole);
        team.getTeamRoles().add(integratorRole);
        MailService.sendNewTeamMail(Msg.INTEGRADOR, integrator.mail, patientName);

        Ebean.update(integrator);

        //Therapist
        String therapistDni = teamForm.data().get(Msg.THERAPISTE);
        String[] therapistArray = therapistDni.split("-");
        Therapist therapist = Therapist.findTherapistByDNI(therapistArray[1].trim());
        if(therapist.getAssignedTeams()!=null){
            therapist.addToTeam(team);
        }else{
            therapist.setAssignedTeams(new ArrayList<Team>());
            therapist.getAssignedTeams().add(team);
        }
        TeamRoles therapistRole = new TeamRoles();
        therapistRole.role = TherapistRole.THERAPIST.toString();
        therapistRole.therapist = integrator;
        therapistRole.team = team;
        Ebean.save(therapistRole);
        team.getTeamRoles().add(therapistRole);
        MailService.sendNewTeamMail(Msg.THERAPIST, therapist.mail, patientName);
        Ebean.update(therapist);

        Ebean.update(team);
        Ebean.update(patient);
        flash(Msg.SUCCESS, Msg.TEAM_CREATED);

        return PatientController.patientProfile(patient.id);
    }

    public static Result teamList() {
        return TODO;
              // views.html.team.teams.render(Team.findByInstitution(TherapistController.getTherapistByDNI(session().get("dni")).institution))
        //);

    }

    public static Result editTeam(int id) {
        Team teamToFill = Team.findTeamById(id);
        Form<Team> teamForm = form(Team.class).fill(teamToFill);
        return ok(views.html.team.editTeamForm.render(teamForm));
    }

    public static Result removeTeam(int id){
        Patient patient = Team.findTeamById(id).patient;
        if(Team.deleteTeam(id)){
            flash(Msg.SUCCESS, Msg.REMOVE(Msg.TEAM));
        }else{
            //Do Error Message
        }
        return PatientController.patientProfile(patient.id);
    }

    public static Result updateTeam(){
        /*
        Team team = form(Team.class).bindFromRequest().get();
        Ebean.update(team);
        */
        return TODO;
    }


}