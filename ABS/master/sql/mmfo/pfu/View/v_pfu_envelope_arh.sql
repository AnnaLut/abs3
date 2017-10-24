

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_ENVELOPE_ARH.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_ENVELOPE_ARH ***

  CREATE OR REPLACE FORCE VIEW PFU.V_PFU_ENVELOPE_ARH ("ID", "PFU_ENVELOPE_ID", "REGISTER_DATE", "CRT_DATE", "SENT_DATE", "REG_CNT", "CHECK_SUM", "STATE", "STATE_NAME", "USERID") AS 
  select p.id,
       p.pfu_envelope_id,
       p.register_date,
       p.crt_date,
       pr.sys_time sent_date,
       (SELECT COUNT (1)
          FROM pfu_file pf
         WHERE pf.envelope_request_id = p.id) reg_cnt,
       p.check_sum,
       p.state,
       (select es.name from pfu_envelope_state es where es.code = p.state) state_name,
       p.userid
  from pfu_envelope_request P
  LEFT JOIN pfu_request pr ON pr.parent_request_id = p.id
 where p.state = 'MATCH_SEND';



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_ENVELOPE_ARH.sql =========*** End 
PROMPT ===================================================================================== 
