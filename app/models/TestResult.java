package models;

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

    public static List<TestResult> getAllResults(){
        TestResult result = new TestResult();
        result.correctAnswers = 3;
        ArrayList<TestResult> results = new ArrayList<TestResult>();
        results.add(result);
        return results;
    }




}
