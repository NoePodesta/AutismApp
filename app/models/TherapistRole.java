package models;

import com.avaje.ebean.annotation.EnumValue;

/**
 * Created with IntelliJ IDEA.
 * User: Juani
 * Date: 9/12/13
 * Time: 12:05 AM
 * To change this template use File | Settings | File Templates.
 */

public enum TherapistRole{

    @EnumValue("SUPERVISOR")
    SUPERVISOR,

    @EnumValue("THERAPIST")
    THERAPIST,

    @EnumValue("COORDINATOR")
    COORDINATOR,

    @EnumValue("INTEGRATOR")
    INTEGRATOR,


}