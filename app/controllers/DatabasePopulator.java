package controllers;

import com.avaje.ebean.Ebean;
import models.*;
import models.GamePackage;
import msg.Msg;
import play.mvc.Controller;
import play.mvc.Result;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;


public class DatabasePopulator extends Controller {

    public static Result populateDatabase(){

       // populateInstitution();
       // populateTherapistDatabase();
       // populateAdminTherapistDatabase();
       // populatePatientDatabase();
       // populateResultsDatabase();
        populateTeamWork();
        return Application.login();
    }

    private static void populateTeamWork() {

        Team team = new Team();
        Ebean.save(team);

        Patient patient = Patient.findPatientById(1);

        team.patient = patient;
        patient.team = team;

        //Institution
        team.institution = patient.institution;


        //Supervisor
        Therapist supervisor = Therapist.findTherapistById(1);
        if(supervisor.getAssignedTeams()!=null){
            supervisor.addToTeam(team);
        }else{
            supervisor.setAssignedTeams(new ArrayList<Team>());
            supervisor.getAssignedTeams().add(team);
        }
        TeamRoles supervisorRole = new TeamRoles();
        supervisorRole.role = TherapistRole.SUPERVISOR.toString();
        supervisorRole.therapist = supervisor;
        supervisorRole.team = team;
        Ebean.save(supervisorRole);
        team.getTeamRoles().add(supervisorRole);
        Ebean.update(supervisor);

        //Coordinator
        Therapist coordinator = Therapist.findTherapistById(2);
        if(coordinator.getAssignedTeams()!=null){
            coordinator.addToTeam(team);
        }else{
            coordinator.setAssignedTeams(new ArrayList<Team>());
            coordinator.getAssignedTeams().add(team);
        }
        // team.getAssignedTherapists().add(1, coordinator);
        TeamRoles coordinatorRole = new TeamRoles();
        coordinatorRole.role = TherapistRole.COORDINATOR.toString();
        coordinatorRole.therapist = coordinator;
        coordinatorRole.team = team;
        Ebean.save(coordinatorRole);
        team.getTeamRoles().add(coordinatorRole);
        Ebean.update(coordinator);


        //Integrator
        Therapist integrator = Therapist.findTherapistById(3);
        if(integrator.getAssignedTeams()!=null){
            integrator.addToTeam(team);
        }else{
            integrator.setAssignedTeams(new ArrayList<Team>());
            integrator.getAssignedTeams().add(team);
        }
        TeamRoles integratorRole = new TeamRoles();
        integratorRole.role = TherapistRole.INTEGRATOR.toString();
        integratorRole.therapist = integrator;
        integratorRole.team = team;
        Ebean.save(integratorRole);
        team.getTeamRoles().add(integratorRole);
        Ebean.update(integrator);

        //Therapist
        Therapist therapist = Therapist.findTherapistById(4);
        if(therapist.getAssignedTeams()!=null){
            therapist.addToTeam(team);
        }else{
            therapist.setAssignedTeams(new ArrayList<Team>());
            therapist.getAssignedTeams().add(team);
        }
        TeamRoles therapistRole = new TeamRoles();
        therapistRole.role = TherapistRole.THERAPIST.toString();
        therapistRole.therapist = integrator;
        therapistRole.team = team;
        Ebean.save(therapistRole);
        team.getTeamRoles().add(therapistRole);
        Ebean.update(therapist);

        Ebean.update(patient);
        Ebean.update(team);

    }

    private static void populateResultsDatabase() {
        String gamePackage = "aaaaa";
        Ebean.save(gamePackage);
        TestResult testResult1 = new TestResult(Game.QA,Patient.findPatientById(1),Therapist.findTherapistById(1),
                                                 3,2,new Date(),gamePackage,"");
        TestResult testResult2 = new TestResult(Game.CLASSIFICATION,Patient.findPatientById(1),Therapist.findTherapistById(1),
                1,4,new Date(),gamePackage,"");
        TestResult testResult3 = new TestResult(Game.SOCOCO,Patient.findPatientById(1),Therapist.findTherapistById(1),
                0,3,new Date(),gamePackage,"");
        TestResult testResult4 = new TestResult(Game.SOCOCO,Patient.findPatientById(1),Therapist.findTherapistById(1),
                0,3,new Date(),gamePackage,"");
        TestResult testResult5 = new TestResult(Game.SOCOCO,Patient.findPatientById(1),Therapist.findTherapistById(1),
                0,3,new Date(),gamePackage,"");
        TestResult testResult6 = new TestResult(Game.SOCOCO,Patient.findPatientById(1),Therapist.findTherapistById(1),
                0,3,new Date(),gamePackage,"");
        TestResult.saveResult(testResult1);
        TestResult.saveResult(testResult2);
        TestResult.saveResult(testResult3);
        TestResult.saveResult(testResult4);
        TestResult.saveResult(testResult5);
        TestResult.saveResult(testResult6);

    }

    private static void populateInstitution() {
        Address institutionAddress = new Address("Libertad","1250","3","D","1638","Vicente Lopez","Buenos Aires");
        Institution institution = new Institution("Paso a Paso",institutionAddress,"47911234","images/home.jpg",
                "pasoapaso@gmail.com");

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

    private static void populateAdminTherapistDatabase() {

        Address juanAddress = new Address("Cabildo","1250","3","D","1638","Vicente Lopez","Buenos Aires");
        Address noeAddress = new Address("Congreso","3441",null,null,"1430", "Capital Federal","Capital Federal");

        Institution institution = Institution.getById(1);

        Therapist juan = new Therapist("Juan","Molteni","47911306","123",juanAddress,"33678432",
                "juanignaciomolteni@gmail.com",new Date(), Gender.MALE,"12567",BCrypt.hashpw("123456", BCrypt.gensalt()),
                "uploads/JuanMolteni/JuaniMolteni.jpg", TherapistType.ADMIN,institution);

        Therapist noe = new Therapist("María Noel","Podestá","45463187","1144041981",noeAddress,"34906400",
                "podesta.noe@gmail.com",new Date(), Gender.FEMALE,"34567",BCrypt.hashpw("hupihu", BCrypt.gensalt()),
                "uploads/noepodesta/noe.JPG", TherapistType.ADMIN,institution);

        GamePackage gamePackage = new GamePackage("Emociones First Online", Game.QA, "JSONs/EmotionFaceQA.txt", juan);


        Ebean.save(juanAddress);
        Ebean.save(noeAddress);

        Ebean.save(juan);
        Ebean.save(noe);

        Ebean.save(gamePackage);


        Ebean.update(juan);



    }
    private static void populateTherapistDatabase() {



        Address therapistAddress1 = new Address("Cabildo","1250","3","D","1638","Vicente Lopez","Buenos Aires");
        Address therapistAddress2 = new Address("Cabildo","1250","3","D","1638","Vicente Lopez","Buenos Aires");
        Address therapistAddress3 = new Address("Cabildo","1250","3","D","1638","Vicente Lopez","Buenos Aires");
        Address therapistAddress4 = new Address("Cabildo","1250","3","D","1638","Vicente Lopez","Buenos Aires");
        Address therapistAddress5 = new Address("Cabildo","1250","3","D","1638","Vicente Lopez","Buenos Aires");
        Address therapistAddress6 = new Address("Cabildo","1250","3","D","1638","Vicente Lopez","Buenos Aires");
        Address therapistAddress7 = new Address("Cabildo","1250","3","D","1638","Vicente Lopez","Buenos Aires");
        Address therapistAddress8 = new Address("Cabildo","1250","3","D","1638","Vicente Lopez","Buenos Aires");
        Address therapistAddress9 = new Address("Cabildo","1250","3","D","1638","Vicente Lopez","Buenos Aires");
        Address therapistAddress10 = new Address("Cabildo","1250","3","D","1638","Vicente Lopez","Buenos Aires");


        Institution institution = Institution.getById(1);

        Therapist therapist1 = new Therapist("Marcos","Achaval","47911306","123",therapistAddress1,"21850398","juanignaciomolteni@gmail.com",new Date(), Gender.MALE,"asd","123456","", TherapistType.NO_PRIVILEGES,institution);
        Therapist therapist2 = new Therapist("Leticia","Mendizabal","47911306","123",therapistAddress2,"33451398","juanignaciomolteni@gmail.com",new Date(), Gender.MALE,"asd","123456","", TherapistType.NO_PRIVILEGES,institution);
        Therapist therapist3 = new Therapist("María","Bolteni","47911306","123",therapistAddress3,"33900398","juanignaciomolteni@gmail.com",new Date(), Gender.MALE,"asd","123456","", TherapistType.NO_PRIVILEGES,institution);
        Therapist therapist4 = new Therapist("Sofía","Chedick","47911306","123",therapistAddress4,"33850348","juanignaciomolteni@gmail.com",new Date(), Gender.MALE,"asd","123456","", TherapistType.NO_PRIVILEGES,institution);
        Therapist therapist5 = new Therapist("Juana","Di Arco","47911306","123",therapistAddress5,"34850308","juanignaciomolteni@gmail.com",new Date(), Gender.MALE,"asd","123456","", TherapistType.NO_PRIVILEGES,institution);
        Therapist therapist6 = new Therapist("Manuela","Esquenazi","47911306","123",therapistAddress6,"37850398","juanignaciomolteni@gmail.com",new Date(), Gender.MALE,"asd","123456","", TherapistType.NO_PRIVILEGES,institution);
        Therapist therapist7 = new Therapist("Renata","Maulli","47911306","123",therapistAddress7,"33850568","juanignaciomolteni@gmail.com",new Date(), Gender.MALE,"asd","123456","", TherapistType.NO_PRIVILEGES,institution);
        Therapist therapist8 = new Therapist("Nicolás","Gomez","47911306","123",therapistAddress8,"33850345","juanignaciomolteni@gmail.com",new Date(), Gender.MALE,"asd","123456","", TherapistType.NO_PRIVILEGES,institution);
        Therapist therapist9 = new Therapist("Felicitas","Perez","47911306","123",therapistAddress9,"33887398","juanignaciomolteni@gmail.com",new Date(), Gender.MALE,"asd","123456","", TherapistType.NO_PRIVILEGES,institution);
        Therapist therapist10 = new Therapist("Patricia","Gargara","47911306","123",therapistAddress10,"32850398","juanignaciomolteni@gmail.com",new Date(), Gender.MALE,"asd","123456","", TherapistType.NO_PRIVILEGES,institution);

        Ebean.save(therapistAddress1);
        Ebean.save(therapistAddress2);
        Ebean.save(therapistAddress3);
        Ebean.save(therapistAddress4);
        Ebean.save(therapistAddress5);
        Ebean.save(therapistAddress6);
        Ebean.save(therapistAddress7);
        Ebean.save(therapistAddress8);
        Ebean.save(therapistAddress9);
        Ebean.save(therapistAddress10);

        Ebean.save(therapist1);
        Ebean.save(therapist2);
        Ebean.save(therapist3);
        Ebean.save(therapist4);
        Ebean.save(therapist5);
        Ebean.save(therapist6);
        Ebean.save(therapist7);
        Ebean.save(therapist8);
        Ebean.save(therapist9);
        Ebean.save(therapist10);

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
