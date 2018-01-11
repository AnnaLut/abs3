

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PODOTCH.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view PODOTCH ***

  CREATE OR REPLACE FORCE VIEW BARS.PODOTCH ("ID", "FIO", "ATRT", "ADRES", "NLS", "PASP", "PASPN", "DT_R") AS 
  SELECT   ID, MAX (DECODE (tag, 'FIO', val, '')),
            MAX (DECODE (tag, 'ATRT', val, '')),
            MAX (DECODE (tag, 'ADRES', val, '')),
            MAX (DECODE (tag, 'NLS', val, '')),
            MAX (DECODE (tag, 'PASP', val, '')),
            MAX (DECODE (tag, 'PASPN', val, '')),
            MAX (DECODE (tag, 'DT_R', val, ''))
       FROM podotw
   GROUP BY ID 
 ;

PROMPT *** Create  grants  PODOTCH ***
grant SELECT                                                                 on PODOTCH         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PODOTCH         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PODOTCH         to PYOD001;
grant SELECT                                                                 on PODOTCH         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PODOTCH         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on PODOTCH         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PODOTCH.sql =========*** End *** ======
PROMPT ===================================================================================== 
