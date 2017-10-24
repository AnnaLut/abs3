

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DWH_ACCOUNTS_UPDATE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DWH_ACCOUNTS_UPDATE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DWH_ACCOUNTS_UPDATE ("ACC", "MAX_IDUPD") AS 
  SELECT acc, MAX (idupd) max_idupd
       FROM accounts_update
   GROUP BY acc;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DWH_ACCOUNTS_UPDATE.sql =========*** 
PROMPT ===================================================================================== 
