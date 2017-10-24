

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CC_INS_TAG.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CC_INS_TAG ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CC_INS_TAG ("VIDD", "ND", "CC_ID", "RNK", "NMK", "SDATE", "WDATE", "TAG") AS 
  SELECT d.vidd, d.ND,d.cc_id,d.rnk,c.nmk,d.sdate,d.wdate,
          (SELECT SUBSTR(trim(txt),1,35) FROM ND_TXT
           WHERE d.nd=nd AND tag=pul.Get_Mas_Ini_Val('CC_TAG')) TAG
   FROM CC_DEAL d,CUSTOMER c
   WHERE d.rnk=c.rnk AND d.SOS<15;

PROMPT *** Create  grants  V_CC_INS_TAG ***
grant SELECT                                                                 on V_CC_INS_TAG    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CC_INS_TAG    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CC_INS_TAG.sql =========*** End *** =
PROMPT ===================================================================================== 
