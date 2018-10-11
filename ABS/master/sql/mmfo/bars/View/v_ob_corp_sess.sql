CREATE OR REPLACE VIEW BARS.V_OB_CORP_SESS
(
   ID,
   MFO,
   MFO_NAME,
   FILE_DATE,
   CORP,
   STATE,
   SYNCTIME,
   ERR_LOG
)
AS
     SELECT T1.ID,
            TO_CHAR (T1.KF) AS mfo,
            (select nb from  bars.banks b where t1.KF = b.mfo) AS mfo_name,
            T1.FILE_DATE,
            (select listagg(corp_id, ', ') WITHIN GROUP (order by corp_id) 
            from BARS.ob_corp_sess_corp c
            where c.sess_id = t1.id) as CORP,
            DECODE (T1.STATE_ID,
                    NULL, 'Новий',
                    0, 'Новий',
                    1, 'Оброблено',
                    2, 'Оброблено з помилками',
                    3, 'Помилка даних')
               AS state,
            SYS_TIME AS synctime,
            to_char(substr(t1.err_log, 1, 100)) as err_log
       FROM BARS.ob_corp_sess t1
   ORDER BY SYS_TIME DESC;
/
COMMENT ON TABLE BARS.V_OB_CORP_SESS IS 'Стан синхронізації для К-файлів';
/
GRANT SELECT ON BARS.V_OB_CORP_SESS TO BARS_ACCESS_DEFROLE;
/
GRANT SELECT ON BARS.V_OB_CORP_SESS TO CORP_CLIENT;
/