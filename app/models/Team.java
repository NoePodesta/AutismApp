package models;

import play.db.ebean.Model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Juani
 * Date: 9/11/13
 * Time: 11:59 PM
 * To change this template use File | Settings | File Templates.
 */
public class Team extends Model {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    @ManyToMany
    private List<Patient> patients;
    @ManyToMany
    private List<Therapist_Role> therapists;


}
