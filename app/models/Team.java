package models;

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
    private int id;
    @OneToOne
    public Patient patient;
    @OneToMany
    private List<Therapist_Role> therapists;


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

}
