
# --- !Ups

insert into Address (id,street,number,floor,depto,cp,locality,province) value (3,'Congreso',3441,null,null,1430,
'Capital Federal','Capital Federal');

insert into Therapists (id,name,surname,cellphone, telephone, address_id,dni, gender, mail,birthday,image,nm,password,therapist_type) values
(6,'Sofia','Martuch','1156042381', '45673456',3,'32456321','Female', 'sofimart@gmail.com','1985-10-30', 'uploads/female.jpg', '45678', 'sofi12', 'ADMIN');

insert into Therapists (id,name,surname,cellphone, telephone,address_id,dni,gender,mail,birthday,image,nm,password, therapist_type) values (7,'Belén',
'Podesta','1156041451', '45463187', 3,'33567834', 'Female','podestamb@gmail.com','1988-08-08', '/uploads/belupodesta/DSC03551-001.JPG' ,'57896', 'belu12','ADMIN');

insert into Therapists (id,name,surname,cellphone, telephone,address_id,dni,gender,mail,birthday,image,nm,password, therapist_type) values (8,'emilia',
'Perez','1144047681', '45673466',3,'34543123', 'Female' ,'emi@gmail.com','1989-12-30', 'uploads/female.jpg', '45678', 'emi123','ADMIN');

insert into Therapists (id,name,surname,cellphone,telephone,address_id,dni,gender,mail,birthday,image, nm,password,therapist_type) values (9,'Laura',
'Carrasco', '1149871981','4532468',3,'4567457', 'Female','lauchi@gmail.com','1986-10-04', 'uploads/female.jpg', '98765', 'lau123','ADMIN');

insert into Patients (id,name,surname,address_id,cellphone,telephone,dni,gender,mail,birthday,image,medical_coverage,n_medical_coverage,
                     disease,grade_disease,q_award_a, q_award_b, q_award_c) values
(10,'Genaro', 'Frapole',3, '1145679876','54329876','45876976', 'Female','geniii@gmail.com','2009-07-10', 'uploads/male.jpg', 'osde',
'3467876456','tgd',1, 2, 0, 0 );

insert into Patients (id,name,surname,address_id,cellphone,telephone,dni,gender,mail,birthday,image,medical_coverage,n_medical_coverage,
                      disease,grade_disease,q_award_a, q_award_b, q_award_c) values
(11,'Genaro', 'Fraper',3, '1145679876','54329876','45876976', 'Female','geniii@gmail.com','2009-07-10', 'uploads/male.jpg', 'osde',
 '3467876456','thhgd',1, 2, 0, 0 );

insert into Patients (id,name,surname,address_id,cellphone,telephone,dni,gender,mail,birthday,image,medical_coverage,n_medical_coverage,
                      disease,grade_disease,q_award_a, q_award_b, q_award_c) values
(12,'Genaro', 'Frap',3, '1145679876','54329876','45876976', 'Female','geniii@gmail.com','2009-07-10', 'uploads/male.jpg', 'osde',
 '3467876456','tgd',1, 2, 0, 0 );

insert into Patients (id,name,surname,address_id,cellphone,telephone,dni,gender,mail,birthday,image,medical_coverage,n_medical_coverage,
                      disease,grade_disease,q_award_a, q_award_b, q_award_c) values
(13,'Genaro', 'Frap',3, '1145679876','54329876','45876976', 'Female','geniii@gmail.com','2009-07-10', 'uploads/male.jpg', 'osde',
 '3467876456','tgd','ALto', 2, 0, 0 );

# --- !Downs

delete from Therapists;
delete from Patients;
delete from institutions;
delete from Address;
delete from therapist_role;


