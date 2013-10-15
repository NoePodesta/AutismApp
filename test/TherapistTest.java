/**
 * Created with IntelliJ IDEA.
 * User: Juanola
 * Date: 10/11/13
 * Time: 4:57 AM
 * To change this template use File | Settings | File Templates.
 */

import com.avaje.ebean.Ebean;
import models.*;
import org.junit.Test;

import java.util.Date;

import static org.fest.assertions.Assertions.assertThat;

public class TherapistTest extends BaseModelTest {

    @Test
    public void AddAdminTest() {
        Address institutionAddress = new Address("Libertad","1250","3","D","1638","Vicente Lopez","Buenos Aires");
        Address therapistAddress = new Address("Cabildo","1250","3","D","1638","Vicente Lopez","Buenos Aires");
        Institution institution = new Institution("Dacaid",institutionAddress,"47911234");

        Therapist therapist = new Therapist("Juan","Molteni","47911306","123",therapistAddress,"33850398","juanignaciomolteni@gmail.com",new Date(), Gender.MALE,"asd","123456","", TherapistType.ADMIN,institution);

        Ebean.save(institutionAddress);
        Ebean.save(therapistAddress);
        Ebean.save(institution);
        Ebean.save(therapist);

        Therapist therapistAssert = Therapist.findTherapistByDNI(therapist.dni);

        assertThat(therapist.id).isEqualTo(therapistAssert.id);
    }

    @Test
    public void AddTherapistsTest() {
        Address therapistAddress = new Address("Cabildo","1250","3","D","1638","Vicente Lopez","Buenos Aires");
        Institution institution = Institution.getById(1);

        Therapist therapist = new Therapist("Juan","Molteni","47911306","123",therapistAddress,"33850398","juanignaciomolteni@gmail.com",new Date(), Gender.MALE,"asd","123456","", TherapistType.NO_PRIVILEGES,institution);
        Therapist therapist2 = new Therapist("Juan","Molteni","47911306","123",therapistAddress,"33850397","juanignaciomolteni@gmail.com",new Date(), Gender.MALE,"asd","123456","", TherapistType.NO_PRIVILEGES,institution);

        Ebean.save(therapistAddress);
        Ebean.save(therapist);
        Ebean.save(therapist2);

        Therapist therapistAssert = Therapist.findTherapistByDNI(therapist.dni);
        Therapist therapistAssert2 = Therapist.findTherapistByDNI(therapist2.dni);

        assertThat(therapist.id).isEqualTo(therapistAssert.id);
        assertThat(therapist2.id).isEqualTo(therapistAssert2.id);
    }



}
