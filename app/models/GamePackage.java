package models;

import play.db.ebean.Model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created with IntelliJ IDEA.
 * User: Juanola
 * Date: 11/4/13
 * Time: 2:49 PM
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name="Packages")
public class GamePackage extends Model {

    @Id
    private int id;
    private String packageName;
    private String jsonContent;



    public GamePackage(String packageName, String jsonContent) {
        this.packageName = packageName;
        this.jsonContent = jsonContent;
    }


}
