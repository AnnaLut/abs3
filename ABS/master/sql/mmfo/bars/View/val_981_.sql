

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VAL_981_.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view VAL_981_ ***

  CREATE OR REPLACE FORCE VIEW BARS.VAL_981_ ("NAME", "NOMINAL", "CENA", "OB22", "OB22_989", "OB22_DOR", "OB22_SPL", "OB22_205", "OB22_DORS", "NOT_9819") AS 
  select "NAME","NOMINAL","CENA","OB22","OB22_989","OB22_DOR","OB22_SPL","OB22_205","OB22_DORS","NOT_9819" from  valuables where ob22 like '9819__' and OB22_205 is   null
 ;

PROMPT *** Create  grants  VAL_981L ***
grant DELETE,INSERT,SELECT,UPDATE                                            on VAL_981L        to ABS_ADMIN;
grant SELECT                                                                 on VAL_981L        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on VAL_981L        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VAL_981L        to UPLD;
grant FLASHBACK,SELECT                                                       on VAL_981L        to WR_REFREAD;

PROMPT *** Create  grants  VAL_981_ ***
grant DELETE,INSERT,SELECT,UPDATE                                            on VAL_981_        to ABS_ADMIN;
grant SELECT                                                                 on VAL_981_        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on VAL_981_        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VAL_981_        to UPLD;
grant FLASHBACK,SELECT                                                       on VAL_981_        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VAL_981_.sql =========*** End *** =====
PROMPT ===================================================================================== 
