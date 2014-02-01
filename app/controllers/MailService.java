package controllers;

import com.typesafe.plugin.*;
import models.Therapist;
import play.mvc.Controller;



/**
 * Created with IntelliJ IDEA.
 * User: Juani
 * Date: 9/8/13
 * Time: 10:34 PM
 * To change this template use File | Settings | File Templates.
 */
public class MailService extends Controller {

    private static MailerAPI mail = play.Play.application().plugin(MailerPlugin.class).email();


    public static void sendNewUserEmail(String email, String password) {

        mail.setSubject("Te han creado una cuenta en Get Together!");
        mail.addRecipient("Team GetTogether <noreply@GetTogether.com>", email);
        mail.addFrom("Team GetTogether <noreply@GetTogether.com>");
        //sends html
        //mail.sendHtml("<html>html</html>" );
        //sends text/text
        mail.send( "Hola!" +
                "\n\nHas recibido este mail porque te han inscripto en GetTogether. Para ingresar, solo debes ir a nuestra " +
                "pagina, y introducir tu dni junto con la contraseña " + password + ". Te recomendamos cambiarla en tu primer ingreso," +
                "y que verifiques que tus datos sean correctos. " +
                "\n\nSaludos," +
                "\nEquipo GetTogether" );
        //sends both text and html
        //mail.send( "text", "<html>html</html>");
    }

    public static void sendContactEmail(String name, String email, String message) {

        mail.setSubject("Nuevo Mesaje de Contacto de: " + name);
        mail.addFrom(email);
        mail.addRecipient("gettogethertest@gmail.com");
        //sends html
        //mail.sendHtml("<html>html</html>" );
        //sends text/text
        mail.send(message);
        //sends both text and html
        //mail.send( "text", "<html>html</html>");
    }

    public static boolean recoverPassword(String dni, String email){
        Therapist therapist = TherapistController.getTherapistByDNI(dni);
        if(therapist != null){
            if(therapist.mail.compareTo(email) == 0){
                String newPassword = TherapistController.updatePassword(therapist);
                mail.setSubject("Recuperar Contraseña");
                mail.addRecipient(email);
                mail.addFrom("Team GetTogether <noreply@GetTogether.com>");
                mail.send( "Hola!" +
                        "\n\nHas recibido este mail porque pediste recuperar la contraseña. Para ingresar, solo debes ir a nuestra " +
                        "pagina, y introducir tu dni junto con la nueva contraseña " + newPassword + ".Si no has pedido recuperar la contraseña, te" +
                        " pedimos que nos avises cuanto antes." +
                        "\n\nSaludos," +
                        "\nEquipo GetTogether" );
                return true;
            }
        }
        return false;
    }

    public static void sendNewTeamMail(String rol, String email, String nombrePaciente) {

        mail.setSubject("Te han asignado dentro de un equipo");
        mail.addRecipient(email);
        mail.addFrom("Team GetTogether <noreply@GetTogether.com>");
        mail.send( "Hola!" +
                "\n\nHas recibido este mail porque has sido asignado dentro de un nuevo equipo. Tu rol para el paciente " +
                nombrePaciente + " es el de " +  rol +
                "\n\nSaludos," +
                "\nEquipo GetTogether" );
    }
}
