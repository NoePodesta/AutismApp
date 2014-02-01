package controllers;

import models.Gender;
import models.Institution;
import models.User;
import msg.Msg;
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
public class ImageController extends Controller {


    public static String getUserImagePathName(User user, Gender gender) {

        Http.MultipartFormData body = request().body().asMultipartFormData();
        Http.MultipartFormData.FilePart picture = body.getFile(Msg.PICTURE);


        String pathFile;

        if(picture != null){

            String fileName = picture.getFilename();
            File file = picture.getFile();

            File destinationFile = new File(play.Play.application().path().toString() + Msg.PUBLIC_UPLOADS
                    + user.dni + Msg.DOBLE_BARRA + fileName);

            try {
                FileUtils.copyFile(file, destinationFile);

            } catch (IOException e) {
                e.printStackTrace();
            }

            pathFile = Msg.UPLOADS + user.dni + "/" + fileName;
        }else{
            pathFile = gender.isFemale() ? Msg.FEMALE_IMAGE : Msg.MALE_IMAGE;

        }
        return pathFile;
    }

    public static String getInstImagePathName(Institution institution) {

        Http.MultipartFormData body = request().body().asMultipartFormData();
        Http.MultipartFormData.FilePart picture = body.getFile(Msg.PICTURE);


        String pathFile;

        if(picture != null){

            String fileName = picture.getFilename();
            File file = picture.getFile();

            File destinationFile = new File(play.Play.application().path().toString() + Msg.PUBLIC_UPLOADS
                    + Utils.removeSpaces(institution.name) + Msg.DOBLE_BARRA + fileName);

            try {
                FileUtils.copyFile(file, destinationFile);

            } catch (IOException e) {
                e.printStackTrace();
            }

            pathFile = Msg.UPLOADS + Utils.removeSpaces(institution.name) + Msg.BARRA + fileName;
        }else{
            pathFile = Msg.HOME_IMAGE;

        }
        return pathFile;
    }


    public static String getPackageImage(String s) {
        Http.MultipartFormData body = request().body().asMultipartFormData();
        Http.MultipartFormData.FilePart picture = body.getFile(s);


        String pathFile;

        if(picture != null){

            String fileName = picture.getFilename();
            File file = picture.getFile();

            File destinationFile = new File(play.Play.application().path().toString() + Msg.PUBLIC_UPLOADS +
                    Application.getCurrentTherapist().name + Application.getCurrentTherapist().surname +
                    Msg.DOBLE_BARRA + Msg.PACKAGES + Msg.DOBLE_BARRA + fileName);

            try {
                FileUtils.copyFile(file, destinationFile);

            } catch (IOException e) {
                e.printStackTrace();
            }

            pathFile = "http://localhost:9000/assets/" + Msg.UPLOADS +
                    Application.getCurrentTherapist().name + Application.getCurrentTherapist().surname + "/" +
                    Msg.PACKAGES + "/" + fileName;
        }else{
            pathFile = Msg.HOME_IMAGE;
        }
        return pathFile;
    }
}
