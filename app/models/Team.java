package models;

import play.db.ebean.Model;

import javax.persistence.*;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Juani
 * Date: 9/11/13
 * Time: 11:59 PM
 * To change this template use File | Settings | File Templates.
 */

@Entity
@Table
public class Team extends Model {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    @OneToOne
    private Patient patient;
    @ManyToMany
    private List<Therapist_Role> therapists;


}
