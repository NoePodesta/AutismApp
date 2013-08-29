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
 * Time: 12:48

 */

@Entity
@Table(name = "Patients")
public class Patient
        extends User {

    @Constraints.Required
    private String medicalCoverage;
    @Constraints.Required
    private String disease;
    @Constraints.Required
    private int gradeDisease;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "patient",
            fetch = FetchType.LAZY)
    private List<Results> progress;
    @ManyToMany
    private List<Therapist> therapists;
    private int qAwardA;
    private int qAwardB;
    private int qAwardC;


    public Patient(final String name, final String surname, final String telephone, final String address, final int dni,
                   final String mail, final Date birthday,
                   final String medicalCoverage, final String disease,
                   int gradeDisease, List<Therapist> therapists) {

        super(name, surname, telephone, address, dni, mail, birthday);
        this.medicalCoverage = medicalCoverage;
        this.disease = disease;
        this.gradeDisease = gradeDisease;
        this.progress = new ArrayList<Results>();
        this.therapists = therapists;

        this.qAwardA = 0;
        this.qAwardB = 0;
        this.qAwardC = 0;
    }

    public void gainAwardA(int value){
        qAwardA = qAwardA+value;
    }

    public void gainAwardB(int value){
        qAwardB = qAwardB+value;
    }

    public void gainAwardC(int value){
        qAwardC = qAwardC+value;
    }

    public void addTherapist(Therapist therapist){
        therapists.add(therapist);
    }

    public void removeTherapist(Therapist therapist){
        therapists.remove(therapist);
    }

}
