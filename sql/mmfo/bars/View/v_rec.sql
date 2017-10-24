

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_REC.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_REC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_REC ("TEG", "VAL1", "VAL2", "VAL3") AS 
  SELECT '3) ��������' TEG   , nd VAL1, to_char(datd, 'dd.mm.yyyy') VAL2, nazn  VAL3
 from arc_rrp aa where rec= TO_NUMBER (pul.Get_Mas_Ini_Val ('REC') ) and bis =0
  union all
 SELECT '2) ³��������-�' TEG, NLSa VAL1 , nam_a VAL2, id_a val3
  from arc_rrp where rec= TO_NUMBER (pul.Get_Mas_Ini_Val ('REC') ) and bis =0
     union all
 SELECT '1) ����-� ³���������' TEG, MFOA VAL1,(select nb from banks where mfo = aa.mfoa ) VAL2, '' VAL3
 from arc_rrp aa where rec= TO_NUMBER (pul.Get_Mas_Ini_Val ('REC') )  and bis =0
      union all
  SELECT '4) ����' TEG,  to_char(kv) VAL1,
 TO_CHAR (s/100, 'FM999999999999999999999990.00',  'NLS_NUMERIC_CHARACTERS = ''. ''') VAL2,
        decode(dk, 0, '����� (��������)', 1, '������ (��������)', 2, '����� (i��.�����)', 3,
        '������ (i��.���i��������)', to_char(dk) ) VAL3
 from arc_rrp where rec= TO_NUMBER (pul.Get_Mas_Ini_Val ('REC') ) and bis =0
 union all
 SELECT '5) ����-� ����������' TEG, MFOB VAL1,(select nb from banks where mfo = aa.mfob ) VAL2,''  VAL3
 from arc_rrp aa where rec= TO_NUMBER (pul.Get_Mas_Ini_Val ('REC') ) and bis =0
  union all
 SELECT '6) ���������-�' TEG   , NLSb  VAL1 , nam_b VAL2 , id_b VAL3
 from arc_rrp where rec= TO_NUMBER (pul.Get_Mas_Ini_Val ('REC') ) and bis =0
 union all
 SELECT '�) ����.��������-�' TEG   , FN_A  VAL1 , to_char(DAT_A ,'dd.mm.yyyy hh:MI:ss' ) VAL2, to_char(REC) VAL3
 from  arc_rrp aa where rec= TO_NUMBER (pul.Get_Mas_Ini_Val ('REC') ) and bis =0
union all
 SELECT '�) ����.��������-�' TEG   , FN_B  VAL1 , to_char(DAT_B, 'dd.mm.yyyy hh:MI:ss' ) VAL2, to_char(REF) VAL3
 from  arc_rrp aa where rec= TO_NUMBER (pul.Get_Mas_Ini_Val ('REC') ) and bis =0
order by 1
;

PROMPT *** Create  grants  V_REC ***
grant SELECT                                                                 on V_REC           to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_REC.sql =========*** End *** ========
PROMPT ===================================================================================== 
