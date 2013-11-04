package models;

import play.db.ebean.Model;

import javax.persistence.*;
import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: NoePodesta
 * Date: 17/08/13
 * Time: 12:51
 */

@Entity
@Table(name = "Results")
public class Results extends Model {

    @Id
    private int id;
    @Enumerated(EnumType.STRING)
    private Game game;
    @ManyToOne
    private Patient patient;
    @ManyToOne
    private Therapist therapist;
    private int correctAnswers;
    private int wrongAnswers;
    private Date dateMade;


}
