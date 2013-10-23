package models;

import com.avaje.ebean.Ebean;
import play.data.validation.Constraints;
import play.db.ebean.Model;

import javax.persistence.*;
import java.util.ArrayList;

/**
 * Created with IntelliJ IDEA.
 * User: Juani
 * Date: 9/9/13
 * Time: 12:00 AM
 * To change this template use File | Settings | File Templates.
 */

@Entity
@Table(name="Institutions")
public class Institution extends Model {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public int id;

    @Constraints.Required
    public String name;
    @OneToOne
    public Address address;

    public String telephone;

    @OneToMany
    public ArrayList<Therapist> therapists;

    @OneToMany
    public ArrayList<Patient> patients;

    @OneToMany
    public ArrayList<Team> teams;

    public static Model.Finder<Integer,Institution> find = new Model.Finder(Integer.class, Institution.class);

    public Institution(final String name, final Address address, final String telephone){
        this.name = name;
        this.address = address;
        this.telephone = telephone;
    }

    public static Institution getById(int institutionId) {
        return find.byId(institutionId);
    }

    public static void updateInstitution(Institution institution) {
        Ebean.update(institution);

    }
}
