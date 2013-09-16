
# --- !Ups

insert into Address (id,street,number,floor,depto,cp,locality,province) value (1,'Congreso',3441,null,null,1430,
'Capital Federal','Capital Federal');

insert into Therapists (id,name,surname,cellphone, telephone, address_id, dni,gender, mail,birthday, image, nm, password, therapist_type) values
(1,'noe','podesta','1144041981' ,'45463187',1,'34906400', 'Female' ,'noe.podesta@gmail.com','1989-11-30',  'uploads/noepodesta/DSC03433-001.jpg', '34567','noe123', 'ADMIN');

insert into Therapists (id,name,surname,cellphone, telephone, address_id,dni, gender, mail,birthday,image,nm,password,therapist_type) values
(2,'Sofia','Martuch','1156042381', '45673456',1,'32456321','Female', 'sofimart@gmail.com','1985-10-30', 'uploads/female.jpg', '45678', 'sofi12', 'ADMIN_COORDINATOR');

insert into Therapists (id,name,surname,cellphone, telephone,address_id,dni,gender,mail,birthday,image,nm,password, therapist_type) values (3,'Belén',
'Podesta','1155041451', '45463187', 1,'33567834', 'Female','podestamb@gmail.com','1988-08-08', '/uploads/belupodesta/DSC03551-001.JPG' ,'57896', 'belu12','ADMIN_COORDINATOR');

insert into Therapists (id,name,surname,cellphone, telephone,address_id,dni,gender,mail,birthday,image,nm,password, therapist_type) values (4,'emilia',
'Perez','1144047681', '45673456',1,'34543123', 'Female' ,'emi@gmail.com','1989-12-30', 'uploads/female.jpg', '45678', 'emi123','ADMIN_COORDINATOR');

insert into Therapists (id,name,surname,cellphone,telephone,address_id,dni,gender,mail,birthday,image, nm,password,therapist_type) values (5,'Laura',
'Carrazco', '1149871981','4532468',1,'4567457', 'Female','lauchi@gmail.com','1986-10-04', 'uploads/female.jpg', '98765', 'lau123','ADMIN_COORDINATOR');

insert into Patients (id,name,surname,address_id,cellphone,telephone,dni,gender,mail,birthday,image,medical_coverage,n_medical_coverage,
                     disease,grade_disease,q_award_a, q_award_b, q_award_c) values
(6,'Genaro', 'Frap',1, '1145679876','54329876','45876976', 'Female','geniii@gmail.com','2009-07-10', 'uploads/male.jpg', 'osde',
'3467876456','tgd',1, 2, 0, 0 );

insert into Patients (id,name,surname,address_id,cellphone,telephone,dni,gender,mail,birthday,image,medical_coverage,n_medical_coverage,
                      disease,grade_disease,q_award_a, q_award_b, q_award_c) values
(7,'Genaro', 'Frap',1, '1145679876','54329876','45876976', 'Female','geniii@gmail.com','2009-07-10', 'uploads/male.jpg', 'osde',
 '3467876456','tgd',1, 2, 0, 0 );

insert into Patients (id,name,surname,address_id,cellphone,telephone,dni,gender,mail,birthday,image,medical_coverage,n_medical_coverage,
                      disease,grade_disease,q_award_a, q_award_b, q_award_c) values
(8,'Genaro', 'Frap',1, '1145679876','54329876','45876976', 'Female','geniii@gmail.com','2009-07-10', 'uploads/male.jpg', 'osde',
 '3467876456','tgd',1, 2, 0, 0 );

insert into Patients (id,name,surname,address_id,cellphone,telephone,dni,gender,mail,birthday,image,medical_coverage,n_medical_coverage,
                      disease,grade_disease,q_award_a, q_award_b, q_award_c) values
(9,'Genaro', 'Frap',1, '1145679876','54329876','45876976', 'Female','geniii@gmail.com','2009-07-10', 'uploads/male.jpg', 'osde',
 '3467876456','tgd',1, 2, 0, 0 );

# --- !Downs

delete from Therapists;
delete from Patients;
delete from Address;

