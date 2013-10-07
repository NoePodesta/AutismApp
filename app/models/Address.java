package models;

import play.data.validation.Constraints;
import play.db.ebean.Model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.Pattern;
import java.io.Serializable;


@Entity
@Table(name="Address")
public class Address extends Model {

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