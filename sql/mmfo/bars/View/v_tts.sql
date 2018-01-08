

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TTS.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TTS ("NAME") AS 
  SELECT X0.NAME
       FROM TTS X0, STAFF_TTS X1, STAFF X2
       WHERE (substr(x0.flags, 1, 1) =  '1') AND (x0.tt =  x1.tt) AND (x1.id =  x2.id) AND upper(rtrim(ltrim(x2.logname))) =  USER;

PROMPT *** Create  grants  V_TTS ***
grant SELECT                                                                 on V_TTS           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_TTS           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TTS.sql =========*** End *** ========
PROMPT ===================================================================================== 
