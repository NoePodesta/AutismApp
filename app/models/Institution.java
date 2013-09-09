package models;

import play.data.validation.Constraints;
import play.db.ebean.Model;

import javax.persistence.*;

/**
 * Created with IntelliJ IDEA.
 * User: Juani
 * Date: 9/9/13
 * Time: 12:00 AM
 * To change this template use File | Settings | File Templates.
 */

@Entity
//@DiscriminatorValue("aTherapist")
@Table(name="Institutions")
public class Institution extends Model {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    @Constraints.Required
    private String name;

}
