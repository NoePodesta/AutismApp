package models;

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


@Entity
@Table(name = "Game")
public class Game {

    @Id
    @Column(name = "idGame")
    private int id;
    @Constraints.Required
    private String name;

}
