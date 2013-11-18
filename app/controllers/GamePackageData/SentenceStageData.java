package controllers.GamePackageData;

import java.util.ArrayList;

/**
 * Created with IntelliJ IDEA.
 * User: Juanola
 * Date: 11/14/13
 * Time: 3:02 AM
 * To change this template use File | Settings | File Templates.
 */
public class SentenceStageData {



    public String imageURL;
    public ArrayList<SentenceElement> articles;
    public ArrayList<SentenceElement> sustantivs;
    public ArrayList<SentenceElement> verbs;
    public ArrayList<SentenceElement> adjectives;



    public SentenceStageData() {
        articles = new ArrayList<SentenceElement>();
        sustantivs = new ArrayList<SentenceElement>();
        verbs = new ArrayList<SentenceElement>();
        adjectives = new ArrayList<SentenceElement>();


    }
}