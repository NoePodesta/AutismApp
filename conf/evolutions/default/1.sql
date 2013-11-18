# --- Created by Ebean DDL
# To stop Ebean DDL generation, remove this comment and start using Evolutions

# --- !Ups

create table Address (
  id                        integer auto_increment not null,
  street                    varchar(255),
  number                    varchar(255),
  floor                     varchar(255),
  depto                     varchar(255),
  cp                        varchar(255),
  locality                  varchar(255),
  province                  varchar(255),
  constraint pk_Address primary key (id))
;

create table Packages (
  id                        integer auto_increment not null,
  game_type                 varchar(14),
  package_name              varchar(255),
  package_url               varchar(255),
  therapist_id              integer,
  constraint ck_Packages_game_type check (game_type in ('SOUND','QA','CONVERSATION','SOCOCO','SENTENCE','CLASSIFICATION','CARDS')),
  constraint pk_Packages primary key (id))
;

create table Institutions (
  id                        integer auto_increment not null,
  name                      varchar(255),
  address_id                integer,
  telephone                 varchar(255),
  mail                      varchar(255),
  image                     varchar(255),
  constraint pk_Institutions primary key (id))
;

create table Patients (
  id                        integer auto_increment not null,
  name                      varchar(255),
  surname                   varchar(255),
  address_id                integer,
  cellphone                 varchar(255),
  telephone                 varchar(255),
  dni                       varchar(255),
  gender                    varchar(6),
  mail                      varchar(255),
  birthday                  datetime,
  image                     varchar(255),
  medical_coverage          varchar(255),
  n_medical_coverage        varchar(255),
  disease                   varchar(255),
  grade_disease             varchar(255),
  team_id                   integer,
  institution_id            integer,
  constraint ck_Patients_gender check (gender in ('Female','Male')),
  constraint uq_Patients_dni unique (dni),
  constraint pk_Patients primary key (id))
;

create table Teams (
  id                        integer auto_increment not null,
  patient_id                integer,
  institution_id            integer,
  constraint pk_Teams primary key (id))
;

create table team_roles (
  id                        integer auto_increment not null,
  therapist_id              integer,
  role                      varchar(255),
  team_id                   integer,
  constraint pk_team_roles primary key (id))
;

create table TestResult (
  id                        integer auto_increment not null,
  game                      varchar(14),
  patient_id                integer,
  therapist_id              integer,
  correct_answers           integer,
  wrong_answers             integer,
  date_made                 datetime,
  a_game_package_id         integer,
  team_id                   integer,
  constraint ck_TestResult_game check (game in ('SOUND','QA','CONVERSATION','SOCOCO','SENTENCE','CLASSIFICATION','CARDS')),
  constraint pk_TestResult primary key (id))
;

create table Therapists (
  id                        integer auto_increment not null,
  name                      varchar(255),
  surname                   varchar(255),
  address_id                integer,
  cellphone                 varchar(255),
  telephone                 varchar(255),
  dni                       varchar(255),
  gender                    varchar(6),
  mail                      varchar(255),
  birthday                  datetime,
  image                     varchar(255),
  nm                        varchar(255),
  password                  varchar(255),
  therapist_type            varchar(13),
  institution_id            integer,
  constraint ck_Therapists_gender check (gender in ('Female','Male')),
  constraint ck_Therapists_therapist_type check (therapist_type in ('ADMIN','NO_PRIVILEGES')),
  constraint uq_Therapists_dni unique (dni),
  constraint pk_Therapists primary key (id))
;

create table User (
  id                        integer auto_increment not null,
  name                      varchar(255),
  surname                   varchar(255),
  address_id                integer,
  cellphone                 varchar(255),
  telephone                 varchar(255),
  dni                       varchar(255),
  gender                    varchar(6),
  mail                      varchar(255),
  birthday                  datetime,
  image                     varchar(255),
  constraint ck_User_gender check (gender in ('Female','Male')),
  constraint uq_User_dni unique (dni),
  constraint pk_User primary key (id))
;


create table Therapists_Teams (
  Therapists_id                  integer not null,
  Teams_id                       integer not null,
  constraint pk_Therapists_Teams primary key (Therapists_id, Teams_id))
;
alter table Packages add constraint fk_Packages_therapist_1 foreign key (therapist_id) references Therapists (id) on delete restrict on update restrict;
create index ix_Packages_therapist_1 on Packages (therapist_id);
alter table Institutions add constraint fk_Institutions_address_2 foreign key (address_id) references Address (id) on delete restrict on update restrict;
create index ix_Institutions_address_2 on Institutions (address_id);
alter table Patients add constraint fk_Patients_address_3 foreign key (address_id) references Address (id) on delete restrict on update restrict;
create index ix_Patients_address_3 on Patients (address_id);
alter table Patients add constraint fk_Patients_team_4 foreign key (team_id) references Teams (id) on delete restrict on update restrict;
create index ix_Patients_team_4 on Patients (team_id);
alter table Patients add constraint fk_Patients_institution_5 foreign key (institution_id) references Institutions (id) on delete restrict on update restrict;
create index ix_Patients_institution_5 on Patients (institution_id);
alter table Teams add constraint fk_Teams_patient_6 foreign key (patient_id) references Patients (id) on delete restrict on update restrict;
create index ix_Teams_patient_6 on Teams (patient_id);
alter table Teams add constraint fk_Teams_institution_7 foreign key (institution_id) references Institutions (id) on delete restrict on update restrict;
create index ix_Teams_institution_7 on Teams (institution_id);
alter table team_roles add constraint fk_team_roles_therapist_8 foreign key (therapist_id) references Therapists (id) on delete restrict on update restrict;
create index ix_team_roles_therapist_8 on team_roles (therapist_id);
alter table team_roles add constraint fk_team_roles_team_9 foreign key (team_id) references Teams (id) on delete restrict on update restrict;
create index ix_team_roles_team_9 on team_roles (team_id);
alter table TestResult add constraint fk_TestResult_patient_10 foreign key (patient_id) references Patients (id) on delete restrict on update restrict;
create index ix_TestResult_patient_10 on TestResult (patient_id);
alter table TestResult add constraint fk_TestResult_therapist_11 foreign key (therapist_id) references Therapists (id) on delete restrict on update restrict;
create index ix_TestResult_therapist_11 on TestResult (therapist_id);
alter table TestResult add constraint fk_TestResult_aGamePackage_12 foreign key (a_game_package_id) references Packages (id) on delete restrict on update restrict;
create index ix_TestResult_aGamePackage_12 on TestResult (a_game_package_id);
alter table TestResult add constraint fk_TestResult_team_13 foreign key (team_id) references Teams (id) on delete restrict on update restrict;
create index ix_TestResult_team_13 on TestResult (team_id);
alter table Therapists add constraint fk_Therapists_address_14 foreign key (address_id) references Address (id) on delete restrict on update restrict;
create index ix_Therapists_address_14 on Therapists (address_id);
alter table Therapists add constraint fk_Therapists_institution_15 foreign key (institution_id) references Institutions (id) on delete restrict on update restrict;
create index ix_Therapists_institution_15 on Therapists (institution_id);
alter table User add constraint fk_User_address_16 foreign key (address_id) references Address (id) on delete restrict on update restrict;
create index ix_User_address_16 on User (address_id);



alter table Therapists_Teams add constraint fk_Therapists_Teams_Therapists_01 foreign key (Therapists_id) references Therapists (id) on delete restrict on update restrict;

alter table Therapists_Teams add constraint fk_Therapists_Teams_Teams_02 foreign key (Teams_id) references Teams (id) on delete restrict on update restrict;

# --- !Downs

SET FOREIGN_KEY_CHECKS=0;

drop table Address;

drop table Packages;

drop table Institutions;

drop table Patients;

drop table Teams;

drop table team_roles;

drop table TestResult;

drop table Therapists;

drop table Therapists_Teams;

drop table User;

SET FOREIGN_KEY_CHECKS=1;

