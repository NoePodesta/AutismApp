package models;

import javax.persistence.Entity;
import javax.persistence.Table;
import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: NoePodesta
 * Date: 02/09/13
 * Time: 00:23
 * To change this template use File | Settings | File Templates.
 */

@Entity
@Table(name = "Coordinator")
public class Coordinator
        extends Therapist {


    public Coordinator(final String name, final String surname, final String telephone, final String cellphone,
                       final String address, final String dni, final  String mail, final Date birthday, final String nm,
                       final String password, final String image) {
        super(name, surname, telephone, cellphone, address, dni, mail, birthday, nm, password, image);
    }
}
