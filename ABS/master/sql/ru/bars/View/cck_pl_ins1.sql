

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CCK_PL_INS1.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view CCK_PL_INS1 ***

  CREATE OR REPLACE FORCE VIEW BARS.CCK_PL_INS1 ("ND", "MFOB", "NLSB", "NAM_B", "ID_B", "NAZN", "S", "REF", "RI") AS 
  select i."ND",i."MFOB",i."NLSB",i."NAM_B",i."ID_B",i."NAZN",i."S",i."REF",  rowid RI from CCK_PL_INS I  where nd = to_number ( pul.get_mas_ini_val('ND') );

PROMPT *** Create  grants  CCK_PL_INS1 ***
grant SELECT,UPDATE                                                          on CCK_PL_INS1     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CCK_PL_INS1.sql =========*** End *** ==
PROMPT ===================================================================================== 
