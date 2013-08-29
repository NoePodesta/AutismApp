package models;

import play.data.validation.Constraints;

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
@Table(name = "Therapists")
public class Therapist
        extends User  {

    public int nm;
    @Column(name = "Password")
    @Constraints.Required
    public String pass;
    @ManyToMany(mappedBy="therapists")
    private List<Patient> patients;


    public Therapist(final String name, final String surname, final String telephone, final String address,
                     final int dni, final String mail, Date birthday,  final int nm, final String password)
    {
        super(name, surname, telephone, address, dni, mail, birthday);
        this.nm =  nm;
        this.pass = password;
        this.patients = new ArrayList<Patient>();
    }

    public void addPatient(Patient patient){
        patients.add(patient);
    }

    public void remove(Patient patient){
        patients.remove(patient);
    }

    public static List<Therapist> all() {
        return new ArrayList<Therapist>();
    }



}
