

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/S6_CCK_CREDIT_PERSEN.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view S6_CCK_CREDIT_PERSEN ***

  CREATE OR REPLACE FORCE VIEW BARS.S6_CCK_CREDIT_PERSEN ("BIC", "IDCONTRACT", "D_BEGIN", "PRC_OSN", "PRC_PRS", "PRC_PIN", "PRC_PNP", "D_END", "FLAG", "PERCENT_N") AS 
  SELECT "BIC","IDCONTRACT","D_BEGIN","PRC_OSN","PRC_PRS","PRC_PIN","PRC_PNP","D_END","FLAG","PERCENT_N"
     FROM S6_S6_Credit_Percent ;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/S6_CCK_CREDIT_PERSEN.sql =========*** E
PROMPT ===================================================================================== 
