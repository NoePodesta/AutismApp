package models;


import play.data.format.Formats;
import play.data.validation.Constraints;
import play.db.ebean.Model;

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
    @OneToOne
    @Valid
    public Address address;
    public String cellphone;
    public String telephone;
    @Pattern(regexp = "^(\\d{8})$", message = "Ingrese un dni válido")
    @Constraints.Required
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

    @Entity
    public static class Address {

        @Id
        public int id;
        @Constraints.Required
        @Pattern(regexp = "^([a-zA-Z].+)$", message = "Ingrese un calle válida. Utilice solamente letras")
        public String street;
        @Constraints.Required
        @Pattern(regexp = "^([1-9]{1}[0-9]+)$", message = "Ingrese un número válido")
        public String number;
        @Pattern(regexp = "^([0-9]*)$", message = "Ingrese un número válido")
        public String floor;
        public String depto;
        @Constraints.Required
        @Pattern(regexp = "^([1-9]{1}[0-9]+)$", message = "Ingrese un número válido")
        public String cp;
        @Constraints.Required
        @Pattern(regexp = "^([a-zA-Z].+)$", message = "Ingrese un calle válida. Utilice solamente letras")
        public String locality;
        @Constraints.Required
        public String province;


        public Address(String street, String number, String floor, String depto, String cp, String locality, String province) {
            this.street = street;
            this.number = number;
            this.floor = floor;
            this.depto = depto;
            this.cp = cp;
            this.locality = locality;
            this.province = province;
        }
    }


}
