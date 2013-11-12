package controllers;

import models.Patient;
import models.TestResult;
import play.mvc.Controller;
import play.mvc.Result;
import views.html.patient.resultShower;

import java.io.Serializable;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created with IntelliJ IDEA.
 * User: Juani
 * Date: 11/4/13
 * Time: 5:32 PM
 * To change this template use File | Settings | File Templates.
 */
public class ResultController extends Controller {

    private static int selectedPatient = 0;

    public static Result showResult() {
        return ok(resultShower.render(TestResult.all()));
    }

    public static Result jsonPerPatient(){
        Patient patient = PatientController.getPatientById(selectedPatient);
        List<TestResult> results = patient.getTestResults();


        ArrayList<Map<Object, Serializable>> allEvents = new ArrayList<Map<Object, Serializable>>();

        int i = 0;
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        for(TestResult testResult : results){
            Map<Object, Serializable> eventRemapped = new HashMap<Object, Serializable>();
            eventRemapped.put("id", testResult.id);
            eventRemapped.put("title", testResult.game);
            eventRemapped.put("start", df.format(testResult.dateMade));
            eventRemapped.put("end", df.format(testResult.dateMade));

            allEvents.add(eventRemapped);
        }
        return ok(play.libs.Json.toJson(allEvents));
    }

    public static Result viewPatientResults(int id){
        selectedPatient = id;
        return showResult();
    }

    public static Result json() {
         /*
        Date startDate = new Date(start*1000);
        Date endDate = new Date(end*1000);

        List<Event> resultList = Event.findInDateRange(startDate, endDate);
        ArrayList<Map<Object, Serializable>> allEvents = new ArrayList<Map<Object, Serializable>>();
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");

        for (Event event : resultList) {
            Map<Object, Serializable> eventRemapped = new HashMap<Object, Serializable>();
            eventRemapped.put("id", event.id);
            eventRemapped.put("title", event.title);
            eventRemapped.put("start", df.format(event.start));
            eventRemapped.put("end", df.format(event.end));
            eventRemapped.put("allDay", event.allDay);
            eventRemapped.put("url", controllers.routes.Application.edit(event.id).toString());

            allEvents.add(eventRemapped);
        }
        */
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");

        ArrayList<Map<Object, Serializable>> allEvents = new ArrayList<Map<Object, Serializable>>();
        Map<Object, Serializable> eventRemapped = new HashMap<Object, Serializable>();
        eventRemapped.put("id", 0);
        eventRemapped.put("title", Integer.toString(3));
        eventRemapped.put("start", df.format(new Date()));
        eventRemapped.put("end", df.format(new Date()));

        allEvents.add(eventRemapped);



        return ok(play.libs.Json.toJson(allEvents));
    }
}
