package models;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import play.data.validation.Constraints;

import javax.persistence.*;


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

    @Constraints.Required
    private int nm;
    @ManyToMany(mappedBy="therapists")
    private List<Patient> patients;


    public Therapist(final String name, final String telephone, final String address, final int dni,
                     final Date birthday,final int nm) {
        super(name, telephone, address, dni, birthday);
        this.nm =  nm;
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
