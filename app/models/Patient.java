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
 * Time: 12:48

 */

@Entity
@Table(name="Patients")
public class Patient
        extends User {


    @Constraints.Required
    private String medicalCoverage;
    @Constraints.Required
    private String nMedicalCoverage;
    @Constraints.Required
    private String disease;
    @Constraints.Required
    private int gradeDisease;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "patient",
            fetch = FetchType.LAZY)
    private List<Results> progress;
    @OneToOne
    public Team team;
    private int qAwardA;
    private int qAwardB;
    private int qAwardC;



    public Patient(final String name, final String surname, final String telephone, final String cellphone,
                   final Address address, final String dni, final Gender gender,
                   final String mail, final Date birthday,
                   final String medicalCoverage, final String nMedicalCoverage, final String disease,
                   int gradeDisease, final String image) {

        super(name, surname, telephone, cellphone, address, dni, gender, mail, birthday, image);
        this.medicalCoverage = medicalCoverage;
        this.nMedicalCoverage = nMedicalCoverage;
        this.disease = disease;
        this.gradeDisease = gradeDisease;
        this.progress = new ArrayList<Results>();
        this.qAwardA = 0;
        this.qAwardB = 0;
        this.qAwardC = 0;
    }

    public static Model.Finder<Integer,Patient> find = new Model.Finder(Integer.class, Patient.class);


    public void gainAwardA(int value){
        qAwardA = qAwardA+value;
    }

    public void gainAwardB(int value){
        qAwardB = qAwardB+value;
    }

    public void gainAwardC(int value){
        qAwardC = qAwardC+value;
    }

    public static List<Patient> all() {
        return find.all();
    }

    public static List<String> allPatientsByName() {
        List<String> patients = new ArrayList<String>();
        for(Patient patient : Patient.all()){
            patients.add(patient.name + " " + patient.surname);
        }

        return patients;
    }


    public static Patient findPatientByName(String name, String surname) {
        return find.where()
                .eq("name", name)
                .eq("surname", surname)
                .findUnique();
    }




}
