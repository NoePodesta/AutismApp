package msg;

import play.mvc.Content;

/**
 * Created with IntelliJ IDEA.
 * User: NoePodesta
 * Date: 01/11/13
 * Time: 11:16
 */
public class Msg {

    public static final String INVALID = "Contraseña o usuario invalido";
    public static final String SUCCESS = "success";
    public static final String LOGOUT = "Usted ha sido deslogueado";
    public static final String INVALID_INFO = "La informacion proporcionada no es valida";
    public static final String MAIL_SENT = "Se le ha enviado un mail con los nuevos datos";
    public static final String DNI = "dni";
    public static final String PASSWORD = "password";
    public static final String USERNAME = "username";
    public static final String ID = "id";


    //Images
    public static final String PUBLIC_UPLOADS = "//public//uploads//";
    public static final String DOBLE_BARRA = "//";
    public static final String BARRA = "/";
    public static final String UPLOADS = "uploads/";
    public static final String HOME_IMAGE = "/assets/images/home.jpg";
    public static final String FEMALE_IMAGE = "/assets/images/female.jpg";
    public static final String MALE_IMAGE = "/assets/images/male.jpg";
    public static final String PICTURE = "picture";

    //Application
    public static final String LOGIN_SUCCESSFUL = "Login Successful";
    public static final String LOGIN_FAILED = "Login failed";
    public static final String GENERO = "genero";
    public static final String CHANGES_SAVED = "Sus cambios han sido guardados";
    public static final String CHECK_DNI = "Ya se ha ingresado este dni";
    public static final String THERAPIST = "terapeuta";
    public static final String THERAPISTE = "therapist";
    public static final String PATIENT = "paciente";
    public static final String SUPERVISOR = "supervisor";
    public static final String COORDINATOR = "coordinator";
    public static final String COORDINADOR = "coordinador";
    public static final String INTEGRADOR = "integrador";
    public static final String INTEGRATOR = "integrator";
    public static final String TEAM_CREATED = "El equipo de trabajo ha sido creado";
    public static final String TEAM = "equipo de trabajo";
    public static final String SURNAME = "surname";
    public static final String NAME = "name";
    public static final String PACKAGES = "packages";
    public static final String ERRORS = "errors";
    public static final String ERROR = "ha habido algunos errores, corriga el formulario y vuelva a intentarlo!";


    public static String REMOVE(String user) {
        return "El " + user + " ha sido eliminado";
    }

    public static String ADDED(String user, String name, String surname) {
        return "El " + user + name  + surname + " ha sido dado de alta";
    }

}
