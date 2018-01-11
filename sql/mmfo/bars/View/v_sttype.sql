

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STTYPE.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STTYPE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STTYPE ("NAME", "ID") AS 
  SELECT 'тіло' name, 0 id FROM DUAL
   UNION ALL
   SELECT 'проценти' name, 1 id FROM DUAL;

PROMPT *** Create  grants  V_STTYPE ***
grant SELECT                                                                 on V_STTYPE        to BARSREADER_ROLE;
grant SELECT                                                                 on V_STTYPE        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_STTYPE        to START1;
grant SELECT                                                                 on V_STTYPE        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STTYPE.sql =========*** End *** =====
PROMPT ===================================================================================== 
