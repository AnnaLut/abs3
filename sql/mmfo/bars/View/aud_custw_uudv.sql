

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/AUD_CUSTW_UUDV.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view AUD_CUSTW_UUDV ***

  CREATE OR REPLACE FORCE VIEW BARS.AUD_CUSTW_UUDV ("BRANCH", "RNK", "CUSTTYPE", "OKPO", "NMKK", "UUDV") AS 
  SELECT c.branch,
            c.rnk,
            custtype,
            c.okpo,
            c.nmkk,
            substr(f_custw (c.rnk, 'UUDV'),1,10) uudv
       FROM customer c
      WHERE c.codcagent = 3 AND c.date_off IS NULL
   ORDER BY c.rnk;

PROMPT *** Create  grants  AUD_CUSTW_UUDV ***
grant SELECT                                                                 on AUD_CUSTW_UUDV  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on AUD_CUSTW_UUDV  to SALGL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/AUD_CUSTW_UUDV.sql =========*** End ***
PROMPT ===================================================================================== 
