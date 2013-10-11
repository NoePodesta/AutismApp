package controllers;

import com.typesafe.plugin.*;
import play.mvc.Controller;



/**
 * Created with IntelliJ IDEA.
 * User: Juani
 * Date: 9/8/13
 * Time: 10:34 PM
 * To change this template use File | Settings | File Templates.
 */
public class MailService extends Controller {

  public static void sendNewUserEmail(String email, String password) {
        MailerAPI mail = play.Play.application().plugin(MailerPlugin.class).email();
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
}
