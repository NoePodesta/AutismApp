# --- !Ups

insert into User (id,name,surname,telephone,address,dni,mail,birthday) values (1,'Noe','Podesta',45463187,
'Congreso 3441',34906400,'noe.podesta@gmail.com','1989-11-30');

insert into Therapists (id,name,surname,telephone,address,dni,mail,birthday,nm,password) values (3,'Sofia',
'Martuch',45673456,'Alvarez Thomas 1345',32456321,'sofimart@gmail.com','1985-10-30',45678, 'sofi');

insert into Therapists (id,name,surname,telephone,address,dni,mail,birthday,nm,password) values (2,'Belu',
'Podesta',45463187,'Congreso 3441',33567834,'podestamb@gmail.com','1988-08-08',57896, 'belu');

insert into Therapists (id,name,surname,telephone,address,dni,mail,birthday,nm,password) values (4,'emilia',
'Perez',45673456,'Cabildo 1300',34543123,'emi@gmail.com','1989-11-30',45678, 'emi');

insert into Therapists (id,name,surname,telephone,address,dni,mail,birthday,nm,password) values (5,'Laura',
'Carrazco',4532468,'Conde 3441',4567457,'lauchi@gmail.com','1986-10-04',98765, 'lau');

# --- !Downs

delete from User;
delete from Therapists
