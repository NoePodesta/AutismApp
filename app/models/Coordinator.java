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


    public Coordinator(final String name, final String surname, final String telephone, final String address,
                       final int dni, final  String mail, final Date birthday, final int nm,
                       final String password, final String image) {
        super(name, surname, telephone, address, dni, mail, birthday, nm, password, image);
    }
}
