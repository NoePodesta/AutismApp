package models;

import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: NoePodesta
 * Date: 02/09/13
 * Time: 00:23
 * To change this template use File | Settings | File Templates.
 */
public class Coordinator
        extends Therapist {


    public Coordinator(String name, String surname, String telephone, String address, int dni, String mail,
                       Date birthday, int nm, String password) {
        super(name, surname, telephone, address, dni, mail, birthday, nm, password);
    }
}
