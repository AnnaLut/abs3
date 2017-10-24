CREATE OR REPLACE FORCE VIEW BARS.V_COMPEN_USSR2_DEPOSIT_HIST (ID_ACT, STAFF_ID, CRT_DATE, BRANCH, ACT_STATE, STATE_DATE, ACT_TYPE, ACT_ID, ID, CRV_DPT_ID, CRV_BRANCH, CRV_NSC, CRV_OST, ASVO_DBCODE, ASVO_BRANCH, ASVO_NSC, ASVO_OST, KEY_APPROVED, KEY_COMMENT, PMT_SUM, PMT_INF_REF, PMT_INT_REF, CRV_FIO, ASVO_FIO) AS 
  select a.id id_act, a.staff_id, a.crt_date, a.branch, s.name act_state, a.state_date , t.name act_type, c.ACT_ID,c.ID,c.CRV_DPT_ID,c.CRV_BRANCH,c.CRV_NSC,c.CRV_OST,c.ASVO_DBCODE,c.ASVO_BRANCH,c.ASVO_NSC,c.ASVO_OST,c.KEY_APPROVED,c.KEY_COMMENT,c.PMT_SUM,c.PMT_INF_REF,c.PMT_INT_REF,c.CRV_FIO,c.ASVO_FIO
from ussr2_actualizations a,
ussr2_act_states s,
ussr2_acts_types t,
ussr2_act_dpt_data  c,
ussr2_act_payment_data p
where a.state_id=s.id
and a.act_type=t.id
and a.id=c.act_id
and a.id=p.act_id
;
  GRANT SELECT ON BARS.V_COMPEN_USSR2_DEPOSIT_HIST TO BARS_ACCESS_DEFROLE;