package models;

import play.data.validation.Constraints;
import play.db.ebean.Model;

import javax.persistence.*;
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
//@DiscriminatorValue("aTherapist")
@Table(name="Therapists")
public class Therapist
        extends User  {



    public String nm;
    @Constraints.Required
    public String password;
    @ManyToMany(mappedBy="therapists")
    private List<Patient> patients;


    public static Model.Finder<Integer,Therapist> find = new Model.Finder(Integer.class, Therapist.class);

    public Therapist(final String name, final String surname, final String telephone, final String cellphone,
                     final String address,
                     final String dni, final String mail, Date birthday,  final String nm, final String password,
                     final String image)
    {
        super(name, surname, telephone, cellphone, address, dni, mail, birthday, image);
        this.nm =  nm;
        this.password = password;
        this.patients = new ArrayList<Patient>();
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


    public static Therapist authenticate(String dni, String password) {
        return find.where()
                .eq("dni", dni)
                .eq("password", password)
                .findUnique();
    }


}
