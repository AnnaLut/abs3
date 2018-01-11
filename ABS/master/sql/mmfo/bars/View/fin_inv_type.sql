

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/FIN_INV_TYPE.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view FIN_INV_TYPE ***

  CREATE OR REPLACE FORCE VIEW BARS.FIN_INV_TYPE ("INV_KOD", "INV_NAME") AS 
  select distinct invkod inv_kod, substr(invkod||' ' ||invname,1,254) inv_name from
(select decode(f1.val, 1, 0, decode(f2.val, 1, 1, 2)) invkod,  f1.name||' '||decode(f1.val, 1, '', f2.namep) invname
 from fin_question_reply f1, fin_question_reply f2
 where f1.kod = 'INV' and f2.kod = 'ETP'
    and f1.idf = f2.idf
  order by   1);

PROMPT *** Create  grants  FIN_INV_TYPE ***
grant SELECT                                                                 on FIN_INV_TYPE    to BARSREADER_ROLE;
grant SELECT                                                                 on FIN_INV_TYPE    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/FIN_INV_TYPE.sql =========*** End *** =
PROMPT ===================================================================================== 
