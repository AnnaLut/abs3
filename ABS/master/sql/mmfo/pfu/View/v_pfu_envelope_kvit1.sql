

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_ENVELOPE_KVIT1.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_ENVELOPE_KVIT1 ***

  CREATE OR REPLACE FORCE VIEW PFU.V_PFU_ENVELOPE_KVIT1 ("ID", "NAME", "DATE_INSERT", "COUNT_FILES", "SUM", "STATE", "USERID") AS 
  SELECT per.id AS "ID",
          '#' || TO_CHAR (per.pfu_envelope_id) AS "NAME",
          per.register_date AS "DATE_INSERT",
          (SELECT COUNT (1)
             FROM pfu_file pf
            WHERE pf.envelope_request_id = per.id)
             AS "COUNT_FILES",
          per.check_sum/100 AS "SUM",
          nvl(per.state, 'PARSED') AS "STATE",
--          st.state_name
          per.userid
     FROM pfu_envelope_request per -- V_PFU_ENVELOP_STATE st
    WHERE per.state = 'PARSED' and per.id IN (  SELECT tab.envelope_request_id
                         FROM TABLE (pfu_utl.get_rec_to_kvit1) tab
                     GROUP BY tab.envelope_request_id)
;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_ENVELOPE_KVIT1.sql =========*** En
PROMPT ===================================================================================== 
