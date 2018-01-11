

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STTCA.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STTCA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STTCA ("NAME", "ID") AS 
  SELECT 'передано' name, 1 id FROM DUAL
   UNION ALL
   SELECT 'не передано' name, 0 id FROM DUAL;

PROMPT *** Create  grants  V_STTCA ***
grant SELECT                                                                 on V_STTCA         to BARSREADER_ROLE;
grant SELECT                                                                 on V_STTCA         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_STTCA         to START1;
grant SELECT                                                                 on V_STTCA         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STTCA.sql =========*** End *** ======
PROMPT ===================================================================================== 
