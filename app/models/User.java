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
//@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@Table(name="User")
public class User extends Model {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public int id;
    @Constraints.Required(message = "Campo Requerido")
    public String name;
    @Constraints.Required(message = "Campo Requerido")
    public String surname;
    @Constraints.Required(message = "Campo Requerido")
    public String address;
    @Constraints.Pattern(value = "[0-9.+]+", message = "Ingrese un número válido")
    public String cellphone;
    @Constraints.Required(message = "Campo Requerido")
    @Constraints.Pattern(value = "[0-9]{3}-[0-9]{4}-[0-9]{4}", message = "Ingrese un número válido")
    public String telephone;
    @Constraints.Required(message = "Campo Requerido")
    public int dni;
    @Constraints.Email
    public String mail;
    @Formats.DateTime(pattern="dd/MM/yyyy")
    public Date birthday;
    public String image;

    public static Finder<Integer,User> find = new Finder<Integer,User>(Integer.class, User.class);



    public User(String name, String surname, String telephone, String address, int dni, String mail, Date birthday,
                String image) {
        this.name = name;
        this.surname = surname;
        this.telephone = telephone;
        this.address = address;
        this.dni = dni;
        this.mail = mail;
        this.birthday = birthday;
        this.image = image;
    }





}
