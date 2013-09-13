# --- Created by Ebean DDL
# To stop Ebean DDL generation, remove this comment and start using Evolutions

# --- !Ups

create table Game (
  idGame                    integer auto_increment not null,
  name                      varchar(255),
  constraint pk_Game primary key (idGame))
;

create table Institutions (
  id                        integer auto_increment not null,
  name                      varchar(255),
  constraint pk_Institutions primary key (id))
;

create table Patients (
  id                        integer auto_increment not null,
  name                      varchar(255),
  surname                   varchar(255),
  address                   varchar(255),
  cellphone                 varchar(255),
  telephone                 varchar(255),
  dni                       varchar(255),
  mail                      varchar(255),
  birthday                  datetime,
  image                     varchar(255),
  medical_coverage          varchar(255),
  n_medical_coverage        varchar(255),
  disease                   varchar(255),
  grade_disease             integer,
  team_id                   integer,
  q_award_a                 integer,
  q_award_b                 integer,
  q_award_c                 integer,
  constraint pk_Patients primary key (id))
;

create table Results (
  idResult                  integer auto_increment not null,
  game_idGame               integer not null,
  patient_id                integer not null,
  therapist_id              integer not null,
  punctuation               integer,
  description               varchar(255),
  constraint pk_Results primary key (idResult))
;

create table team (
  id                        integer auto_increment not null,
  patient_id                integer,
  constraint pk_team primary key (id))
;

create table Therapists (
  id                        integer auto_increment not null,
  name                      varchar(255),
  surname                   varchar(255),
  address                   varchar(255),
  cellphone                 varchar(255),
  telephone                 varchar(255),
  dni                       varchar(255),
  mail                      varchar(255),
  birthday                  datetime,
  image                     varchar(255),
  nm                        varchar(255),
  password                  varchar(255),
  therapist_type            varchar(13),
  constraint ck_Therapists_therapist_type check (therapist_type in ('ADMIN','NO_PRIVILEGES')),
  constraint pk_Therapists primary key (id))
;

create table therapist_role (
  id                        integer auto_increment not null,
  role                      varchar(11),
  team_id                   integer,
  constraint ck_therapist_role_role check (role in ('COORDINATOR','SUPERVISOR','INTEGRATOR','THERAPIST')),
  constraint pk_therapist_role primary key (id))
;

create table User (
  id                        integer auto_increment not null,
  name                      varchar(255),
  surname                   varchar(255),
  address                   varchar(255),
  cellphone                 varchar(255),
  telephone                 varchar(255),
  dni                       varchar(255),
  mail                      varchar(255),
  birthday                  datetime,
  image                     varchar(255),
  constraint pk_User primary key (id))
;

alter table Patients add constraint fk_Patients_team_1 foreign key (team_id) references team (id) on delete restrict on update restrict;
create index ix_Patients_team_1 on Patients (team_id);
alter table Results add constraint fk_Results_game_2 foreign key (game_idGame) references Game (idGame) on delete restrict on update restrict;
create index ix_Results_game_2 on Results (game_idGame);
alter table Results add constraint fk_Results_patient_3 foreign key (patient_id) references Patients (id) on delete restrict on update restrict;
create index ix_Results_patient_3 on Results (patient_id);
alter table Results add constraint fk_Results_therapist_4 foreign key (therapist_id) references Therapists (id) on delete restrict on update restrict;
create index ix_Results_therapist_4 on Results (therapist_id);
alter table team add constraint fk_team_patient_5 foreign key (patient_id) references Patients (id) on delete restrict on update restrict;
create index ix_team_patient_5 on team (patient_id);
alter table therapist_role add constraint fk_therapist_role_team_6 foreign key (team_id) references team (id) on delete restrict on update restrict;
create index ix_therapist_role_team_6 on therapist_role (team_id);



# --- !Downs

SET FOREIGN_KEY_CHECKS=0;

drop table Game;

drop table Institutions;

drop table Patients;

drop table Results;

drop table team;

drop table Therapists;

drop table therapist_role;

drop table User;

SET FOREIGN_KEY_CHECKS=1;

