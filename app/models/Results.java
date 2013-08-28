package models;

import javax.persistence.*;

/**
 * Created with IntelliJ IDEA.
 * User: NoePodesta
 * Date: 17/08/13
 * Time: 12:51
 */

@Entity
@Table(name = "Results")
public class Results {

    @Id
    private int idResult;
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    private Game game;
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    private Patient patient;
    @ManyToOne
    private Therapist therapist;
    private int punctuation;
    private String description;



}
