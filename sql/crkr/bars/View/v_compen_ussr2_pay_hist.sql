CREATE OR REPLACE FORCE VIEW BARS.v_compen_ussr2_pay_hist (ID, STAFF_ID, CRT_DATE, BRANCH, ACT_STATE, STATE_DATE, ACT_TYPE, ACT_ID, CARD_ISSUE_DATE, CARD_ABS_BRANCH, CARD_ABS_ACCOUNT, PAYMENT_DATE, CARD_ISSUE_BRANCH, CARD_ISSUE_BRANCH_ADR, CARD_ABS_MATCH, CARD_ABS_MATCH_TEXT, CARD_ABS_MATCH_FILEID, PAYMENT_MATCH, PAYMENT_MATCH_TEXT, PAYMENT_MATCH_DATE, ASVO_DBCODE) AS 
  SELECT DISTINCT a.id,
                   a.staff_id,
                   a.crt_date,
                   a.branch,
                   s.name act_state,
                   a.state_date,
                   t.name act_type,
                   p.ACT_ID,
                   p.CARD_ISSUE_DATE,
                   p.CARD_ABS_BRANCH,
                   p.CARD_ABS_ACCOUNT,
                   p.PAYMENT_DATE,
                   p.CARD_ISSUE_BRANCH,
                   p.CARD_ISSUE_BRANCH_ADR,
                   p.CARD_ABS_MATCH,
                   p.CARD_ABS_MATCH_TEXT,
                   p.CARD_ABS_MATCH_FILEID,
                   p.PAYMENT_MATCH,
                   p.PAYMENT_MATCH_TEXT,
                   p.PAYMENT_MATCH_DATE,
                   c.asvo_dbcode
                       FROM ussr2_actualizations a,
          ussr2_act_states s,
          ussr2_acts_types t,
          ussr2_act_dpt_data c,
          ussr2_act_payment_data p
    WHERE     a.state_id = s.id
          AND a.act_type = t.id
          AND a.id = c.act_id
          AND a.id = p.act_id;
  GRANT SELECT ON BARS.V_COMPEN_USSR2_PAY_HIST TO BARS_ACCESS_DEFROLE;