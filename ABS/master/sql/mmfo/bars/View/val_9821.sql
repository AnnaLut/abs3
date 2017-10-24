

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VAL_9821.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view VAL_9821 ***

  CREATE OR REPLACE FORCE VIEW BARS.VAL_9821 ("NAME", "NOMINAL", "CENA", "OB22", "OB22_989", "OB22_DOR", "OB22_SPL", "OB22_205", "OB22_DORS", "NOT_9819") AS 
  select "NAME","NOMINAL","CENA","OB22","OB22_989","OB22_DOR","OB22_SPL","OB22_205","OB22_DORS","NOT_9819" from  valuables where ob22 like '9821__' 
 ;

PROMPT *** Create  grants  VAL_9821 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on VAL_9821        to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on VAL_9821        to BARS_ACCESS_DEFROLE;
grant FLASHBACK,SELECT                                                       on VAL_9821        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VAL_9821.sql =========*** End *** =====
PROMPT ===================================================================================== 
