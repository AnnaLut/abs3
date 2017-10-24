

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_ERR_RECORD.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_ERR_RECORD ***

  CREATE OR REPLACE FORCE VIEW PFU.V_PFU_ERR_RECORD ("MFO", "BRANCH", "KF_BANK", "MFO_NAME", "PFU_ENVELOPE_ID", "FILE_ID", "ID", "NLS_PFU", "NLS_BANK", "NMK_PFU", "NMK_BANK", "OKPO_PFU", "OKPO_BANK", "STATE", "STATE_NAME", "ERR_MESS_TRACE", "RNK_BANK") AS 
  SELECT p.mfo,
       P2.BRANCH,
       P1.KF as KF_BANK,
       (select s.name from pfu_syncru_params s where s.kf = p1.kf) MFO_NAME,
       p.pfu_envelope_id,
       p.file_id,
       p.id,
       p.num_acc as NLS_PFU,
       P1.NLS as NLS_BANK,
       p.full_name as NMK_PFU,
       P2.NMK as NMK_BANK,
       p.numident as OKPO_PFU,
       P2.OKPO as OKPO_BANK,
       p.state,
       (select rs.state_name from pfu_record_state rs where rs.state = p.state) state_name,
       p.err_mess_trace,
       P1.RNK as RNK_BANK
  FROM pfu_file_records p
  left JOIN PFU_PENSACC p1 ON (P1.KF = P.MFO and P1.NLS = P.NUM_ACC)
  left join PFU_PENSIONER p2 on (P2.KF=p1.kf and P2.RNK=p1.rnk)
 inner join (select * from pfu_envelope_request er where er.state = 'PARSED') er1 on (er1.pfu_envelope_id = p.pfu_envelope_id )
 WHERE p.state in (1,2,3,4,5,6,7,8,9,90)
 ORDER BY p.state;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_ERR_RECORD.sql =========*** End **
PROMPT ===================================================================================== 
