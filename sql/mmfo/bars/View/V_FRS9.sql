

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FRS9.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FRS9 ***

  create or replace view V_FRS9 as select make_docinput_url (t.tts, 'Виконати', 'DatV', nvl(t.datv,bankdate),'Nd','FRS9') as url ,t.* from TMP_FRS9 t;

PROMPT *** Create  grants  V_FRS9 ***
grant SELECT                                                                 on V_FRS9        to BARSREADER_ROLE;
grant SELECT                                                                 on V_FRS9        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FRS9        to RCC_DEAL;
grant SELECT                                                                 on V_FRS9        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FRS9.sql =========*** End *** =====
PROMPT ===================================================================================== 
