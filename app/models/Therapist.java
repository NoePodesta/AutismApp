package models;

import play.data.validation.Constraints;
import play.db.ebean.Model;

import javax.persistence.*;
import java.util.Date;
import java.util.List;


/**
 * Created with IntelliJ IDEA.
 * User: NoePodesta
 * Date: 17/08/13
 * Time: 12:47
 */

@Entity
@Table(name="Therapist")
//@DiscriminatorValue("aTherapist")
public class Therapist
        extends User  {



    public int nm;
    @Constraints.Required
    public String password;
    @ManyToMany(mappedBy="therapists")
    private List<Patient> patients;

    //private String dummy;


    public static Model.Finder<Integer,Therapist> find = new Model.Finder(Integer.class, Therapist.class);

    public Therapist(final String name, final String surname, final String telephone, final String address,
                     final int dni, final String mail, Date birthday,  final int nm, final String password)
    {
        super(name, surname, telephone, address, dni, mail, birthday);
        this.nm =  nm;
        this.password = password;
        //this.patients = new ArrayList<Patient>();
    }

    public void addPatient(Patient patient){
        patients.add(patient);
    }

    public void remove(Patient patient){
        patients.remove(patient);
    }

    public static List<Therapist> all() {
        return find.all();
    }


    public static Therapist authenticate(int dni, String password) {
        return find.where()
                .eq("dni", dni)
                .eq("password", password)
                .findUnique();
    }


}
