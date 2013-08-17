package model;

import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: NoePodesta
 * Date: 17/08/13
 * Time: 12:48

 */

public class Patient
        extends User  {


    private int id;
    private String medicalCoverage;
    private String disease;
    private int gradeDisease;
    private List<Results> progress;
    private List<Therapist> therapists;
    private int qAwardA;
    private int qAwardB;
    private int qAwardC;


    public Patient(String name, String telephone, String address, int dni, String medicalCoverage, String disease,
                   int gradeDisease, List<Therapist> therapists) {

        super(name, telephone, address, dni);
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
