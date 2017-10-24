

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_P12_2C.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_P12_2C ***

CREATE OR REPLACE FORCE VIEW BARS.V_P12_2C
(
   CODE,
   TXT
)
AS
   SELECT code, txt FROM p12_2c;

PROMPT *** Create  grants  V_P12_2C ***
grant SELECT                                                                 on V_P12_2C        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_P12_2C        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_P12_2C.sql =========*** End *** =====
PROMPT ===================================================================================== 
