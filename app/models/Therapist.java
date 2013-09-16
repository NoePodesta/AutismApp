package models;

import com.avaje.ebean.Ebean;
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
    @ManyToOne
    private List<Therapist_Role> team;
    @Enumerated(EnumType.STRING)
    private TherapistType therapistType;


    public static Model.Finder<Integer,Therapist> find = new Model.Finder(Integer.class, Therapist.class);

    public Therapist(final String name, final String surname, final String telephone, final String cellphone,
                     final Address address,
                     final String dni, final String mail, Date birthday, Gender gender,  final String nm, final String password,
                     final String image, final TherapistType therapistType)
    {
        super(name, surname, telephone, cellphone, address, dni,gender, mail, birthday, image);
        this.nm =  nm;
        this.password = password;
        this.team = new ArrayList<Therapist_Role>();
        this.therapistType = therapistType;
    }

    public static List<Therapist> all() {
        return find.all();
    }

    public static Therapist authenticate(String dni, String password) {
        return find.where()
                .eq("dni", dni)
                .eq("password", password)
                .findUnique();
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
        return therapist.therapistType.name().equals(TherapistType.ADMIN.name());
    }

    public static Therapist findTherapistById(int id){
        return find.byId(id);
    }

    public static void updateTherapist(int id, Therapist therapist) {
        therapist.update(id);
    }

    public static boolean deleteTherapist(int id) {
        Therapist therapistToDelete = findTherapistById(id);
        if(therapistToDelete != null){
            therapistToDelete.delete();
            return true;
        }else{
            return false;
        }

    }

    public TherapistType getTherapistType() {
        return therapistType;
    }

    public void setTherapistType(TherapistType therapistType) {
        this.therapistType = therapistType;
    }
}
