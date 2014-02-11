package controllers;


import models.Game;
import models.GamePackage;
import models.Therapist;
import msg.Msg;
import org.codehaus.jackson.node.ArrayNode;
import org.codehaus.jackson.node.JsonNodeFactory;
import org.codehaus.jackson.node.ObjectNode;
import play.mvc.Controller;
import play.mvc.Http;
import play.mvc.Result;
import views.html.gamePackages.loadCards;
import views.html.gamePackages.loadClassification;
import views.html.gamePackages.loadConversation;
import views.html.gamePackages.loadImageQA;
import views.html.gamePackages.loadSentence;
import views.html.gamePackages.loadSoCoCo;
import views.html.gamePackages.loadSound;
import views.html.gamePackages.loadTextQA;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.*;

import static play.data.Form.form;

/**
 * Created with IntelliJ IDEA.
 * User: Juanola
 * Date: 11/12/13
 * Time: 3:02 AM
 * To change this template use File | Settings | File Templates.
 */
public class GamePackageController extends Controller {

    private static JsonNodeFactory factory = JsonNodeFactory.instance;

    public static Result getTextQAPackageLoader() {
        return ok(loadTextQA.render());
    }

    public static Result getImageQAPackageLoader() {
        return ok(loadImageQA.render());
    }


    public static Result getSentencePackageLoader() {
        return ok(loadSentence.render());
    }

    public static Result getCardsPackageLoader() {
        return ok(loadCards.render());
    }

    public static Result getSoundQAPackageLoader() {
        return ok(loadSound.render());
    }

    public static Result getClassificationLoader() {
        return ok(loadClassification.render());
    }

    public static Result getConversationLoader() {
        return ok(loadConversation.render());
    }

    public static Result getSoCoCoLoader() {
        return ok(loadSoCoCo.render());
    }

    public static Result saveSoCoCoPackage() {
        final Map<String, String[]> values = request().body().asMultipartFormData().asFormUrlEncoded();
        ArrayNode graphicOptions = new ArrayNode(factory);
        ArrayNode answerAreas = new ArrayNode(factory);
        ArrayNode questions = new ArrayNode(factory);
        ArrayNode textOptions = new ArrayNode(factory);
        int[] totalsArray = new int[3];
        totalsArray[0] = 0;
        totalsArray[1] = 0;
        totalsArray[2] = 0;

        for(int i = 0;i<3;i++){
            ObjectNode answerArea = new ObjectNode(factory);
            answerArea.put("label", values.get(0 + "_labels_" + i + "_label")[0]);
            answerArea.put("classificationGroup",i);
            answerAreas.add(answerArea);

            ObjectNode secondClassification = new ObjectNode(factory);
            secondClassification.put("label", values.get(0 + "_secondClassification_" + i + "_label")[0]);
            secondClassification.put("classificationGroup",i);
            textOptions.add(secondClassification);

        }
      for(int i = 0;i<2;i++){
            //ObjectNode question = new ObjectNode(factory);
            questions.add(values.get(0 + "_questions_" + i + "_label")[0]);
            //questions.add(question);
        }
        //ObjectNode letsCount = new ObjectNode(factory);
       // letsCount.put("question", "Contemos!");
        questions.add("Contemos");


       // ObjectNode minorQuestion = new ObjectNode(factory);
       // minorQuestion.put("question", "Que grupo tiene menos objetos?");
        questions.add("Que grupo tiene menos objetos?");

      //  ObjectNode mayorQuestion = new ObjectNode(factory);
       // mayorQuestion.put("question",  "Que grupo tiene mas objetos?");
        questions.add("Que grupo tiene mas objetos?");


        int optionsLength = 0;
        while(values.get(0 + "_images_" + optionsLength + "_group") != null){
            ObjectNode option = new ObjectNode(factory);
            option.put("graphicOption", ImageController.getPackageImage(0 + "_images_" + optionsLength + "_image"));
            option.put("classificationGroup", values.get(0 + "_images_" + optionsLength + "_group")[0]);
            graphicOptions.add(option);
            totalsArray[Integer.parseInt(values.get(0 + "_images_" + optionsLength + "_group")[0])]++;
            optionsLength++;
         }


        ObjectNode soCoCoJSON = new ObjectNode(factory);
        soCoCoJSON.put("graphicOptions",graphicOptions);
        soCoCoJSON.put("answerAreas", answerAreas);
        soCoCoJSON.put("textOption", textOptions);
        soCoCoJSON.put("questions",questions);
        soCoCoJSON.put("totalImages", optionsLength);
        soCoCoJSON.put("totalA", totalsArray[0]);
        soCoCoJSON.put("totalB", totalsArray[1]);
        soCoCoJSON.put("totalC", totalsArray[2]);


        createGamePackage(values.get("0_packageName")[0], soCoCoJSON, Game.SOCOCO);


        return TherapistController.profile();
    }



    public static Result saveConversationPackage(){
        final Map<String, String[]> values = request().body().asFormUrlEncoded();
        ArrayNode conversationFlow = new ArrayNode(factory);
        ObjectNode conversationJSON = new ObjectNode(factory);
        ArrayNode stages = new ArrayNode(factory);
        int totalQuestions = 0;
        for(String key : values.keySet()){
            String[] parsedKey = key.split("_");
            if(parsedKey[1].equals("question")){
                totalQuestions++;
                int optionsLength = 0;
                ArrayNode stageOptions = new ArrayNode(factory);
                while(values.get(parsedKey[0] + "_answers_" + optionsLength + "_label") != null){
                      ObjectNode option = new ObjectNode(factory);
                      option.put("label", values.get(parsedKey[0] + "_ansers_" + optionsLength + "_label")[0]);
                      if(values.get(parsedKey[0] + "_answers_" + optionsLength + "_correctAnswer").length > 1){
                          conversationFlow.add(values.get(key)[0]);
                          conversationFlow.add(values.get(parsedKey[0] + "_answers_" + optionsLength + "_label")[0]);
                          option.put("correctAnswer", true);
                      }else{
                          option.put("correctAnswer", false);
                      }
                      optionsLength++;
                    stageOptions.add(option);
                }
                stages.add(stageOptions);
            }
        }
        conversationJSON.put("conversationStage", stages);
        conversationJSON.put("conversationFlow", conversationFlow);
        conversationJSON.put("totalQuestions", totalQuestions);
        conversationJSON.put("question",values.get("0_textOrientation")[0]);
        createGamePackage(values.get("0_packageName")[0], conversationJSON, Game.CONVERSATION);

        return TherapistController.profile();
    }


    public static Result saveClassificationPackage() {
        final Map<String, String[]> values = request().body().asMultipartFormData().asFormUrlEncoded();
        ArrayNode stages = new ArrayNode(factory);
        int totalStages = 0;

        for(String key : values.keySet()){
            String[] parsedKey = key.split("_");
            if(parsedKey[1].equals("stageQuestion")){
                totalStages++;
                ObjectNode stage = new ObjectNode(factory);
                ArrayNode options = new ArrayNode(factory);
                int optionsLength = 0;
                stage.put("optionsType", "Image");
                ArrayNode answerLabel = new ArrayNode(factory);
                for(int i = 0; i < 2; i++){
                    answerLabel.add(values.get(parsedKey[0] + "_labels_" + i + "_label")[0]);
                }
                while(values.get(parsedKey[0] + "_images_" + optionsLength + "_group") != null){
                    ObjectNode option = new ObjectNode(factory);
                    option.put("label", ImageController.getPackageImage(parsedKey[0] + "_images_" + optionsLength + "_image"));
                    option.put("classificationGroup", values.get(parsedKey[0] + "_images_" + optionsLength + "_group")[0]);
                    options.add(option);

                    optionsLength++;
                }
                stage.put("options", options);
                stage.put("totalAnswerAreas", 2);
                stage.put("optionsLength", optionsLength);
                stage.put("answerLabel", answerLabel);
                stage.put("stageQuestion", values.get(parsedKey[0] + "_stageQuestion")[0]);
                stages.add(stage);
            }
        }


        ObjectNode qaJSON = new ObjectNode(factory);
        qaJSON.put("totalStages",totalStages);
        qaJSON.put("stages", stages);

        createGamePackage(values.get("0_packageName")[0], qaJSON, Game.CLASSIFICATION);


        return TherapistController.profile();
    }


    public static Result saveImageQAPackage(){
        final Map<String, String[]> values = request().body().asMultipartFormData().asFormUrlEncoded();
        List<Http.MultipartFormData.FilePart> files = request().body().asMultipartFormData().getFiles();

        ArrayNode stages = new ArrayNode(factory);
        int totalStages = 0;

        ArrayList<String> keySet = new ArrayList<String>();
        for(int i=0;i<files.size();i++){
            keySet.add(files.get(i).getKey());
        }

        for(String key : values.keySet()){
            String[] parsedKey = key.split("_");
            if(parsedKey[1].equals("textQuestion")){
                totalStages++;
                ObjectNode stage = new ObjectNode(factory);
                ArrayNode options = new ArrayNode(factory);
                int optionsLength = 0;
                stage.put("optionsType", "Image");
                stage.put("textQuestion", values.get(key)[0]);
                if(request().body().asMultipartFormData().getFile(parsedKey[0] + "_imageQuestion") != null){
                    stage.put("imageQuestion", ImageController.getPackageImage(parsedKey[0] + "_imageQuestion"));
                }else{
                    stage.put("imageQuestion","-1");
                }
                while(keySet.contains(parsedKey[0] + "_options_" + optionsLength)){
                    ObjectNode option = new ObjectNode(factory);
                    option.put("label", ImageController.getPackageImage(parsedKey[0] + "_options_" + optionsLength));
                    if(values.get(parsedKey[0] + "_options_" + optionsLength + "_correctAnswer").length > 1){
                        option.put("correctAnswer", true);
                    }else{
                        option.put("correctAnswer", false);
                    }
                    optionsLength++;
                    options.add(option);
                }
                stage.put("options", options);
                stage.put("optionsLength", optionsLength);
                stages.add(stage);
            }
        }


        ObjectNode qaJSON = new ObjectNode(factory);
        qaJSON.put("totalStages",totalStages);
        qaJSON.put("stages", stages);

        createGamePackage(values.get("0_packageName")[0], qaJSON, Game.QA);


        return TherapistController.profile();
    }

    public static Result saveSoundQAPackage(){
        Map<String, String[]> values = request().body().asMultipartFormData().asFormUrlEncoded();
        ArrayNode stages = new ArrayNode(factory);
        int totalStages = 0;
        for(String key : values.keySet()){
            String[] parsedKey = key.split("_");
                if(parsedKey[1].equals("textQuestion")){
                    totalStages++;
                    ObjectNode stage = new ObjectNode(factory);
                    ArrayNode options = new ArrayNode(factory);
                    int optionsLength = 0;
                    stage.put("optionsType", "Text");
                    stage.put("textQuestion", values.get(key)[0]);
                    if(request().body().asMultipartFormData().getFile(parsedKey[0] + "_imageQuestion") != null){
                        stage.put("imageQuestion", ImageController.getPackageImage(parsedKey[0] + "_imageQuestion"));
                    }else{
                        stage.put("imageQuestion","-1");
                    }
                    stage.put("sound", ImageController.getPackageImage(parsedKey[0] + "_soundQuestion"));
                    while(values.get(parsedKey[0] + "_options_" + optionsLength) != null){
                        ObjectNode option = new ObjectNode(factory);
                        option.put("label", values.get(parsedKey[0] + "_options_" + optionsLength)[0]);
                        if(values.get(parsedKey[0] + "_options_" + optionsLength + "_correctAnswer").length > 1){
                            option.put("correctAnswer", true);
                        }else{
                            option.put("correctAnswer", false);
                        }
                        optionsLength++;
                        options.add(option);
                    }
                    stage.put("options", options);
                    stage.put("optionsLength", optionsLength);
                    stages.add(stage);
                }
        }

        ObjectNode qaJSON = new ObjectNode(factory);
        qaJSON.put("totalStages",totalStages);
        qaJSON.put("stages", stages);

        createGamePackage(values.get("0_packageName")[0], qaJSON, Game.SOUND);


        return TherapistController.profile();
    }

    public static Result saveTextQAPackage(){
        final Map<String, String[]> values = request().body().asMultipartFormData().asFormUrlEncoded();
        ArrayNode stages = new ArrayNode(factory);
        int totalStages = 0;
        for(String key : values.keySet()){
            String[] parsedKey = key.split("_");
            if(parsedKey.length < 4){
                if(parsedKey[1].equals("textQuestion")){
                    totalStages++;
                    ObjectNode stage = new ObjectNode(factory);
                    ArrayNode options = new ArrayNode(factory);
                    int optionsLength = 0;
                    stage.put("optionsType", "Text");
                    stage.put("textQuestion", values.get(key)[0]);
                    if(request().body().asMultipartFormData().getFile(parsedKey[0] + "_imageQuestion") != null){
                        stage.put("imageQuestion", ImageController.getPackageImage(parsedKey[0] + "_imageQuestion"));
                    }else{
                        stage.put("imageQuestion","-1");
                    }
                    while(values.get(parsedKey[0] + "_options_" + optionsLength) != null){
                        ObjectNode option = new ObjectNode(factory);
                        option.put("label", values.get(parsedKey[0] + "_options_" + optionsLength)[0]);
                        if(values.get(parsedKey[0] + "_options_" + optionsLength + "_correctAnswer").length > 1){
                            option.put("correctAnswer", true);
                        }else{
                            option.put("correctAnswer", false);
                        }
                        optionsLength++;
                        options.add(option);
                    }
                    stage.put("options", options);
                    stage.put("optionsLength", optionsLength);
                    stages.add(stage);
                }
            }
        }

        ObjectNode qaJSON = new ObjectNode(factory);
        qaJSON.put("totalStages",totalStages);
        qaJSON.put("stages", stages);

        createGamePackage(values.get("0_packageName")[0], qaJSON, Game.QA);

        return TherapistController.profile();
    }



    public static Result saveCardPackage(){

        final Map<String, String[]> values = request().body().asMultipartFormData().asFormUrlEncoded();
        List<Http.MultipartFormData.FilePart> files = request().body().asMultipartFormData().getFiles();

        ArrayNode cards = new ArrayNode(factory);
        for(int i= 0;i<files.size();i++){
            String[] parsedKey = files.get(i).getKey().split("_");
            ObjectNode card = new ObjectNode(factory);
            card.put("imageURL", ImageController.getPackageImage("imageURL_" + parsedKey[1]));
            card.put("imageName", values.get("cardLabel_" + parsedKey[1])[0]);
            cards.add(card);
        }
        ObjectNode cardJSON = new ObjectNode(factory);
        cardJSON.put("cards", cards);
        cardJSON.put("totalCards", files.size());

        createGamePackage(values.get("0_packageName")[0], cardJSON, Game.CARDS);

        return TherapistController.profile();
    }


    //QUE METODO MAS FEO; POSTA ESTUDIASTE 5 AÑOS DE INFORMATICA PARA ESTO?
    //VAMOS A MEJORARLO
    public static Result saveSentencePackage(){
        final Map<String, String[]> values = request().body().asMultipartFormData().asFormUrlEncoded();
        ArrayNode stages = new ArrayNode(factory);
        int totalStages = 0;

        for(String key : values.keySet()){
            String[] parsedKey = key.split("_");
            if(parsedKey[1].equals("textQuestion")){
                totalStages++;
                ObjectNode stage = new ObjectNode(factory);
                ArrayNode options = new ArrayNode(factory);
                int articlesLength = 0;
                int sustantivsLength = 0;
                int verbsLength = 0;
                int adjectivesLength = 0;
                ArrayNode articles = new ArrayNode(factory);
                ArrayNode sustantivs =  new ArrayNode(factory);
                ArrayNode verbs =  new ArrayNode(factory);
                ArrayNode adjectives =  new ArrayNode(factory);
                stage.put("textQuestion", values.get(key)[0]);
                if(request().body().asMultipartFormData().getFile(parsedKey[0] + "_imageQuestion") != null){
                    stage.put("imageQuestion", ImageController.getPackageImage(parsedKey[0] + "_imageQuestion"));
                }else{
                    stage.put("imageQuestion","-1");
                }
                while(values.get(parsedKey[0] + "_articles_" + articlesLength + "_label") != null){
                    ObjectNode article = new ObjectNode(factory);
                    article.put("label",  values.get(parsedKey[0] + "_articles_" + articlesLength + "_label")[0]);
                    if(values.get(parsedKey[0] + "_articles_" + articlesLength + "_correctAnswer").length > 1){
                        article.put("correctAnswer", true);
                    }else{
                        article.put("correctAnswer", false);
                    }
                    articlesLength++;
                    articles.add(article);
                }
                stage.put("articles",articles);
                while(values.get(parsedKey[0] + "_sustantivs_" + sustantivsLength + "_label") != null){
                    ObjectNode sustantiv = new ObjectNode(factory);
                    sustantiv.put("label",  values.get(parsedKey[0] + "_sustantivs_" + sustantivsLength + "_label")[0]);
                    if(values.get(parsedKey[0] + "_sustantivs_" + sustantivsLength + "_correctAnswer").length > 1){
                        sustantiv.put("correctAnswer", true);
                    }else{
                        sustantiv.put("correctAnswer", false);
                    }
                    sustantivsLength++;
                    sustantivs.add(sustantiv);
                }
                stage.put("sustantivs",sustantivs);
                while(values.get(parsedKey[0] + "_verbs_" + verbsLength + "_label") != null){
                    ObjectNode verb = new ObjectNode(factory);
                    verb.put("label",  values.get(parsedKey[0] + "_verbs_" + verbsLength + "_label")[0]);
                    if(values.get(parsedKey[0] + "_verbs_" + verbsLength + "_correctAnswer").length > 1){
                        verb.put("correctAnswer", true);
                    }else{
                        verb.put("correctAnswer", false);
                    }
                    verbsLength++;
                    verbs.add(verb);
                }
                stage.put("verbs",verbs);
                while(values.get(parsedKey[0] + "_adjectives_" + adjectivesLength + "_label") != null){
                    ObjectNode adjective = new ObjectNode(factory);
                    adjective.put("label",  values.get(parsedKey[0] + "_adjectives_" + adjectivesLength + "_label")[0]);
                    if(values.get(parsedKey[0] + "_adjectives_" + adjectivesLength + "_correctAnswer").length > 1){
                        adjective.put("correctAnswer", true);
                    }else{
                        adjective.put("correctAnswer", false);
                    }
                    adjectivesLength++;
                    adjectives.add(adjective);
                }
                stage.put("adjectives",adjectives);
                stages.add(stage);
            }
        }
        ObjectNode qaJSON = new ObjectNode(factory);
        qaJSON.put("totalStages",totalStages);
        qaJSON.put("stages", stages);

        createGamePackage(values.get("0_packageName")[0], qaJSON, Game.SENTENCE);


        return TherapistController.profile();

    }

    private static void createNewPackage(String newSentenceJson, Game game, String packageName, String packageUrl) {
        GamePackage gamePackage = new GamePackage(packageName, game, packageUrl, Application.getCurrentTherapist());
        GamePackage.save(gamePackage);
    }

    private static void createNewPackageFile(String packageUrl, String newSentenceJson) {
        BufferedWriter writer = null;
        try {
            writer = new BufferedWriter(new FileWriter(packageUrl));
            writer.write(newSentenceJson);
        } catch (IOException e) {
            System.err.println(e);
        } finally {
            if (writer != null) {
                try {
                    writer.close();
                } catch (IOException e) {
                    System.err.println(e);
                }
            }
        }
    }


    private static void createGamePackage(String s, ObjectNode cardJSON, Game game) {
        String packageName = s;
        String physicalPackageUrl = play.Play.application().path().toString() + Msg.PUBLIC_UPLOADS +
                Application.getCurrentTherapist().name + Application.getCurrentTherapist().surname + Msg.DOBLE_BARRA + Msg.PACKAGES + Msg.DOBLE_BARRA + packageName + ".txt";
        createNewPackageFile(physicalPackageUrl, cardJSON.toString());
        String packageUrl = "http://localhost:9000/assets/" + Msg.UPLOADS +
                Application.getCurrentTherapist().name + Application.getCurrentTherapist().surname + "/" +
                Msg.PACKAGES + "/" + packageName + ".txt";
        createNewPackage(cardJSON.toString(), game,packageName, packageUrl);
    }





}
