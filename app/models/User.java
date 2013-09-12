package models;


import play.data.format.Formats;
import play.data.validation.Constraints;
import play.db.ebean.Model;

import javax.persistence.*;
import java.util.Date;


/**
 * Created with IntelliJ IDEA.
 * User: NoePodesta
 * Date: 17/08/13
 * Time: 12:04
 */

@Entity
@Table(name="User")

public class User extends Model {


    @Id
    public int id;
    @Constraints.Required
    public String name;
    @Constraints.Required
    public String surname;
    @Constraints.Required
    public String address;
    public String cellphone;
    public String telephone;
    @Constraints.Required
    public String dni;
    @Constraints.Email
    public String mail;
    @Formats.DateTime(pattern="dd/MM/yyyy")
    public Date birthday;
    public String image;


    public static Finder<Integer,User> find = new Finder<Integer,User>(Integer.class, User.class);



    public User(String name, String surname, String telephone, String cellphone, String address, String dni, String mail,
                Date birthday, String image) {
        this.name = name;
        this.surname = surname;
        this.telephone = telephone;
        this.cellphone = cellphone;
        this.address = address;
        this.dni = dni;
        this.mail = mail;
        this.birthday = birthday;
        this.image = image;
    }





}
