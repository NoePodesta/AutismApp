package models;

import com.avaje.ebean.annotation.EnumValue;

/**
 * Created with IntelliJ IDEA.
 * User: NoePodesta
 * Date: 17/08/13
 */



public enum Game{

    @EnumValue("QA")
    QA("Pregunta y Respuesta"),

    @EnumValue("CLASSIFICATION")
    CLASSIFICATION("Clasificación"),

    @EnumValue("SOCOCO")
    SOCOCO("Sococo"),

    @EnumValue("SENTENCE")
    SENTENCE("Oración"),

    @EnumValue("CONVERSATION")
    CONVERSATION("Conversación"),

    @EnumValue("CARDS")
    CARDS("Carta"),

    @EnumValue("SOUND")
    SOUND("Sonido"),

    @EnumValue("BITACORA")
    BITACORA("Bitacora");

    String value;


    Game(String value){
        this.value = value;

    }

    public String getValue(){
        return value;
    }

    public boolean isQA(){
        return equals(QA);
    }
    public boolean isClassification(){
        return equals(CLASSIFICATION);
    }
    public boolean isSococo(){
        return equals(SOCOCO);
    }
    public boolean isSentence(){
        return equals(SENTENCE);
    }
    public boolean isConversation(){
        return equals(CONVERSATION);
    }
    public boolean isSound(){
        return equals(SOUND);
    }
    public boolean isBitacora(){
        return equals(BITACORA);
    }

    public boolean isCard(){
        return equals(CARDS);
    }






}
