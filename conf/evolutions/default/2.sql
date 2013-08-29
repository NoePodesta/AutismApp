

# --- !Ups

insert into User (id,name,surname,telephone,address,dni,mail,birthday) values (1,'Noe','Podesta',45463187,
'Congreso 3441',34906400,'noe.podesta@gmail.com','1989-11-30');


# --- !Downs

delete from User;

