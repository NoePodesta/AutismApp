package models;

import com.avaje.ebean.annotation.EnumValue;

import java.util.ArrayList;
import java.util.List;


public enum Gender {

    @EnumValue("Female")
    FEMALE,

    @EnumValue("MALE")
    MALE;


    public static List<String> all(){

        List<String> result = new ArrayList<String>();

        result.add(FEMALE.name());
        result.add(MALE.name());

        return result;
    }

    public boolean isFemale(){
        return equals(FEMALE);
    }

    public boolean isMale(){
        return equals(MALE);
    }

}
