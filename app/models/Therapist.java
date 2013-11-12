package models;

import com.avaje.ebean.Ebean;
import com.avaje.ebean.FetchConfig;
import controllers.BCrypt;
import play.data.validation.Constraints;
import play.db.ebean.Model;

import javax.persistence.*;
import javax.validation.constraints.Pattern;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


/**
 * Created with IntelliJ IDEA.
 * User: NoePodesta
 * Date: 17/08/13
 * Time: 12:47
 */

@Entity
@Table(name="Therapists")
public class Therapist
        extends User  {

    @Pattern(regexp = "^([0-9]*)$", message = "Ingrese un número válido")
    public String nm;
    @Constraints.Required
    @Constraints.MinLength(value = 6)
    public String password;
    private TherapistType therapistType;
    @OneToOne
    public Institution institution;
    @ManyToMany
    private List<Team> assignedTeams;
    @OneToMany(cascade = CascadeType.REMOVE)
    public ArrayList<Therapist> testResults;




    public static Model.Finder<Integer,Therapist> find = new Model.Finder(Integer.class, Therapist.class);

    public Therapist(final String name, final String surname, final String telephone, final String cellphone,
                     final Address address,
                     final String dni, final String mail, Date birthday, Gender gender,  final String nm, final String password,
                     final String image, final TherapistType therapistType, Institution institution)
    {
        super(name, surname, telephone, cellphone, address, dni,gender, mail, birthday, image);
        this.nm =  nm;
        this.password = password;
        this.assignedTeams = new ArrayList<Team>();
        this.therapistType = therapistType;
        this.institution = institution;
    }

    public static List<Therapist> all() {
        return find.all();
    }

    public static boolean authenticate(String dni, String password) {
        Therapist therapist = find.where().eq("dni", dni).findUnique();
        if(therapist != null){
            if(BCrypt.checkpw(password, therapist.password)){
                return true;
            }
        }
        return false;
    }

    public static Therapist findTherapistByDNI(String dni) {
        return find.where()
                .eq("dni", dni)
                .findUnique();
    }


    public static void save(Therapist therapist) {
        therapist.save();
        Ebean.save(therapist);
    }


    public static boolean isAdmin(String dni) {
        Therapist therapist =  find.where().eq("dni", dni).findUnique();
        if(therapist != null){
            return therapist.therapistType.name().equals(TherapistType.ADMIN.name());
        }
        return false;

    }

    public static Therapist findTherapistById(int id){
        return find.byId(id);
    }

    public static void updateTherapist(int id, Therapist therapist) {
        therapist.update(id);
    }

    public static boolean delete(int id) {
        Therapist therapistToDelete = findTherapistById(id);
        if(therapistToDelete != null){
            therapistToDelete.delete();
            return true;
        }else{
            return false;
        }

    }

    public static List<String> allTherapistsByName() {
        List<String> therapists = new ArrayList<String>();
        for(Therapist therapist : Therapist.all()){
            therapists.add(therapist.name + " " + therapist.surname);
        }

        return therapists;
    }

    public static List<String> allTherapistsByNameAndDni() {
        List<String> therapists = new ArrayList<String>();
        for(Therapist therapist : Therapist.all()){
            therapists.add(therapist.name + " " + therapist.surname + " - " + therapist.dni);
        }

        return therapists;
    }

    public TherapistType getTherapistType() {
        return therapistType;
    }

    public void setTherapistType(TherapistType therapistType) {
        this.therapistType = therapistType;
    }

    public static List<Therapist> findByInstitutionId(int institutionId) {
        Institution institution = Institution.getById(institutionId);
        return find.where()
                .eq("institution", institution)
                .findList();
    }

    public static List<Therapist> findByInstitution(Institution institution) {
        return find.where()
                .eq("institution", institution)
                .findList();
    }

    public List<Team> getAssignedTeams() {
        return assignedTeams;
    }

    public void setAssignedTeams(List<Team> assignedTeams) {
        this.assignedTeams = assignedTeams;
    }


    public void addToTeam(Team team) {
        for(Team teamToAnalyze : assignedTeams){
            if(teamToAnalyze.id == team.id){
                return;
            }
        }
        assignedTeams.add(team);
    }


}
