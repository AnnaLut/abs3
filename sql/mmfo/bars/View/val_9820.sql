

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VAL_9820.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view VAL_9820 ***

  CREATE OR REPLACE FORCE VIEW BARS.VAL_9820 ("NAME", "NOMINAL", "CENA", "OB22", "OB22_989", "OB22_DOR", "OB22_SPL", "OB22_205", "OB22_DORS", "NOT_9819") AS 
  select "NAME","NOMINAL","CENA","OB22","OB22_989","OB22_DOR","OB22_SPL","OB22_205","OB22_DORS","NOT_9819" from  valuables where ob22 like '9820__' 
 ;

PROMPT *** Create  grants  VAL_9820 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on VAL_9820        to ABS_ADMIN;
grant SELECT                                                                 on VAL_9820        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on VAL_9820        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VAL_9820        to UPLD;
grant FLASHBACK,SELECT                                                       on VAL_9820        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VAL_9820.sql =========*** End *** =====
PROMPT ===================================================================================== 
