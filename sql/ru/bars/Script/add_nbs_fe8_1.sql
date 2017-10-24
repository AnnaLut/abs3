--  11/08/2017 p 01/08/2017 (зв≥т за липень м≥с€ць) 
-- добавл€ютьс€ нов≥ балансов≥ рахунки  3353, 3354, 3359, 3363, 3364,
--                                      3380, 3385, 3386, 3387, 3388


exec suda;

delete from kl_f3_29 where kf='E8' and r020 in ( '3353', '3354', '3359', 
                                                 '3363', '3364',
                                                 '3380', '3385', '3386', 
                                                 '3387', '3388'
                                               ); 

-- добалены группы бал. счетов 335, 336, 338
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '3353', '22', '2', '121', NULL, NULL); 
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '3354', '22', '2', '121', NULL, NULL); 
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '3359', '22', '2', '121', NULL, NULL); 

INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '3363', '22', '2', '121', NULL, NULL); 
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '3364', '22', '2', '121', NULL, NULL); 

INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '3380', '22', '2', '121', NULL, NULL); 
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '3385', '22', '2', '121', NULL, NULL); 
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '3386', '21', '2', '122', NULL, NULL); 
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '3387', '22', '2', '122', NULL, NULL); 
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '3388', '22', '2', '123', NULL, NULL); 


commit;
