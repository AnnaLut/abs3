

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_INHERITORS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_INHERITORS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_INHERITORS ("DPT_ID", "DPT_NUM", "DPT_DAT", "VIDD_CODE", "VIDD_NAME", "RATE", "DAT_BEGIN", "DAT_END", "DPT_SALDO", "DPT_CURCODE", "INT_SALDO", "INT_CURCODE", "OWNER_ID", "OWNER_NAME", "INHERIT_ID", "INHERIT_NAME", "INHERIT_SHARE", "INHERIT_DATE", "INHERIT_STATE", "CERTIF_NUM", "CERTIF_DATE", "ATTR_INCOME", "NAME_INCOME") AS 
  SELECT d.dpt_id,
          d.dpt_num,
          d.dpt_dat,
          d.vidd_code,
          d.vidd_name,
          d.rate,
          d.dat_begin,
          d.dat_end,
          d.dpt_saldo,
          d.dpt_curcode,
          d.int_saldo,
          d.int_curcode,
          d.cust_id,
          d.cust_name,
          h.inherit_custid,
          c.nmk,
          h.inherit_share,
          h.inherit_date,
          h.inherit_state,
          h.certif_num,
          h.certif_date,
          h.ATTR_INCOME,
          m.SHORT_NAME
     FROM dpt_inheritors h,
          v_dpt_portfolio_active d,
          customer c,
          ATTRIBUTE_INCOME m
    WHERE     h.dpt_id = d.dpt_id
          AND h.inherit_custid = c.rnk
          AND h.ATTR_INCOME = m.ATTR_INCOME;

PROMPT *** Create  grants  V_DPT_INHERITORS ***
grant SELECT                                                                 on V_DPT_INHERITORS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_INHERITORS to DPT_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_INHERITORS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_INHERITORS.sql =========*** End *
PROMPT ===================================================================================== 
