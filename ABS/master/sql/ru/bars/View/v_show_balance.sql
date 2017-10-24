/* Formatted on 10.05.2016 15:19:26 (QP5 v5.256.13226.35510) */
CREATE OR REPLACE FORCE VIEW V_SHOW_BALANCE
(
   SHOW_DATE,
   KF,
   KF_NAME,
   NBS,
   KV,
   DOS,
   DOSQ,
   KOS,
   KOSQ,
   OSTD,
   OSTDQ,
   OSTK,
   OSTKQ,
   ROW_TYPE
)
AS
     SELECT show_date,
            kf,
            kf_name,
            CASE WHEN INSTR (nbs, '%') > 0 THEN 'По всім' ELSE nbs END
               nbs,
            CASE WHEN kv = 0 THEN 'По всім' ELSE TO_CHAR (kv) END kv,
            dos,
            dosq,
            kos,
            kosq,
            ostd,
            ostdq,
            ostk,
            ostkq,
            row_type
       FROM TMP_SHOW_BALANCE_DATA
   ORDER BY kf,
            nbs,
            row_type DESC,
            kv;
