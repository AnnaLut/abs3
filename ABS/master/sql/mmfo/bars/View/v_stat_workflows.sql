create or replace view v_stat_workflows as
select w.ID,
       NAME,
       CLOSE_DATE,
       CLOSE_USER_ID,
       u.fio CLOSE_USER_NAME 
from STAT_WORKFLOWS W,
     staff$base     u
where u.id (+) = w.close_user_id ;
