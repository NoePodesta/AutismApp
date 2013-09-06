package models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: NoePodesta
 * Date: 02/09/13
 * Time: 00:26
 * To change this template use File | Settings | File Templates.
 */

@Entity
@Table(name = "Administrator")
public class Administrator
        extends User {

    @Column(name = "Password")
    private String pass;

    public Administrator(String name, String surname, String telephone, String address, int dni,
                         String mail, Date birthday, String pass, String image) {
        super(name, surname, telephone, address, dni, mail, birthday, image);
        this.pass = pass;
    }
}
