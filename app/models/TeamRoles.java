package models;

import play.db.ebean.Model;

import javax.persistence.*;

/**
 * Created with IntelliJ IDEA.
 * User: Juanola
 * Date: 11/5/13
 * Time: 6:25 PM
 * To change this template use File | Settings | File Templates.
 */
@Entity
public class TeamRoles extends Model {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public int id;
    @OneToOne
    public Therapist therapist;
    public String role;
    @ManyToOne
    public Team team;

}
