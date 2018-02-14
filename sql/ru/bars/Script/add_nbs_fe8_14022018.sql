--  14/02/2018p  
--  добавл€ютьс€ нов≥ балансов≥ рахунки 8610, 8615 дл€ генеральних угод  
-- консол≥дований рахунок 2610(2615)

exec bc.home;

delete from kl_f3_29 where kf='E8' and r020 in ('8610','8615');

-- добалены  бал. счета 8610, 8615
INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '8610', '22', '2', '121', NULL, NULL); 

INSERT INTO KL_F3_29 ( KF, R020, R050, R012, DDD, TXT, S240 ) VALUES ( 
'E8', '8615', '22', '2', '121', NULL, NULL); 

commit;



