package models;

import com.avaje.ebean.annotation.EnumValue;

/**
 * Created with IntelliJ IDEA.
 * User: Juani
 * Date: 9/8/13
 * Time: 11:03 PM
 * To change this template use File | Settings | File Templates.
 */
public enum TherapistType{

    @EnumValue("ADMIN")
    ADMIN,

    @EnumValue("COORDINATOR")
    COORDINATOR,

    @EnumValue("ADMIN_COORDINATOR")
    ADMIN_COORDINATOR,

    @EnumValue("NO_PRIVILEGES")
    NO_PRIVILEGES,


}
