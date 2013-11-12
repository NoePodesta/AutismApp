package models;

import play.db.ebean.Model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
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
public class GamePackage extends Model {

    @Id
    private int id;
    private Game gameType;
    private String packageName;
    private String jsonContent;
    private String packageUrl;
    @ManyToOne
    private Therapist therapist;

    public static Model.Finder<Integer,GamePackage> find = new Model.Finder(Integer.class, GamePackage.class);

    public GamePackage(String packageName, String jsonContent, Game gameType, String packageUrl, Therapist therapist) {
        this.packageName = packageName;
        this.jsonContent = jsonContent;
        this.gameType = gameType;
        this.packageUrl = packageUrl;
        this.therapist = therapist;
    }


    public static GamePackage findPackageById(int id) {
        return find.byId(id);
    }

    public static List<GamePackage> findByTherapist(Therapist therapist){
        return find.where().eq("therapist", therapist).findList();
    }

    public Game getGameType() {
        return gameType;
    }

    public String getPackageName() {
        return packageName;
    }

    public String getJsonContent() {
        return jsonContent;
    }

    public String getPackageUrl() {
        return packageUrl;
    }
}
