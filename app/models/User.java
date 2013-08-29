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
    public int id;
    @Constraints.Required
    public String name;
    @Constraints.Required
    public String surname;
    @Constraints.Required
    public String address;
    @Constraints.Required
    public String telephone;
    @Constraints.Required
    public int dni;
    public String mail;
    @Formats.DateTime(pattern="dd/MM/yyyy")
    public Date birthday;

    public User(String name, String surname, String telephone, String address, int dni, String mail, Date birthday) {
        this.name = name;
        this.surname = surname;
        this.telephone = telephone;
        this.address = address;
        this.dni = dni;
        this.mail = mail;
        this.birthday = birthday;
    }

    public static Finder<Integer,User> find = new Finder<Integer,User>(
            Integer.class, User.class
    );





}
