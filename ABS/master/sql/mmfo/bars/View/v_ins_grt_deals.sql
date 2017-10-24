

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INS_GRT_DEALS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INS_GRT_DEALS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INS_GRT_DEALS ("DEAL_ID", "TYPE_ID", "TYPE_NAME", "DEAL_NUM", "DEAL_DATE", "GRT_NAME", "DEAL_RNK", "CTYPE", "FIO", "INN", "DOC_SER", "DOC_NUM", "DOC_ISSUER", "DOC_DATE") AS 
  select d.deal_id,
       d.grt_type_id as type_id,
       t.type_name,
       d.deal_num,
       d.deal_date,
       d.grt_name,
       d.deal_rnk,
       c.custtype    as ctype,
       c.nmk         as fio,
       c.okpo        as inn,
       p.ser         as doc_ser,
       p.numdoc      as doc_num,
       p.organ       as doc_issuer,
       p.pdate       as doc_date
  from grt_deals d, grt_types t, grt_groups g, customer c, person p
 where d.grt_type_id = t.type_id
   and t.group_id = g.group_id
   and d.deal_rnk = c.rnk
   and d.deal_rnk = p.rnk;

PROMPT *** Create  grants  V_INS_GRT_DEALS ***
grant SELECT                                                                 on V_INS_GRT_DEALS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INS_GRT_DEALS.sql =========*** End **
PROMPT ===================================================================================== 
