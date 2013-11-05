package models;

import play.db.ebean.Model;

import javax.persistence.*;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Juanola
 * Date: 11/4/13
 * Time: 2:49 PM
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name="Packages")
public class Package extends Model {

    @Id
    private int id;
    private String packageName;
    private String jsonContent;
    @OneToMany(cascade = CascadeType.ALL)
    private List<TestResult> usedResults;




}
