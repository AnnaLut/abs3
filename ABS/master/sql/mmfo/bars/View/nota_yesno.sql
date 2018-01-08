

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NOTA_YESNO.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view NOTA_YESNO ***

  CREATE OR REPLACE FORCE VIEW BARS.NOTA_YESNO ("NAME", "ID") AS 
  SELECT 'връ' name,
         'YES' id
  FROM   DUAL
  UNION ALL
  SELECT 'ЭГ'  name,
         'NO'  id
  FROM   DUAL;

PROMPT *** Create  grants  NOTA_YESNO ***
grant SELECT                                                                 on NOTA_YESNO      to BARSREADER_ROLE;
grant SELECT                                                                 on NOTA_YESNO      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NOTA_YESNO      to START1;
grant SELECT                                                                 on NOTA_YESNO      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NOTA_YESNO.sql =========*** End *** ===
PROMPT ===================================================================================== 
