CREATE OR REPLACE FORCE VIEW BARS.INS_EWA_PURP_MASK
(
   ID,
   MASK,
   MASK_JSON
)
AS
     SELECT A.ID,
            LISTAGG (
                  CASE
                     WHEN a.mval_id IS NOT NULL THEN B.PURP_NAME
                     ELSE a.stat_val
                  END
               || REPLACE (split_s, ' ', '^'),
               '|')
            WITHIN GROUP (ORDER BY a.r_id)
               AS mask,
            LISTAGG (
                  CASE
                     WHEN a.mval_id IS NOT NULL THEN B.PURP_VAL
                     ELSE a.stat_val
                  END
               || REPLACE (split_s, ' ', '^'),
               '|')
            WITHIN GROUP (ORDER BY a.r_id)
               AS mask_json
       FROM ins_ewa_purp_m a LEFT JOIN ins_ewa_purp_mval b ON A.MVAL_ID = B.ID
   GROUP BY a.id;
   
   COMMENT ON TABLE BARS.INS_EWA_PURP_MASK IS 'View для візуалізації масок призначення платежів EWA';
   /
   COMMENT ON COLUMN BARS.INS_EWA_PURP_MASK.ID IS 'ID шаблону призначення платежу';
   /
   COMMENT ON COLUMN BARS.INS_EWA_PURP_MASK.MASK IS 'Маска призначення платежу';
   /
   COMMENT ON COLUMN BARS.INS_EWA_PURP_MASK.MASK_JSON IS 'Маска призначення платежу в форматі тегів';
   /


GRANT SELECT, FLASHBACK ON BARS.INS_EWA_PURP_MASK TO WR_REFREAD;
GRANT SELECT, FLASHBACK ON BARS.INS_EWA_PURP_MASK TO bars_access_defrole;