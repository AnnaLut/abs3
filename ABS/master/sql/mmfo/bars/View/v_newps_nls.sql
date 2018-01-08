

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NEWPS_NLS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NEWPS_NLS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NEWPS_NLS ("KF", "DAT_ALT", "KV", "NBS", "NLS", "OB22", "OLD_NBS", "OLD_NLS", "OLD_OB22", "OST", "OSTQ") AS 
  SELECT KF ,
           dat_alt,
           kv,
           nbs,
           nls ,
           ob22,
           substr(nlsalt,1,4) old_nbs,
           nlsalt old_nls,
           T2017.OB22_old (NBS, OB22, SUBSTR (nlsalt, 1, 4))old_ob22,
           fost (acc, dat_alt - 1)/100 ost,
           --fostq (acc, dat_alt-1)/100 ostq,
           gl.p_icurval(kv, ostc, dat_alt-1)/100 as ostq
 FROM accounts
 WHERE     dat_alt IS NOT NULL
          AND nlsalt IS NOT NULL
          AND fost (acc, dat_alt - 1) <> 0;

PROMPT *** Create  grants  V_NEWPS_NLS ***
grant SELECT                                                                 on V_NEWPS_NLS     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NEWPS_NLS.sql =========*** End *** ==
PROMPT ===================================================================================== 
