# --- Created by Ebean DDL
# To stop Ebean DDL generation, remove this comment and start using Evolutions

# --- !Ups

create table Administrator (
  id                        integer auto_increment not null,
  name                      varchar(255),
  surname                   varchar(255),
  address                   varchar(255),
  cellphone                 varchar(255),
  telephone                 varchar(255),
  dni                       integer,
  mail                      varchar(255),
  birthday                  datetime,
  image                     varchar(255),
  Password                  varchar(255),
  constraint pk_Administrator primary key (id))
;

create table Coordinator (
  id                        integer auto_increment not null,
  name                      varchar(255),
  surname                   varchar(255),
  address                   varchar(255),
  cellphone                 varchar(255),
  telephone                 varchar(255),
  dni                       integer,
  mail                      varchar(255),
  birthday                  datetime,
  image                     varchar(255),
  nm                        integer,
  password                  varchar(255),
  constraint pk_Coordinator primary key (id))
;

create table Game (
  idGame                    integer auto_increment not null,
  name                      varchar(255),
  constraint pk_Game primary key (idGame))
;

create table Patient (
  id                        integer auto_increment not null,
  name                      varchar(255),
  surname                   varchar(255),
  address                   varchar(255),
  cellphone                 varchar(255),
  telephone                 varchar(255),
  dni                       integer,
  mail                      varchar(255),
  birthday                  datetime,
  image                     varchar(255),
  medical_coverage          varchar(255),
  n_medical_coverage        integer,
  disease                   varchar(255),
  grade_disease             integer,
  q_award_a                 integer,
  q_award_b                 integer,
  q_award_c                 integer,
  summy                     varchar(255),
  constraint pk_Patient primary key (id))
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

create table Therapist (
  id                        integer auto_increment not null,
  name                      varchar(255),
  surname                   varchar(255),
  address                   varchar(255),
  cellphone                 varchar(255),
  telephone                 varchar(255),
  dni                       integer,
  mail                      varchar(255),
  birthday                  datetime,
  image                     varchar(255),
  nm                        integer,
  password                  varchar(255),
  constraint pk_Therapist primary key (id))
;

create table User (
  id                        integer auto_increment not null,
  name                      varchar(255),
  surname                   varchar(255),
  address                   varchar(255),
  cellphone                 varchar(255),
  telephone                 varchar(255),
  dni                       integer,
  mail                      varchar(255),
  birthday                  datetime,
  image                     varchar(255),
  constraint pk_User primary key (id))
;


create table Patient_Therapist (
  Patient_id                     integer not null,
  Therapist_id                   integer not null,
  constraint pk_Patient_Therapist primary key (Patient_id, Therapist_id))
;
alter table Results add constraint fk_Results_game_1 foreign key (game_idGame) references Game (idGame) on delete restrict on update restrict;
create index ix_Results_game_1 on Results (game_idGame);
alter table Results add constraint fk_Results_patient_2 foreign key (patient_id) references Patient (id) on delete restrict on update restrict;
create index ix_Results_patient_2 on Results (patient_id);
alter table Results add constraint fk_Results_therapist_3 foreign key (therapist_id) references Therapist (id) on delete restrict on update restrict;
create index ix_Results_therapist_3 on Results (therapist_id);



alter table Patient_Therapist add constraint fk_Patient_Therapist_Patient_01 foreign key (Patient_id) references Patient (id) on delete restrict on update restrict;

alter table Patient_Therapist add constraint fk_Patient_Therapist_Therapist_02 foreign key (Therapist_id) references Therapist (id) on delete restrict on update restrict;

# --- !Downs

SET FOREIGN_KEY_CHECKS=0;

drop table Administrator;

drop table Coordinator;

drop table Patient_Therapist;

drop table Game;

drop table Patient;

drop table Results;

drop table Therapist;

drop table User;

SET FOREIGN_KEY_CHECKS=1;

