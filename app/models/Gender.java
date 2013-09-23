package models;

import com.avaje.ebean.annotation.EnumValue;

import java.util.ArrayList;
import java.util.List;


public enum Gender {

    @EnumValue("Female")
    FEMALE("Female"),

    @EnumValue("Male")
    MALE("Male");

    String value;

    Gender(String value){
        this.value = value;

    }

    String getValue(){
        return value;
    }
    public static List<String> all(){

        List<String> result = new ArrayList<String>();

        result.add(FEMALE.getValue());
        result.add(MALE.getValue());

        return result;
    }

    public boolean isFemale(){
        return equals(FEMALE.toString());
    }

    public boolean isMale(){
        return equals(MALE.toString());
    }

}
