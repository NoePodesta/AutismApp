package models;

import com.avaje.ebean.Ebean;
import play.db.ebean.Model;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Juani
 * Date: 9/11/13
 * Time: 11:59 PM
 */

@Entity
@Table
public class Team extends Model {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public int id;
    @OneToOne
    public Patient patient;
    @OneToMany(cascade = CascadeType.REMOVE)
    public List<Therapist_Role> therapists;

    @ManyToOne
    public Institution institution;



    public Team(){
        therapists = new ArrayList<Therapist_Role>();
    }

    public static Model.Finder<Integer,Team> find = new Model.Finder(Integer.class, Team.class);

    public static List<Team> all() {
        return find.all();
    }

    public Therapist getSupervisor(){

        for(Therapist_Role therapistRole : therapists){
            if(therapistRole.getRole().equals(TherapistRole.SUPERVISOR)){
                return therapistRole.getTherapist();
            }
        }
        return null;
    }

    public Therapist getCoordinator(){

        for(Therapist_Role therapistRole : therapists){
            if(therapistRole.getRole().equals(TherapistRole.COORDINATOR)){
                return therapistRole.getTherapist();
            }
        }
        return null;
    }

    public List<Therapist> getTherapists(){

        List<Therapist> therapistsList = new ArrayList<Therapist>();
        for(Therapist_Role therapistRole : therapists){
            if(therapistRole.getRole().equals(TherapistRole.THERAPIST)){
                therapistsList.add(therapistRole.getTherapist());
            }
        }
        return therapistsList;
    }

    public Therapist getIntegrator(){

        for(Therapist_Role therapistRole : therapists){
            if(therapistRole.getRole().equals(TherapistRole.INTEGRATOR)){
                return therapistRole.getTherapist();
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
}
