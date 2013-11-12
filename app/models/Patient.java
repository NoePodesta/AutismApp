package models;

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
 * Time: 12:48

 */

@Entity
@Table(name="Patients")
public class Patient
        extends User {


    public String medicalCoverage;
    @Pattern(regexp = "^([0-9]*)$", message = "Ingrese un número válido.")
    public String nMedicalCoverage;
    @Constraints.Required
    public String disease;
    @Constraints.Required
    public String gradeDisease;
    @OneToMany(cascade = CascadeType.ALL)
    private List<TestResult> testResults;
    @OneToOne
    public Team team;
    @OneToOne
    public Institution institution;



    public Patient(final String name, final String surname, final String telephone, final String cellphone,
                   final Address address, final String dni, final Gender gender,
                   final String mail, final Date birthday,
                   final String medicalCoverage, final String nMedicalCoverage, final String disease,
                   String gradeDisease, final String image, final Institution institution) {

        super(name, surname, telephone, cellphone, address, dni, gender, mail, birthday, image);
        this.medicalCoverage = medicalCoverage;
        this.nMedicalCoverage = nMedicalCoverage;
        this.disease = disease;
        this.gradeDisease = gradeDisease;
        this.testResults = new ArrayList<TestResult>();

        this.institution = institution;
    }

    public static Model.Finder<Integer,Patient> find = new Model.Finder(Integer.class, Patient.class);




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

    public static List<String> allPatientsByNameAndDni() {
        List<String> patients = new ArrayList<String>();
        for(Patient patient : Patient.all()){
            patients.add(patient.name + " " + patient.surname + " - " + patient.dni);
        }

        return patients;
    }

    public static Patient findByTeam(Team team){
        return find.where().eq("team", team).findUnique();
    }



    public static Patient findPatientByName(String name, String surname) {
        return find.where()
                .eq("name", name)
                .eq("surname", surname)
                .findUnique();
    }

    public static Patient findPatientByDNI(String dni) {
        return find.where()
                .eq("dni", dni)
                .findUnique();
    }


    public static List<Patient> findPatientByInstitution(Institution institution) {
        return find.where()
                .eq("institution", institution)
                .findList();
    }

    public static Patient findPatientById(int id){
        return find.where()
                .eq("id",id)
                .findUnique();
    }

    public static boolean delete(int id) {
        Patient patientToDelete = findPatientById(id);
        if(patientToDelete != null){
            patientToDelete.delete();
            return true;
        }else{
            return false;
        }
    }

    public List<TestResult> getTestResults() {
        return testResults;
    }

    public void setTestResults(List<TestResult> testResults) {
        this.testResults = testResults;
    }


}
