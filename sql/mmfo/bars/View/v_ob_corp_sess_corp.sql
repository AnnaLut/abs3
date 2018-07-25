create or replace view v_ob_corp_sess_corp as
SELECT T1.ID,
            TO_CHAR (T1.KF) AS mfo,
            (SELECT nb
               FROM bars.banks b
              WHERE t1.KF = b.mfo)
               AS mfo_name,
            T1.FILE_DATE,
            c.corp_id AS CORP,
            DECODE (T1.STATE_ID,
                    NULL, 'Новий',
                    0, 'Новий',
                    1, 'Оброблено',
                    2, 'Оброблено з помилками',
                    3, 'Помилка даних')
               AS state,
            c.IS_LAST,
            SYS_TIME AS synctime,
            'K'||substr(k.kod_s||substr( getchr(substr(to_char(T1.FILE_DATE,'DD/MM/YYYY'),-2,2))|| 
                                         getchr(substr(to_char(T1.FILE_DATE,'DD/MM/YYYY'),4,2))|| 
                                         getchr(substr(to_char(T1.FILE_DATE,'DD/MM/YYYY'),1,2))|| '.'||
                                         lpadchr(c.corp_id,'0',2)||'1', 1,8),1,50) as filename
       FROM BARS.ob_corp_sess t1 
       join BARS.ob_corp_sess_corp c on c.sess_id = t1.id
       left join bars.clim_mfo k on k.kf = t1.kf
   ORDER BY t1.ID DESC, c.corp_id;
   
   GRANT SELECT ON BARS.V_OB_CORP_SESS_CORP TO BARS_ACCESS_DEFROLE;

   GRANT SELECT ON BARS.V_OB_CORP_SESS_CORP TO CORP_CLIENT;
   
   /