--  28/03/2018 p  
--  добавл€ютьс€ балансов≥ рахунки 8 класу 
--  8600, 8608 дл€ 2600, 2608,  8610 дл€ 2610, 8651 дл€ 2651,
--  8652 дл€ 2652, 8655 дл€ 2655    (генугоди)  

exec bc.home;


delete from kl_f3_29 
where kf='E8' and r020 in ('8600', '8608', '8610', '8615', 
                           '8651', '8652', '8655');

-- добалены бал. счета 8600,8608,'8610','8615','8651','8652','8655'
INSERT INTO KL_F3_29 
   (KF, R020, R050, R012, DDD, TXT, S240 ) 
 VALUES 
   ('E8', '8600', '22', '2', '121', NULL, NULL); 

INSERT INTO KL_F3_29 
   (KF, R020, R050, R012, DDD, TXT, S240 ) 
 VALUES 
   ('E8', '8608', '22', '2', '123', NULL, NULL); 
Insert into BARS.KL_F3_29
   (KF, R020, R050, R012, DDD)
 Values
   ('E8', '8610', '22', '2', '121');
Insert into BARS.KL_F3_29
   (KF, R020, R050, R012, DDD)
 Values
   ('E8', '8615', '22', '2', '121');
Insert into BARS.KL_F3_29
   (KF, R020, R050, R012, DDD)
 Values
   ('E8', '8651', '22', '2', '121');
Insert into BARS.KL_F3_29
   (KF, R020, R050, R012, DDD)
 Values
   ('E8', '8652', '22', '2', '121');
Insert into BARS.KL_F3_29
   (KF, R020, R050, R012, DDD)
 Values
   ('E8', '8655', '03', '2', '121');

COMMIT;


