package models;

import com.avaje.ebean.Ebean;
import play.db.ebean.Model;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: NoePodesta
 * Date: 17/08/13
 * Time: 12:51
 */

@Entity
@Table(name = "TestResult")
public class TestResult extends Model {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    @Enumerated(EnumType.STRING)
    private Game game;
    @ManyToOne
    private Patient patient;
    @ManyToOne
    private Therapist therapist;
    public int correctAnswers;
    private int wrongAnswers;
    private Date dateMade;
    @ManyToOne
    private Package aPackage;
    @ManyToOne
    private Team team;


    public static Model.Finder<Integer,TestResult> find = new Model.Finder(Integer.class, TestResult.class);

    public TestResult(Game game, Patient patient, Therapist therapist, int correctAnswers, int wrongAnswers, Date dateMade, Package aPackage) {
        this.game = game;
        this.patient = patient;
        this.therapist = therapist;
        this.correctAnswers = correctAnswers;
        this.wrongAnswers = wrongAnswers;
        this.dateMade = dateMade;
        this.aPackage = aPackage;
    }

    public static List<TestResult> all() {
        return find.all();
    }

    public static void saveResult(TestResult result){
        Ebean.save(result);
    }

    public static List<TestResult> getResultByPatient(Patient patient){
        return find.where().eq("patient", patient).findList();
    }




}
