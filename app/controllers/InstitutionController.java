package controllers;

import models.Institution;
import play.mvc.Controller;

/**
 * Created with IntelliJ IDEA.
 * User: Juanola
 * Date: 10/8/13
 * Time: 4:24 PM
 * To change this template use File | Settings | File Templates.
 */
public class InstitutionController extends Controller {

    public static Institution getInsitutionById(int id){
        return Institution.getById(id);
    }
}
