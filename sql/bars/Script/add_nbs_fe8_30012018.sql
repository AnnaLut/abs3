--  30/01/2018 p на 01/01/2018 (зв≥т за грудень м≥с€ць) 
--  добавл€ютьс€ нов≥ балансов≥ рахунки 3335, 3303, 3313, 3314, 3611, 3642, 3647  
--  добавл€ютьс€ групи бал.рах 921, 936                                    


exec bc.home;

delete from kl_f3_29 where kf='E8' and r020 in ('3335');

-- добалены группы бал. счетов 3303, 3313, 3314
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '3335', '22', '2', '121', NULL, NULL); 

update kl_f3_29 set ddd='124'
where kf='E8' and ddd='121' and r020 in ('3335', '3315', '3385');

commit;

delete from kl_f3_29 where kf='E8' and r020 in ('3303', '3313', '3314');

-- добалены группы бал. счетов 3303, 3313, 3314
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '3303', '22', '2', '121', NULL, NULL); 
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '3313', '22', '2', '121', NULL, NULL); 
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '3314', '22', '2', '121', NULL, NULL); 

commit;

delete from kl_f3_29 where kf='E8' and r020 in ('3611', '3642', '3647');

-- добалены группы бал. счетов 3303, 3313, 3314
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '3611', '22', '2', '121', NULL, NULL); 
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '3642', '22', '2', '121', NULL, NULL); 
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '3647', '22', '2', '121', NULL, NULL); 

commit;

delete from kl_f3_29 
where kf='E8' and r020 in ('9210', '9211', '9212', '9213',
                           '9214', '9216', '9217', '9218', 
                           '9360', '9361', '9362', '9363', 
                           '9364', '9366', '9367', '9368',
                           '9369'
                          );


-- добалены группы бал. счетов 921, 936
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '9210', '22', '2', '121', NULL, NULL); 
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '9211', '22', '2', '121', NULL, NULL); 
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '9212', '22', '2', '121', NULL, NULL); 
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '9213', '22', '2', '121', NULL, NULL); 
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '9214', '22', '2', '121', NULL, NULL); 
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '9216', '22', '2', '121', NULL, NULL); 
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '9217', '22', '2', '121', NULL, NULL); 
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '9218', '22', '2', '121', NULL, NULL); 
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '9360', '22', '2', '121', NULL, NULL); 
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '9361', '22', '2', '121', NULL, NULL); 
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '9362', '22', '2', '121', NULL, NULL); 
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '9363', '22', '2', '121', NULL, NULL); 
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '9364', '22', '2', '121', NULL, NULL); 
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '9366', '22', '2', '121', NULL, NULL); 
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '9367', '22', '2', '121', NULL, NULL); 
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '9368', '22', '2', '121', NULL, NULL); 
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '9369', '22', '2', '121', NULL, NULL); 

commit;

delete from kl_f3_29 
where kf='E8' and r020 in ('8610', '8615', '8651', '8652', '8655');
 
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

delete from  KODOBL_REG where KO = 26 and C_REG = 28;
Insert into KODOBL_REG
   (KO, C_REG)
 Values
   (26, 28);
COMMIT;


