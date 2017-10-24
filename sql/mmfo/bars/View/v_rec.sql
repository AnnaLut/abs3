

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_REC.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_REC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_REC ("TEG", "VAL1", "VAL2", "VAL3") AS 
  SELECT '3) Документ' TEG   , nd VAL1, to_char(datd, 'dd.mm.yyyy') VAL2, nazn  VAL3
 from arc_rrp aa where rec= TO_NUMBER (pul.Get_Mas_Ini_Val ('REC') ) and bis =0
  union all
 SELECT '2) Відправник-А' TEG, NLSa VAL1 , nam_a VAL2, id_a val3
  from arc_rrp where rec= TO_NUMBER (pul.Get_Mas_Ini_Val ('REC') ) and bis =0
     union all
 SELECT '1) Банк-А Відправника' TEG, MFOA VAL1,(select nb from banks where mfo = aa.mfoa ) VAL2, '' VAL3
 from arc_rrp aa where rec= TO_NUMBER (pul.Get_Mas_Ini_Val ('REC') )  and bis =0
      union all
  SELECT '4) Сума' TEG,  to_char(kv) VAL1,
 TO_CHAR (s/100, 'FM999999999999999999999990.00',  'NLS_NUMERIC_CHARACTERS = ''. ''') VAL2,
        decode(dk, 0, 'Дебет (реальний)', 1, 'Кредит (реальний)', 2, 'Дебет (iнф.запит)', 3,
        'Кредит (iнф.повiдомлення)', to_char(dk) ) VAL3
 from arc_rrp where rec= TO_NUMBER (pul.Get_Mas_Ini_Val ('REC') ) and bis =0
 union all
 SELECT '5) Банк-Б Отримувача' TEG, MFOB VAL1,(select nb from banks where mfo = aa.mfob ) VAL2,''  VAL3
 from arc_rrp aa where rec= TO_NUMBER (pul.Get_Mas_Ini_Val ('REC') ) and bis =0
  union all
 SELECT '6) Отримувач-Б' TEG   , NLSb  VAL1 , nam_b VAL2 , id_b VAL3
 from arc_rrp where rec= TO_NUMBER (pul.Get_Mas_Ini_Val ('REC') ) and bis =0
 union all
 SELECT 'А) Техн.реквізити-А' TEG   , FN_A  VAL1 , to_char(DAT_A ,'dd.mm.yyyy hh:MI:ss' ) VAL2, to_char(REC) VAL3
 from  arc_rrp aa where rec= TO_NUMBER (pul.Get_Mas_Ini_Val ('REC') ) and bis =0
union all
 SELECT 'Б) Техн.реквізити-И' TEG   , FN_B  VAL1 , to_char(DAT_B, 'dd.mm.yyyy hh:MI:ss' ) VAL2, to_char(REF) VAL3
 from  arc_rrp aa where rec= TO_NUMBER (pul.Get_Mas_Ini_Val ('REC') ) and bis =0
order by 1
;

PROMPT *** Create  grants  V_REC ***
grant SELECT                                                                 on V_REC           to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_REC.sql =========*** End *** ========
PROMPT ===================================================================================== 
