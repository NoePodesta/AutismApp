
# --- !Ups


insert into Therapists (id,name,surname,cellphone, telephone,address,dni,mail,birthday,image,nm,password,is_admin) values (3,'Sofia',
'Martuch','1156042381', '45673456','Alvarez Thomas 1345','32456321','sofimart@gmail.com','1985-10-30', null, '45678', 'sofi', false);

insert into Therapists (id,name,surname,cellphone, telephone,address,dni,mail,birthday,image,nm,password,is_admin) values (2,'Belu',
'Podesta','1155041451', '45463187','Congreso 3441','33567834','podestamb@gmail.com','1988-08-08', null ,'57896', 'belu',true);

insert into Therapists (id,name,surname,cellphone, telephone,address,dni,mail,birthday,image,nm,password.is_admin) values (4,'emilia',
'Perez','1144047681', '45673456','Cabildo 1300','34543123','emi@gmail.com','1989-12-30',null, '45678', 'emi',false);

insert into Therapists (id,name,surname,cellphone,telephone,address,dni,mail,birthday,image, nm,password,is_admin) values (5,'Laura',
'Carrazco', '1149871981','4532468','Conde 3441','4567457','lauchi@gmail.com','1986-10-04',null, '98765', 'lau',false);

# --- !Downs

delete from Administrator;
delete from Therapists


