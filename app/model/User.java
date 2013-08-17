package model;

/**
 * Created with IntelliJ IDEA.
 * User: NoePodesta
 * Date: 17/08/13
 * Time: 12:04
 */
public class User {

    private int id;
    private String name;
    private int dni;
    private String address;
    private String telephone;

    public User(String name, String telephone, String address, int dni) {
        this.name = name;
        this.telephone = telephone;
        this.address = address;
        this.dni = dni;
    }


}
