package models;

import play.data.validation.Constraints;
import play.db.ebean.Model;

import javax.persistence.*;

/**
 * Created with IntelliJ IDEA.
 * User: Juani
 * Date: 9/12/13
 * Time: 12:05 AM
 * To change this template use File | Settings | File Templates.
 */
@Table
@Entity
public class Therapist_Role extends Model {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    @Constraints.Required
    private Therapist therapist;
    @Enumerated(EnumType.STRING)
    private TherapistRole role;

    public TherapistRole getRole() {
        return role;
    }

    public void setRole(TherapistRole role) {
        this.role = role;
    }




}
