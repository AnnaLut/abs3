

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CLIM_ACCOUNTS_ARC.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CLIM_ACCOUNTS_ARC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CLIM_ACCOUNTS_ARC ("ACC_ID", "MFO", "BDATE", "ACC_BALANCE") AS 
  SELECT a.acc acc_id,
          a.kf mfo,
          clim_ru_pack.get_paramdate as bdate,
          fost (a.acc, clim_ru_pack.get_paramdate) acc_balance
     FROM accounts a
    WHERE     nbs LIKE '100%'
          AND (dazs IS NULL OR dazs >= clim_ru_pack.get_paramdate);

PROMPT *** Create  grants  V_CLIM_ACCOUNTS_ARC ***
grant SELECT                                                                 on V_CLIM_ACCOUNTS_ARC to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CLIM_ACCOUNTS_ARC.sql =========*** En
PROMPT ===================================================================================== 
