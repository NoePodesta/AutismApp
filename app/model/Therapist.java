package model;

import java.util.ArrayList;
import java.util.List;
import model.Patient;

/**
 * Created with IntelliJ IDEA.
 * User: NoePodesta
 * Date: 17/08/13
 * Time: 12:47
 */
public class Therapist
        extends User  {

    private int id;
    private int nm;
    private List<Patient> patients;


    public Therapist(final String name, final String telephone, final String address, final int dni, final int nm) {
        super(name, telephone, address, dni);
        this.patients = new ArrayList<Patient>();
    }

    public void addPatient(Patient patient){
        patients.add(patient);
    }

    public void remove(Patient patient){
        patients.remove(patient);
    }


}
