package models;

import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: NoePodesta
 * Date: 02/09/13
 * Time: 00:26
 * To change this template use File | Settings | File Templates.
 */
public class Administrator
        extends User {

    private String pass;

    public Administrator(String name, String surname, String telephone, String address, int dni,
                         String mail, Date birthday) {
        super(name, surname, telephone, address, dni, mail, birthday);
        this.pass = pass;
    }
}
