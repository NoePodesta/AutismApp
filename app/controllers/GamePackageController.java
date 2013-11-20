package controllers;


import controllers.GamePackageData.SentenceElement;
import controllers.GamePackageData.SentenceStageData;
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
import views.html.gamePackages.*;
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
        ArrayNode textOptions = new ArrayNode(factory);
        int classificationGroup = 0;
        for(String key : values.keySet()){
            String[] parsedKey = key.split("_");
            if(parsedKey[1].equals("answer")){
                    ObjectNode option = new ObjectNode(factory);
                    option.put("quantity", Integer.parseInt(values.get(parsedKey[0] + "_options_amount")[0]));
                    option.put("graphicOption", ImageController.getPackageImage(parsedKey[0] + "_options_imageURL"));
                    option.put("classificationGroup", classificationGroup);
                    graphicOptions.add(option);

                    ObjectNode textOption = new ObjectNode(factory);
                    textOption.put("textOption", values.get(parsedKey[0] + "_options_label")[0]);
                    textOption.put("classificationGroup", classificationGroup);
                    textOptions.add(textOption);

                    ObjectNode answerArea = new ObjectNode(factory);
                    answerArea.put("classificationGroup",classificationGroup);
                    answerArea.put("textOption","");
                    answerAreas.add(answerArea);
                    classificationGroup++;
                }
        }


        ObjectNode soCoCoJSON = new ObjectNode(factory);
        soCoCoJSON.put("graphicOptions",graphicOptions);
        soCoCoJSON.put("answerAreas", answerAreas);
        soCoCoJSON.put("textOption", textOptions);

        createGamePackage(values.get("0_packageName")[0], soCoCoJSON, Game.SOCOCO);


        return TherapistController.profile();
    }



    //TODO TERMINAR
    public static Result saveConversationPackage(){
        final Map<String, String[]> values = request().body().asFormUrlEncoded();
        ArrayNode conversationFlow = new ArrayNode(factory);
        ObjectNode conversationJSON = new ObjectNode(factory);
        ArrayNode stages = new ArrayNode(factory);
        int totalQuestions = 0;
        for(String key : values.keySet()){
            String[] parsedKey = key.split("_");
            if(parsedKey[1].equals("answer")){
                int optionsLength = 0;
                totalQuestions++;
                ArrayNode stageOptions = new ArrayNode(factory);
                while(values.get(parsedKey[0] + "_options_" + optionsLength) != null){
                      ObjectNode option = new ObjectNode(factory);
                      option.put("label", values.get(parsedKey[0] + "_options_" + optionsLength)[0]);
                      if(values.get(parsedKey[0] + "_options_" + optionsLength + "_correctAnswer").length > 1){
                         option.put("data", true);
                          conversationFlow.add(values.get(parsedKey[0] + "_options_" + optionsLength)[0]);
                      }else{
                          option.put("data", false);
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
        createGamePackage(values.get("0_packageName")[0], conversationJSON, Game.CONVERSATION);

        return TherapistController.profile();
    }


    public static Result saveClassificationPackage() {
        final Map<String, String[]> values = request().body().asMultipartFormData().asFormUrlEncoded();
        ArrayNode stages = new ArrayNode(factory);
        int totalStages = 0;

        for(String key : values.keySet()){
            String[] parsedKey = key.split("_");
            if(parsedKey[1].equals("answer")){
                totalStages++;
                ObjectNode stage = new ObjectNode(factory);
                ArrayNode options = new ArrayNode(factory);
                int optionsLength = 0;
                stage.put("optionsType", "Image");
                int totalAnswers = 0;
                int classificationGroup = 0;
                while(values.get(parsedKey[0] + "_options_" + optionsLength + "_amount") != null){

                    for(int i=0;i<Integer.parseInt(values.get(parsedKey[0] + "_options_" + optionsLength + "_amount")[0]);i++){
                        ObjectNode option = new ObjectNode(factory);
                        option.put("label", ImageController.getPackageImage(parsedKey[0] + "_options_" + optionsLength));
                        option.put("classificationGroup", classificationGroup);
                        options.add(option);
                        totalAnswers++;
                    }
                    optionsLength++;
                    classificationGroup++;
                }
                stage.put("options", options);
                stage.put("totalAnswerAreas", optionsLength);
                stage.put("optionsLength", totalAnswers);
                ArrayNode answerLabel = new ArrayNode(factory);
                for(int i=0;i<2;i++){
                    answerLabel.add("");
                }
                stage.put("answerLabel", answerLabel);
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
        List<Http.MultipartFormData.FilePart> files = request().body().asMultipartFormData().getFiles();
        final Map<String, String[]> values = request().body().asMultipartFormData().asFormUrlEncoded();
        ArrayNode stages = new ArrayNode(factory);
        int totalStages = 0;

        ArrayList<String> keySet = new ArrayList<String>();
        for(int i=0;i<files.size();i++){
            keySet.add(files.get(i).getKey());
        }

        for(String key : keySet){
            String[] parsedKey = key.split("_");
            if(parsedKey[1].equals("answer")){
                totalStages++;
                ObjectNode stage = new ObjectNode(factory);
                ArrayNode options = new ArrayNode(factory);
                int optionsLength = 0;
                stage.put("answerType", "Image");
                stage.put("optionsType", "Image");
                stage.put("answer", ImageController.getPackageImage(key));
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
        List<Http.MultipartFormData.FilePart> files = request().body().asMultipartFormData().getFiles();



        ArrayNode stages = new ArrayNode(factory);
        int totalStages = 0;
        for(String key : values.keySet()){
            String[] parsedKey = key.split("_");
            if(parsedKey.length < 4){
                if(parsedKey[1].equals("answer")){
                    totalStages++;
                    ObjectNode stage = new ObjectNode(factory);
                    ArrayNode options = new ArrayNode(factory);
                    int optionsLength = 0;
                    stage.put("answerType", "Text");
                    stage.put("optionsType", "Text");
                    stage.put("answer", values.get(key)[0]);
                    stage.put("sound", ImageController.getPackageImage(key + "_sound"));
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

        createGamePackage(values.get("0_packageName")[0], qaJSON, Game.SOUND);


        return TherapistController.profile();
    }

    public static Result saveTextQAPackage(){
        final Map<String, String[]> values = request().body().asFormUrlEncoded();
        ArrayNode stages = new ArrayNode(factory);
        int totalStages = 0;
        for(String key : values.keySet()){
            String[] parsedKey = key.split("_");
            if(parsedKey.length < 4){
                if(parsedKey[1].equals("answer")){
                    totalStages++;
                    ObjectNode stage = new ObjectNode(factory);
                    ArrayNode options = new ArrayNode(factory);
                    int optionsLength = 0;
                    stage.put("answerType", "Text");
                    stage.put("optionsType", "Text");
                    stage.put("answer", values.get(key)[0]);
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
    public static Result saveSentencePackage(){
        final Map<String, String[]> values = request().body().asMultipartFormData().asFormUrlEncoded();

        ArrayList<SentenceStageData> jsonToForm = new ArrayList<SentenceStageData>();
        buildStageArray(values, jsonToForm);
        addImagesToArray(jsonToForm);



        for(String key : values.keySet()){
            String[] parsedKey = key.split("_");
            if(parsedKey.length < 4){
                if (parsedKey[1].equals("verbs")) {
                    SentenceElement sentenceElement = new SentenceElement();
                    sentenceElement.label = values.get(key)[0];
                    sentenceElement.correctAnswer = values.get(key.concat("_correctAnswer")).length == 2;
                    jsonToForm.get(Integer.parseInt(parsedKey[0].toString())).verbs.add(sentenceElement);

                } else if (parsedKey[1].equals("sustantivs")) {
                    SentenceElement sentenceElement2 = new SentenceElement();
                    sentenceElement2.label = values.get(key)[0];
                    sentenceElement2.correctAnswer = values.get(key.concat("_correctAnswer")).length == 2;
                    jsonToForm.get(Integer.parseInt(parsedKey[0].toString())).sustantivs.add(sentenceElement2);

                } else if (parsedKey[1].equals("articles")) {
                    SentenceElement sentenceElement3 = new SentenceElement();
                    sentenceElement3.label = values.get(key)[0];
                    sentenceElement3.correctAnswer = values.get(key.concat("_correctAnswer")).length == 2;
                    jsonToForm.get(Integer.parseInt(parsedKey[0].toString())).articles.add(sentenceElement3);

                } else if (parsedKey[1].equals("adjectives")) {
                    SentenceElement sentenceElement4 = new SentenceElement();
                    sentenceElement4.label = values.get(key)[0];
                    sentenceElement4.correctAnswer = values.get(key.concat("_correctAnswer")).length == 2;
                    jsonToForm.get(Integer.parseInt(parsedKey[0].toString())).adjectives.add(sentenceElement4);

                }
            }
         }

        ObjectNode newSentenceJson = buildSentenceJson(jsonToForm);

        createGamePackage(values.get("0_packageName")[0], newSentenceJson, Game.SENTENCE);


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

    private static void addImagesToArray(ArrayList<SentenceStageData> jsonToForm) {
        List<Http.MultipartFormData.FilePart> files = request().body().asMultipartFormData().getFiles();
        for(int i = 0;i<files.size();i++){
            String[] parsedKey = files.get(i).getKey().split("_");
            jsonToForm.get(Integer.parseInt(parsedKey[0].toString())).imageURL = ImageController.getPackageImage(files.get(i).getKey());
        }
    }

    private static ObjectNode buildSentenceJson(ArrayList<SentenceStageData> jsonToForm) {
        ObjectNode newSentenceJson = new ObjectNode(factory);
        ArrayNode stages = new ArrayNode(factory);
        Random generator = new Random();
        for(int i = 0;i<jsonToForm.size();i++){
            ObjectNode stage = new ObjectNode(factory);
            stage.put("answer",jsonToForm.get(i).imageURL);
            ArrayNode adjectives = new ArrayNode(factory);
            for(int j = 0;j<jsonToForm.get(i).adjectives.size();j++){
                ObjectNode adjective = new ObjectNode(factory);
                if(jsonToForm.get(i).adjectives.get(j).correctAnswer){
                    adjective.put("data", j);
                }else{
                    adjective.put("data", generator.nextInt(500));
                }
                adjective.put("label",jsonToForm.get(i).adjectives.get(j).label);
                adjectives.add(adjective);
            }
            stage.put("adjectives", adjectives);
            ArrayNode sustantivs = new ArrayNode(factory);
            for(int j = 0;j<jsonToForm.get(i).sustantivs.size();j++){
                ObjectNode sustantiv = new ObjectNode(factory);
                if(jsonToForm.get(i).sustantivs.get(j).correctAnswer){
                    sustantiv.put("data", j);
                }else{
                    sustantiv.put("data", generator.nextInt(500));
                }
                sustantiv.put("label",jsonToForm.get(i).sustantivs.get(j).label);
                sustantivs.add(sustantiv);
            }
            stage.put("sustantivs", sustantivs);
            ArrayNode articles = new ArrayNode(factory);
            for(int j = 0;j<jsonToForm.get(i).articles.size();j++){
                ObjectNode article = new ObjectNode(factory);
                if(jsonToForm.get(i).articles.get(j).correctAnswer){
                    article.put("data", j);
                }else{
                    article.put("data", generator.nextInt(500));
                }
                article.put("label",jsonToForm.get(i).articles.get(j).label);
                articles.add(article);
            }
            stage.put("articles", articles);
            ArrayNode verbs = new ArrayNode(factory);
            for(int j = 0;j<jsonToForm.get(i).verbs.size();j++){
                ObjectNode verb = new ObjectNode(factory);
                if(jsonToForm.get(i).articles.get(j).correctAnswer){
                    verb.put("data", j);
                }else{
                    verb.put("data", generator.nextInt(500));
                }
                verb.put("label",jsonToForm.get(i).verbs.get(j).label);
                verbs.add(verb);
            }
            stage.put("verbs",verbs);
            stages.add(stage);
        }
        newSentenceJson.put("stages", stages);
        newSentenceJson.put("totalStages", jsonToForm.size());


        return newSentenceJson;
    }

    private static void buildStageArray(Map<String, String[]> values, ArrayList<SentenceStageData> jsonToForm) {
        int biggerIndex = 0;
        for(String key : values.keySet()){
            String[] parsedKey = key.split("_");
            if(Integer.parseInt(parsedKey[0].toString()) > biggerIndex){
                biggerIndex = Integer.parseInt(parsedKey[0].toString());
            }
        }
        for(int i = 0;i<biggerIndex + 1;i++){
            jsonToForm.add(i, new SentenceStageData());
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
