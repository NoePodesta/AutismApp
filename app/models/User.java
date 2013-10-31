package models;


import play.data.format.Formats;
import play.data.validation.Constraints;
import play.db.ebean.Model;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.Valid;
import javax.validation.constraints.Pattern;
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
    @Pattern(regexp = "^([a-zA-Z].+)$", message = "Ingrese un apellido válido. Utilice solamente letras")
    public String name;
    @Pattern(regexp = "^([a-zA-Z].+)$", message = "Ingrese un apellido válido. Utilice solamente letras")
    @Constraints.Required
    public String surname;
    @OneToOne(cascade = CascadeType.REMOVE)
    @Valid
    public Address address;
    @Pattern(regexp = "^(\\d*)$", message = "Ingrese un número de celular válido")
    public String cellphone;
    @Pattern(regexp = "^(\\d*)$", message = "Ingrese un número de teléfono válido")
    @Constraints.Required
    public String telephone;
    @Pattern(regexp = "^(\\d{8})$", message = "Ingrese un dni válido")
    @Constraints.Required
    @Column(unique = true)
    public String dni;
    @Enumerated(EnumType.STRING)
    public Gender gender;
    @Constraints.Email
    public String mail;
    @Formats.DateTime(pattern="yyyy-MM-dd")
    public Date birthday;
    public String image;


    public static Finder<Integer,User> find = new Finder<Integer,User>(Integer.class, User.class);



    public User(String name, String surname, String telephone, String cellphone, Address address, String dni, Gender
            gender, String mail,
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
        this.gender = gender;
    }




}
