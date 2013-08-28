package models;


import play.data.validation.Constraints;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "Game")
public class Game {

    @Id
    private int gameId;
    @Constraints.Required
    private String name;

}
