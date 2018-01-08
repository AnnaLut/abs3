

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SALDO_V.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view SALDO_V ***

  CREATE OR REPLACE FORCE VIEW BARS.SALDO_V ("KF", "ACC", "FDAT", "KV", "NLS", "NBS", "OB22", "DOS", "KOS", "POS", "NBS1", "OB22_1") AS 
  SELECT KF,acc,FDAT,kv,nls,NBS,ob22,DECODE (SIGN (ost), -1, -OST, 0) dOS,DECODE (SIGN (ost), 1, OST, 0) kOS,'NEW' POS,NBS NBS1,ob22 ob22_1     FROM SALDO_V1
   UNION ALL
SELECT KF,acc,FDAT,kv,nlsALt,SUBSTR (nlsalt,1,4),T2017.OB22_old(NBS,OB22,SUBSTR (nlsalt,1,4)),DECODE(SIGN(ost),1,OST,0), DECODE(SIGN(ost),-1,-OST,0), 'OLD',NBS NBS1,ob22 ob22_1     FROM SALDO_V1;

PROMPT *** Create  grants  SALDO_V ***
grant SELECT                                                                 on SALDO_V         to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SALDO_V.sql =========*** End *** ======
PROMPT ===================================================================================== 
