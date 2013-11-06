package controllers;

import com.avaje.ebean.Ebean;
import models.*;
import models.GamePackage;
import play.mvc.Controller;
import play.mvc.Result;

import java.util.Date;
import java.util.List;


public class DatabasePopulator extends Controller {

    public static Result populateDatabase(){

        populateInstitution();
        populateTherapistDatabase();
        populatePatientDatabase();
        populateAddressDatabase();
        populateResultsDatabase();
        return Application.login();
    }

    private static void populateResultsDatabase() {
        GamePackage gamePackage = new GamePackage("aaaa","bbbbb");
        Ebean.save(gamePackage);
        TestResult testResult1 = new TestResult(Game.QA,Patient.findPatientById(1),Therapist.findTherapistById(1),
                                                 3,2,new Date(),gamePackage);
        TestResult testResult2 = new TestResult(Game.CLASSIFICATION,Patient.findPatientById(1),Therapist.findTherapistById(1),
                1,4,new Date(),gamePackage);
        TestResult testResult3 = new TestResult(Game.SOCOCO,Patient.findPatientById(1),Therapist.findTherapistById(1),
                0,3,new Date(),gamePackage);
        TestResult.saveResult(testResult1);
        TestResult.saveResult(testResult2);
        TestResult.saveResult(testResult3);

    }

    private static void populateInstitution() {
        Address institutionAddress = new Address("Libertad","1250","3","D","1638","Vicente Lopez","Buenos Aires");
        Institution institution = new Institution("Dacaid",institutionAddress,"47911234","images/home.jpg",
                "Dacaid@gmail.com");

        Ebean.save(institutionAddress);
        Ebean.save(institution);
    }

    private static void populateAddressDatabase() {
        Address institutionAddress = new Address("Libertad","1250","3","D","1638","Vicente Lopez","Buenos Aires");
        Institution institution = new Institution("Dacaid",institutionAddress,"47911234","images/home.jpg",
                "Dacaid@gmail.com");

        Ebean.save(institutionAddress);
        Ebean.save(institution);

    }

    private static void populatePatientDatabase() {

        Address therapistAddress = new Address("Cabildo","1250","3","D","1638","Vicente Lopez","Buenos Aires");
        Institution institution = Institution.getById(1);
        Patient patient = new Patient("Francisco","Tenaglia","5673214","165439076",therapistAddress,"38789564",
                Gender.MALE,"francisco.ten@gmail.com",new Date(),"osde 310","23456787653","TGD","high",
                "uploads/JuanMolteni/JuaniMolteni.jpg",institution);

        Ebean.save(therapistAddress);
        Ebean.save(patient);

    }

    private static void populateTherapistDatabase() {

        Address therapistAddress = new Address("Cabildo","1250","3","D","1638","Vicente Lopez","Buenos Aires");
        Address noeAddress = new Address("Congreso","3441",null,null,"1430", "Capital Federal","Capital Federal");

        Institution institution = Institution.getById(1);
        Therapist therapist = new Therapist("Juan","Molteni","47911306","123",therapistAddress,"33850398",
                "juanignaciomolteni@gmail.com",new Date(), Gender.MALE,"asd",BCrypt.hashpw("123456", BCrypt.gensalt()),
                "uploads/JuanMolteni/JuaniMolteni.jpg", TherapistType.ADMIN,institution);

        Ebean.save(therapistAddress);
        Ebean.save(noeAddress);
        Ebean.save(therapist);


        Therapist therapist3 = new Therapist("María Noel","Podestá","45463187","1144041981",noeAddress,"34906400",
                "podesta.noe@gmail.com",new Date(), Gender.FEMALE,"asd",BCrypt.hashpw("hupihu", BCrypt.gensalt()),
                "uploads/noepodesta/DSC03433-001.jpg", TherapistType.ADMIN,institution);
        Therapist therapist2 = new Therapist("Juan","Molteni","47911306","123",therapistAddress,"33850397",
                "juanignaciomolteni@gmail.com",new Date(), Gender.MALE,"asd",BCrypt.hashpw("123456", BCrypt.gensalt()),
                "uploads/JuanMolteni/JuaniMolteni.jpg", TherapistType.NO_PRIVILEGES,institution);

        Ebean.save(therapist3);
        Ebean.save(therapist2);
    }

    public static Result cleanDataBase(){

        List<Therapist> therapistList = Therapist.all();
        for(Therapist therapist : therapistList){
            therapist.delete();
        }

        List<Patient> patientList = Patient.all();
        for(Patient patient : patientList){
            patient.delete();
        }

        List<Institution> institutionList = Institution.all();
        for(Institution institution : institutionList){
            institution.delete();
        }

        List<Address> addressList = Address.all();
        for(Address address : addressList){
            address.delete();
        }



        return Application.login();

    }



}
