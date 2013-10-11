/**
 * Created with IntelliJ IDEA.
 * User: Juanola
 * Date: 10/11/13
 * Time: 4:57 AM
 * To change this template use File | Settings | File Templates.
 */

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import models.*;

import java.util.Date;
import org.codehaus.jackson.JsonNode;
import org.junit.*;

import play.mvc.*;
import play.test.*;
import play.data.DynamicForm;
import play.data.validation.ValidationError;
import play.data.validation.Constraints.RequiredValidator;
import play.i18n.Lang;
import play.libs.F;
import play.libs.F.*;

import static play.test.Helpers.*;
import static org.fest.assertions.Assertions.*;

public class TherapistTest extends BaseModelTest {

    @Test
    public void AddAdminTest() {
        Address institutionAddress = new Address("Libertad","1250","3","D","1638","Vicente Lopez","Buenos Aires");
        Address therapistAddress = new Address("Cabildo","1250","3","D","1638","Vicente Lopez","Buenos Aires");
        Institution institution = new Institution("Dacaid",institutionAddress,"47911234");

        Therapist therapist = new Therapist("Juan","Molteni","47911306","123",therapistAddress,"33850398","juanignaciomolteni@gmail.com",new Date(), Gender.MALE,"asd","123456","", TherapistType.ADMIN,institution);

        Therapist therapistAssert = Therapist.findTherapistByDNI(therapist.dni);

        assertThat(therapist).isEqualTo(therapistAssert);
    }
}
