package models;

import com.avaje.ebean.Ebean;
import play.db.ebean.Model;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: Juani
 * Date: 9/11/13
 * Time: 11:59 PM
 */

@Entity
@Table(name="Teams")
public class Team extends Model {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public int id;
    @OneToOne
    public Patient patient;
    @OneToOne
    public Institution institution;

    private List<TeamRoles> teamRoles;






    public Team(){
        teamRoles = new ArrayList<TeamRoles>();
    }

    public static Model.Finder<Integer,Team> find = new Model.Finder(Integer.class, Team.class);

    public static List<Team> all() {
        return find.all();
    }

    public Therapist getSupervisor(){
        for(TeamRoles role : teamRoles){
            if(role.role.equals(TherapistRole.SUPERVISOR.toString())){
                return role.therapist;
            }
        }
        return null;
    }

    public Therapist getCoordinator(){
        for(TeamRoles role : teamRoles){
            if(role.role.equals(TherapistRole.COORDINATOR.toString())){
                return role.therapist;
            }
        }
        return null;
    }

    public Therapist getTherapists(){
        /*
        ArrayList<Therapist> therapists = new ArrayList<Therapist>();
        for(int i = 3;i<assignedTherapists.size();i++){
            therapists.add(assignedTherapists.get(i));
        }
         */
        for(TeamRoles role : teamRoles){
            if(role.role.equals(TherapistRole.THERAPIST.toString())){
                return role.therapist;
            }
        }
        return null;
    }

    public Therapist getIntegrator(){
        for(TeamRoles role : teamRoles){
            if(role.role.equals(TherapistRole.INTEGRATOR.toString())){
                return role.therapist;
            }
        }
        return null;
    }


    public Patient getPatient(){
       return patient;
    }

    public static boolean deleteTeam(int id) {
        Team teamToDelete = findTeamById(id);
        if(teamToDelete != null){
            teamToDelete.delete();
            return true;
        }else{
            return false;
        }

    }

    public static Team findTeamById(int id) {
        return find.byId(id);  //To change body of created methods use File | Settings | File Templates.
    }

    public static void updateTeam(Team team) {
        team.update();
    }

    public static List<Team> findByInstitution(Institution institution) {
        return find.where().eq("institution", institution).findList();  //To change body of created methods use File | Settings | File Templates.
    }

    public List<TeamRoles> getTeamRoles() {
        return teamRoles;
    }

    public void setTeamRoles(List<TeamRoles> teamRoles) {
        this.teamRoles = teamRoles;
    }


    public void setPatient(Patient patient) {
        this.patient = patient;
    }
}
