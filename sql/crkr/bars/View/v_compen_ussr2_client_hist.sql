CREATE OR REPLACE FORCE VIEW BARS.V_COMPEN_USSR2_CLIENT_HIST (ID, STAFF_ID, CRT_DATE, BRANCH, ACT_STATE, STATE_DATE, ACT_TYPE, ACT_ID, CRV_RNK, CRV_DBCODE, ASVO_DBCODE, ASVO_RNK, CL_APPROVED, CL_COMMENT, KEY_DOC_TYPE_CRV, KEY_DOC_SER_CRV, KEY_DOC_NUM_CRV, KEY_DOC_TYPE_ASVO, KEY_DOC_SER_ASVO, KEY_DOC_NUM_ASVO, KEY_DOC_APPROVED, KEY_DOC_COMMENT, FIO_CRV, FIO_ASVO, FIO_FINAL, BDATE_CRV, BDATE_ASVO, BDATE_FINAL, DOC_ISSUER_CRV, DOC_ISSUER_ASVO, DOC_ISSUER_FINAL, DOC_ISSUE_DATE_CRV, DOC_ISSUE_DATE_ASVO, DOC_ISSUE_DATE_FINAL, ADR_IDX_CRV, ADR_IDX_ASVO, ADR_IDX_FINAL, ADR_OBL_CRV, ADR_OBL_ASVO, ADR_OBL_FINAL, ADR_DST_CRV, ADR_DST_ASVO, ADR_DST_FINAL, ADR_TWN_CRV, ADR_TWN_ASVO, ADR_TWN_FINAL, ADR_ADR_CRV, ADR_ADR_ASVO, ADR_ADR_FINAL, OKPO_CRV, OKPO_ASVO, OKPO_FINAL, SEC_WORD_CRV, SEC_WORD_ASVO, SEC_WORD_FINAL, TEL1_CRV, TEL1_ASVO, TEL1_FINAL, TEL2_CRV, TEL2_ASVO, TEL2_FINAL) AS 
  select a.id, a.staff_id, a.crt_date, a.branch, s.name act_state, a.state_date , t.name act_type, c.ACT_ID,c.CRV_RNK,c.CRV_DBCODE,c.ASVO_DBCODE,c.ASVO_RNK,c.CL_APPROVED,c.CL_COMMENT,c.KEY_DOC_TYPE_CRV,c.KEY_DOC_SER_CRV,c.KEY_DOC_NUM_CRV,c.KEY_DOC_TYPE_ASVO,c.KEY_DOC_SER_ASVO,c.KEY_DOC_NUM_ASVO,c.KEY_DOC_APPROVED,c.KEY_DOC_COMMENT,c.FIO_CRV,c.FIO_ASVO,c.FIO_FINAL,c.BDATE_CRV,c.BDATE_ASVO,c.BDATE_FINAL,c.DOC_ISSUER_CRV,c.DOC_ISSUER_ASVO,c.DOC_ISSUER_FINAL,c.DOC_ISSUE_DATE_CRV,c.DOC_ISSUE_DATE_ASVO,c.DOC_ISSUE_DATE_FINAL,c.ADR_IDX_CRV,c.ADR_IDX_ASVO,c.ADR_IDX_FINAL,c.ADR_OBL_CRV,c.ADR_OBL_ASVO,c.ADR_OBL_FINAL,c.ADR_DST_CRV,c.ADR_DST_ASVO,c.ADR_DST_FINAL,c.ADR_TWN_CRV,c.ADR_TWN_ASVO,c.ADR_TWN_FINAL,c.ADR_ADR_CRV,c.ADR_ADR_ASVO,c.ADR_ADR_FINAL,c.OKPO_CRV,c.OKPO_ASVO,c.OKPO_FINAL,c.SEC_WORD_CRV,c.SEC_WORD_ASVO,c.SEC_WORD_FINAL,c.TEL1_CRV,c.TEL1_ASVO,c.TEL1_FINAL,c.TEL2_CRV,c.TEL2_ASVO,c.TEL2_FINAL
from ussr2_actualizations a,
ussr2_act_states s,
ussr2_acts_types t,
ussr2_act_client_data c
where a.state_id=s.id
and a.act_type=t.id
and a.id=c.act_id
;
  GRANT SELECT ON BARS.V_COMPEN_USSR2_CLIENT_HIST TO BARS_ACCESS_DEFROLE;