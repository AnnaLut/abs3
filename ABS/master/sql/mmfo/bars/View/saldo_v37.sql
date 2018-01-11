

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SALDO_V37.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view SALDO_V37 ***

  CREATE OR REPLACE FORCE VIEW BARS.SALDO_V37 ("KF", "FDAT", "KV", "NBS", "OB22", "POS", "NBS1", "OB22_1", "DOS", "KOS") AS 
  SELECT KF,FDAT,kv,NBS,ob22,POS,NBS1,OB22_1,SUM (DOS) dos, SUM (KOS) kos FROM SALDO_V GROUP BY KF, FDAT,  kv,   NBS,  ob22,  POS, NBS1, OB22_1;

PROMPT *** Create  grants  SALDO_V37 ***
grant SELECT                                                                 on SALDO_V37       to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SALDO_V37.sql =========*** End *** ====
PROMPT ===================================================================================== 
