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
  therapist_type            varchar(17),
  constraint ck_Therapists_therapist_type check (therapist_type in ('ADMIN','ADMIN_COORDINATOR','NO_PRIVILEGES','COORDINATOR')),
  constraint pk_Therapists primary key (id))
;

create table therapist_role (
  id                        integer auto_increment not null,
  role                      varchar(11),
  constraint ck_therapist_role_role check (role in ('COORDINATOR','SUPERVISOR','INTEGRATOR','THERAPIST')),
  constraint pk_therapist_role primary key (id))
;

create table user (
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
  constraint pk_user primary key (id))
;


create table team_therapist_role (
  team_id                        integer not null,
  therapist_role_id              integer not null,
  constraint pk_team_therapist_role primary key (team_id, therapist_role_id))
;

create table Therapists_team (
  Therapists_id                  integer not null,
  team_id                        integer not null,
  constraint pk_Therapists_team primary key (Therapists_id, team_id))
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



alter table team_therapist_role add constraint fk_team_therapist_role_team_01 foreign key (team_id) references team (id) on delete restrict on update restrict;

alter table team_therapist_role add constraint fk_team_therapist_role_therapist_role_02 foreign key (therapist_role_id) references therapist_role (id) on delete restrict on update restrict;

alter table Therapists_team add constraint fk_Therapists_team_Therapists_01 foreign key (Therapists_id) references Therapists (id) on delete restrict on update restrict;

alter table Therapists_team add constraint fk_Therapists_team_team_02 foreign key (team_id) references team (id) on delete restrict on update restrict;

# --- !Downs

SET FOREIGN_KEY_CHECKS=0;

drop table Game;

drop table Institutions;

drop table Patients;

drop table Results;

drop table team;

drop table team_therapist_role;

drop table Therapists;

drop table Therapists_team;

drop table therapist_role;

drop table user;

SET FOREIGN_KEY_CHECKS=1;

