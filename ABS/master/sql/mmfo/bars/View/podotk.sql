

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PODOTK.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view PODOTK ***

  CREATE OR REPLACE FORCE VIEW BARS.PODOTK ("ID", "FIO", "ATRT", "ADRES", "NLS", "PASP", "PASPN", "DT_R") AS 
  SELECT ID,
       MAX(DECODE(TAG,'FIO',VAL,'')),
       MAX(DECODE(TAG,'ATRT',VAL,'')),
       MAX(DECODE(TAG,'ADRES',VAL,'')),
       MAX(DECODE(TAG,'NLS',VAL,'')),
       MAX(DECODE(TAG,'PASP',VAL,'')),
       MAX(DECODE(TAG,'PASPN',VAL,'')),
       MAX(DECODE(TAG,'DT_R',VAL,''))
FROM PODOTC
GROUP BY ID;

PROMPT *** Create  grants  PODOTK ***
grant SELECT                                                                 on PODOTK          to BARSREADER_ROLE;
grant SELECT                                                                 on PODOTK          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PODOTK          to START1;
grant SELECT                                                                 on PODOTK          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PODOTK.sql =========*** End *** =======
PROMPT ===================================================================================== 
