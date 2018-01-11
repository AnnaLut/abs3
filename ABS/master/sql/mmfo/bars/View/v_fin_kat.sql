

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FIN_KAT.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FIN_KAT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FIN_KAT ("KAT23", "V_FIN23", "OBS23", "VNCRR", "V_IP1", "V_IP2", "V_IP3", "V_IP4", "V_IP5", "K", "K2", "CUSTYPE") AS 
  select kat23, 
decode(idf, 7, to_char(fin23), 20, (decode(fin23, 1, 'А', 2,'Б', 3, 'В', 4,'Г')), null) as v_fin23 ,
obs23, vncrr,
decode(k.ip1, 0,'Будь-яка',(select name from fin_question_reply where kod = 'IP1' and idf = k.idf and val = k.ip1)) as v_ip1, 
decode(k.ip2, 0,'Будь-яка',(select name from fin_question_reply where kod = 'IP2' and idf = k.idf and val = k.ip2)) as v_ip2,
decode(k.ip3, 0,'Будь-яка',(select name from fin_question_reply where kod = 'IP3' and idf = k.idf and val = k.ip3)) as v_ip3,
decode(k.ip4, 0,'Будь-яка',(select name from fin_question_reply where kod = 'IP4' and idf = k.idf and val = k.ip4)) as v_ip4,
decode(k.ip5, 0,'Будь-яка',(select name from fin_question_reply where kod = 'IP5' and idf = k.idf and val = k.ip5)) as v_ip5,
k, k2,
decode(idf, 7, 'ЮО', 20,'ФЛ')  custype
from fin_kat k
order by  idf,kat23,  obs23, fin23;

PROMPT *** Create  grants  V_FIN_KAT ***
grant SELECT                                                                 on V_FIN_KAT       to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_FIN_KAT       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_FIN_KAT       to START1;
grant SELECT                                                                 on V_FIN_KAT       to UPLD;
grant FLASHBACK,SELECT                                                       on V_FIN_KAT       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FIN_KAT.sql =========*** End *** ====
PROMPT ===================================================================================== 
