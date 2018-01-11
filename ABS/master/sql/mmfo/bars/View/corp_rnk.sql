

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CORP_RNK.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view CORP_RNK ***

  CREATE OR REPLACE FORCE VIEW BARS.CORP_RNK ("ID", "RNK", "NMK") AS 
  SELECT   ROWNUM, rnk, nmk
       FROM customer
      WHERE rnk IN (SELECT UNIQUE rnkp
                             FROM customer)
   ORDER BY ROWID
 ;

PROMPT *** Create  grants  CORP_RNK ***
grant SELECT                                                                 on CORP_RNK        to BARSREADER_ROLE;
grant SELECT                                                                 on CORP_RNK        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CORP_RNK        to START1;
grant SELECT                                                                 on CORP_RNK        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CORP_RNK        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CORP_RNK.sql =========*** End *** =====
PROMPT ===================================================================================== 
