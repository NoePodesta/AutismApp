package models;

import com.avaje.ebean.annotation.EnumValue;

/**
 * Created with IntelliJ IDEA.
 * User: NoePodesta
 * Date: 17/08/13
 */



public enum Game{

    @EnumValue("QA")
    QA,

    @EnumValue("CLASSIFICATION")
    CLASSIFICATION,

    @EnumValue("SOCOCO")
    SOCOCO,

    @EnumValue("SENTENCE")
    SENTENCE,

    @EnumValue("CONVERSATION")
    CONVERSATION,

    @EnumValue("CARDS")
    CARDS,

    @EnumValue("SOUND")
    SOUND




}
