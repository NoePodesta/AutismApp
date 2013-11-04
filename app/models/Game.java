package models;

import com.avaje.ebean.annotation.EnumValue;
import play.data.validation.Constraints;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

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




}
