package controllers;

import models.Gender;
import models.User;
import org.apache.commons.io.FileUtils;
import play.mvc.Controller;
import play.mvc.Http;

import java.io.File;
import java.io.IOException;

/**
 * Created with IntelliJ IDEA.
 * User: Juani
 * Date: 9/5/13
 * Time: 12:14 AM
 * To change this template use File | Settings | File Templates.
 */
public class UserController extends Controller {


    public static String getPathName(User user, Gender gender) {

        Http.MultipartFormData body = request().body().asMultipartFormData();
        Http.MultipartFormData.FilePart picture = body.getFile("picture");


        String pathFile;

        if(picture != null){

            String fileName = picture.getFilename();
            File file = picture.getFile();

            File destinationFile = new File(play.Play.application().path().toString() + "//public//uploads//"
                    + user.name + user.surname + "//" + fileName);

            try {
                FileUtils.copyFile(file, destinationFile);

            } catch (IOException e) {
                e.printStackTrace();
            }

            pathFile = "/assets/uploads/" + user.name + user.surname + "/" + fileName;
        }else{
            pathFile = gender.isFemale() ? "/assets/uploads/female.jpg" : "/assets/uploads/male.jpg";

        }
        return pathFile;
    }


}
