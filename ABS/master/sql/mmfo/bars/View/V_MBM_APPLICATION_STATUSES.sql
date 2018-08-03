CREATE OR REPLACE FORCE VIEW V_MBM_APPLICATION_STATUSES
AS
    select 
        to_char(z.ID) as ID,
        decode(z.sos, 2, 'PAID','DELETED') as STATUS_CODE,
        OS.NAME as MESSAGE,
        sysdate as PAID_DATE
    from 
        ZAYAVKA z,
        op_sos os 
    where 
        z.sos = os.sos
        and (z.sos = -1 or z.sos = 2);


COMMENT ON TABLE BARS.V_MBM_APPLICATION_STATUSES IS 'Представлення для відображення статусів проведених і відхилених заявок на ін. валюту';



GRANT SELECT ON BARS.V_MBM_APPLICATION_STATUSES TO BARS_ACCESS_DEFROLE;
