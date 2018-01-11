

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BR_NORMAL_VIEW.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view BR_NORMAL_VIEW ***

  CREATE OR REPLACE FORCE VIEW BARS.BR_NORMAL_VIEW ("BR_ID", "NAME", "BDATE", "KV", "RATE", "FORMULA") AS 
  select  d.br_id, s.name, d.bdate, d.kv, d.rate, s.formula
  from br_normal_edit d, brates s
 where d.br_id=s.br_id;

PROMPT *** Create  grants  BR_NORMAL_VIEW ***
grant SELECT                                                                 on BR_NORMAL_VIEW  to BARSREADER_ROLE;
grant SELECT                                                                 on BR_NORMAL_VIEW  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BR_NORMAL_VIEW  to START1;
grant SELECT                                                                 on BR_NORMAL_VIEW  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BR_NORMAL_VIEW.sql =========*** End ***
PROMPT ===================================================================================== 
