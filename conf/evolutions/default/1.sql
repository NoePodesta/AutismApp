# --- Created by Ebean DDL
# To stop Ebean DDL generation, remove this comment and start using Evolutions

# --- !Ups

create table patient (
  id                        integer auto_increment not null,
  name                      varchar(255),
  dni                       integer,
  address                   varchar(255),
  telephone                 varchar(255),
  birthday                  datetime,
  medical_coverage          varchar(255),
  disease                   varchar(255),
  grade_disease             integer,
  q_award_a                 integer,
  q_award_b                 integer,
  q_award_c                 integer,
  constraint pk_patient primary key (id))
;

create table user (
  id                        integer auto_increment not null,
  name                      varchar(255),
  dni                       integer,
  address                   varchar(255),
  telephone                 varchar(255),
  birthday                  datetime,
  constraint pk_user primary key (id))
;




# --- !Downs

SET FOREIGN_KEY_CHECKS=0;

drop table patient;

drop table user;

SET FOREIGN_KEY_CHECKS=1;

