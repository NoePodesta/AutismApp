package controllers;

import models.TestResult;
import play.mvc.Controller;
import play.mvc.Result;
import views.html.patient.resultShower;

/**
 * Created with IntelliJ IDEA.
 * User: Juani
 * Date: 11/4/13
 * Time: 5:32 PM
 * To change this template use File | Settings | File Templates.
 */
public class ResultController extends Controller {


    public static Result showResult() {
        return ok(
                resultShower.render(TestResult.getAllResults())

        );
    }
}
