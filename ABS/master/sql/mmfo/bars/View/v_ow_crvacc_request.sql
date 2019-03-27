

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_CRVACC_REQUEST.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_CRVACC_REQUEST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_CRVACC_REQUEST ("REQUEST_ID", "BRANCH", "ACC", "NLS", "KV", "NMS", "DAOS", "RNK", "OKPO", "NMK", "CUSTTYPE", "PASSP", "ORGAN", "BDAY", "FIRST_NAME", "LAST_NAME", "MDL_NAME", "SEC_NAME", "ADR_PCODE", "ADR_OBL", "ADR_DST", "ADR_CITY", "ADR_STREET", "EMB_FIRST_NAME", "EMB_LAST_NAME", "CRV_RNK", "CARD_ISSUE_BRANCH", "CARD_ISSUE_BRANCH_ABS", "CARD_ISSUE_BRANCH_ADR", "CARD_ISSUE_DATE", "CARDEXPIRY") AS 
  select w.request_id, a.branch, a.acc, a.nls, a.kv, upper(a.nms) nms, a.daos,
       c.rnk, c.okpo, upper(c.nmk) nmk, c.custtype,
       p.ser || ' ' || p.numdoc passp,
       to_char(p.pdate,'yyyyMMdd') || ' ' || p.organ organ,
       to_char(p.bday,'yyyy-MM-dd') bday,
       (select upper(min(value)) from customerw where rnk = c.rnk and tag='SN_FN') first_name,
       (select upper(min(value)) from customerw where rnk = c.rnk and tag='SN_LN') last_name,
       (select upper(min(value)) from customerw where rnk = c.rnk and tag='SN_MN') mdl_name,
       (select min(value) from accountsw where acc = a.acc and tag='W4_SEC') sec_name,
       (select min(substr(value,1,6))  from customerw where rnk = c.rnk and tag='FGIDX') adr_pcode,
       (select min(substr(value,1,70)) from customerw where rnk = c.rnk and tag='FGOBL') adr_obl,
       (select min(substr(value,1,70)) from customerw where rnk = c.rnk and tag='FGDST') adr_dst,
       (select min(substr(value,1,15)) from customerw where rnk = c.rnk and tag='FGTWN') adr_city,
       (select min(substr(value,1,30)) from customerw where rnk = c.rnk and tag='FGADR') adr_street,
       (select upper(min(value)) from accountsw where acc = a.acc and tag='W4_EFN') emb_first_name,
       (select upper(min(value)) from accountsw where acc = a.acc and tag='W4_ELN') emb_last_name,
       (select min(value) from customerw where rnk = c.rnk and tag='RVRNK') crv_rnk,
       (select min(value) from customerw where rnk = c.rnk and tag='RVIBR') card_issue_branch,
       (select min(value) from customerw where rnk = c.rnk and tag='RVIBB') card_issue_branch_abs,
       (select min(value) from customerw where rnk = c.rnk and tag='RVIBA') card_issue_branch_adr,
       (select to_char(to_date(min(substr(value,1,10)),'dd/MM/yyyy'),'yyyy-MM-dd') from customerw where rnk = c.rnk and tag='RVIDT') card_issue_date,
       to_char(add_months(a.daos,3*12),'yyMM') cardexpiry
  from ow_crvacc_request w, accounts a, customer c, person p
 where w.acc = a.acc
   and a.rnk = c.rnk
   and c.rnk = p.rnk;

PROMPT *** Create  grants  V_OW_CRVACC_REQUEST ***
grant SELECT                                                                 on V_OW_CRVACC_REQUEST to BARSREADER_ROLE;
grant SELECT                                                                 on V_OW_CRVACC_REQUEST to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OW_CRVACC_REQUEST to OW;
grant SELECT                                                                 on V_OW_CRVACC_REQUEST to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_CRVACC_REQUEST.sql =========*** En
PROMPT ===================================================================================== 