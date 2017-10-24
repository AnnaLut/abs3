

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INS_CC_DEALS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INS_CC_DEALS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INS_CC_DEALS ("ND", "NUM", "SDATE", "DEAL_RNK", "CTYPE", "FIO", "INN", "DOC_SER", "DOC_NUM", "DOC_ISSUER", "DOC_DATE") AS 
  select cd.nd,
       cd.cc_id   as num,
       cd.sdate,
       cd.rnk     as deal_rnk,
       c.custtype as ctype,
       c.nmk      as fio,
       c.okpo     as inn,
       p.ser      as doc_ser,
       p.numdoc   as doc_num,
       p.organ    as doc_issuer,
       p.pdate    as doc_date
  from cc_deal cd, customer c, person p
 where cd.rnk = c.rnk
   and cd.rnk = p.rnk;

PROMPT *** Create  grants  V_INS_CC_DEALS ***
grant SELECT                                                                 on V_INS_CC_DEALS  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INS_CC_DEALS.sql =========*** End ***
PROMPT ===================================================================================== 
