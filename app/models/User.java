package models;

import play.data.format.Formats;
import play.data.validation.Constraints;
import play.db.ebean.Model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;


/**
 * Created with IntelliJ IDEA.
 * User: NoePodesta
 * Date: 17/08/13
 * Time: 12:04
 */

@Entity

@Table(name = "User")
public class User extends Model {


    @Id
    private int id;
    @Constraints.Required
    private String name;
    @Constraints.Required
    private int dni;
    @Constraints.Required
    private String address;
    @Constraints.Required
    private String telephone;
    @Formats.DateTime(pattern="dd/MM/yyyy")
    private Date birthday;

    public User(String name, String telephone, String address, int dni, Date birthday) {
        this.name = name;
        this.telephone = telephone;
        this.address = address;
        this.dni = dni;
        this.birthday = birthday;
    }

    public static Finder<Integer,User> find = new Finder<Integer,User>(
            Integer.class, User.class
    );





}
