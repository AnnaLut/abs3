

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PODOTW_OLD.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view PODOTW_OLD ***

  CREATE OR REPLACE FORCE VIEW BARS.PODOTW_OLD ("ID", "TAG", "VAL") AS 
  SELECT ID, tag, val
     FROM podotc
   UNION
   SELECT DISTINCT c.rnk + 10000, 'FIO', c.nmk
              FROM customer c
             WHERE c.nmk IS NOT NULL AND c.custtype = 3
   UNION
   SELECT DISTINCT c.rnk + 10000, 'PASP', ps.NAME
              FROM customer c, passp ps, person p
             WHERE ps.NAME IS NOT NULL AND p.rnk = c.rnk
                   AND ps.passp = p.passp
   UNION
   SELECT DISTINCT c.rnk + 10000, 'ATRT',
                   p.organ || ' ' || TO_CHAR (p.pdate, 'DD-MM-YYYY')
              FROM customer c, person p
             WHERE c.custtype = 3
               AND p.organ || ' ' || TO_CHAR (p.pdate, 'DD-MM-YYYY') IS NOT NULL
               AND p.organ || ' ' || TO_CHAR (p.pdate, 'DD-MM-YYYY') <> ' '
               AND p.rnk = c.rnk
   UNION
   SELECT c.rnk + 10000, 'NLS', a.nls
     FROM customer c, accounts a, cust_acc cc
    WHERE c.rnk = cc.rnk
      AND cc.acc = a.acc
      AND c.custtype = 3
      AND a.nbs LIKE '26%'
      AND a.dazs IS NULL
   UNION
   SELECT c.rnk + 10000, 'ADRES', c.adr
     FROM customer c
    WHERE custtype = 3 AND c.adr IS NOT NULL
   UNION
   SELECT c.rnk + 10000, 'DT_R', TO_CHAR (p.bday, 'dd.mm.yyyy')
     FROM customer c, person p
    WHERE p.rnk = c.rnk
      AND c.custtype = 3
      AND TO_CHAR (p.bday, 'dd.mm.yyyy') IS NOT NULL
   UNION
   SELECT c.rnk + 10000, 'PASPN', p.ser || ' ' || p.numdoc
     FROM customer c, person p
    WHERE p.rnk = c.rnk
      AND custtype = 3
      AND p.ser || ' ' || p.numdoc IS NOT NULL
      AND NVL (p.ser || ' ' || p.numdoc, 0) <> '0'
      AND p.ser || ' ' || p.numdoc <> ' ' 
 ;

PROMPT *** Create  grants  PODOTW_OLD ***
grant SELECT                                                                 on PODOTW_OLD      to BARSREADER_ROLE;
grant SELECT                                                                 on PODOTW_OLD      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PODOTW_OLD      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PODOTW_OLD.sql =========*** End *** ===
PROMPT ===================================================================================== 
