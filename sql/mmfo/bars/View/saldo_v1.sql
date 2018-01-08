

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SALDO_V1.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view SALDO_V1 ***

  CREATE OR REPLACE FORCE VIEW BARS.SALDO_V1 ("KF", "ACC", "FDAT", "KV", "NLS", "NLSALT", "NBS", "OB22", "OST") AS 
  SELECT KF, acc,dat_alt FDAT,kv,nls,nlsalt,NBS,ob22,fost(acc,dat_alt-1) ost FROM accounts WHERE  dat_alt IS NOT NULL AND nlsalt IS NOT NULL AND fost(acc,dat_alt-1)<>0;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SALDO_V1.sql =========*** End *** =====
PROMPT ===================================================================================== 
