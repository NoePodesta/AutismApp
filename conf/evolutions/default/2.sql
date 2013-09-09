# --- !Ups

insert into Administrator (id,name,surname,cellphone, telephone,address,dni,mail,birthday, image, password) values
(1,'Noe','Podesta','1144041981' ,'45463187', 'Congreso 3441','34906400' ,'noe.podesta@gmail.com','1989-11-30', null, 'noe');

insert into Therapists (id,name,surname,cellphone, telephone,address,dni,mail,birthday,image,nm,password) values (3,'Sofia',
'Martuch','1156042381', '45673456','Alvarez Thomas 1345','32456321','sofimart@gmail.com','1985-10-30', null, '45678', 'sofi');

insert into Therapists (id,name,surname,cellphone, telephone,address,dni,mail,birthday,image,nm,password) values (2,'María Belén',
'Podesta','1158066532', '45463187','Congreso 3441','33850410','podestamb@gmail.com','1988-08-08', '/uploads/belupodesta/DSC03551-001.JPG'
  ,'56378', 'belu');

insert into Therapists (id,name,surname,cellphone, telephone,address,dni,mail,birthday,image,nm,password) values (4,'emilia',
'Perez','1144047681', '45673456','Cabildo 1300','34543123','emi@gmail.com','1989-12-30',null, '45678', 'emi');

insert into Therapists (id,name,surname,cellphone,telephone,address,dni,mail,birthday,image, nm,password) values (5,'Laura',
'Carrazco', '1149871981','4532468','Conde 3441','4567457','lauchi@gmail.com','1986-10-04',null, '98765', 'lau');

insert into Patient (id,name,surname,address,cellphone,telephone,dni,mail,birthday,image,medical_coverage,n_medical_coverage,
                     disease,grade_disease,q_award_a, q_award_b, q_award_c) values (6,'Genaro',
'Frap','Sta Brabrara Lote 41', '1145679876','54329876','45876976','geniii@gmail.com','2009-07-10',null, 'osde',
'3467876456','tgd',1, 2, 0, 0 );


# --- !Downs

delete from Administrator;
delete from Therapists;
delete from Patient
