

# --- !Ups

insert into User (id,name,surname,telephone,address,dni,mail,birthday) values (1,'Noe','Podesta',45463187,
'Congreso 3441',34906400,'noe.podesta@gmail.com','1989-11-30');
insert into Therapists (id,name,surname,telephone,address,dni,mail,birthday,nm,password) values (2,'Belu',
'Podesta',45463187,'Congreso 3441',33567834,'podestamb@gmail.com','1988-08-08',57896, 'belu');

# --- !Downs

delete from User;
delete from Therapists

