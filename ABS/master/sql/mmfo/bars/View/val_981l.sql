

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VAL_981L.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view VAL_981L ***

  CREATE OR REPLACE FORCE VIEW BARS.VAL_981L ("NAME", "NOMINAL", "CENA", "OB22", "OB22_989", "OB22_DOR", "OB22_SPL", "OB22_205", "OB22_DORS", "NOT_9819", "ZALIK") AS 
  SELECT "NAME", "NOMINAL", "CENA", "OB22", "OB22_989", "OB22_DOR",
          "OB22_SPL", "OB22_205", "OB22_DORS", "NOT_9819", ZALIK
     FROM valuables
    WHERE ob22 LIKE '9819__' AND ob22_205 IS NOT NULL
 ;

PROMPT *** Create  grants  VAL_981L ***
grant DELETE,INSERT,SELECT,UPDATE                                            on VAL_981L        to ABS_ADMIN;
grant SELECT                                                                 on VAL_981L        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on VAL_981L        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VAL_981L        to UPLD;
grant FLASHBACK,SELECT                                                       on VAL_981L        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VAL_981L.sql =========*** End *** =====
PROMPT ===================================================================================== 
