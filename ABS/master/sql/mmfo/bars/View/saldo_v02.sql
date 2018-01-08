

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SALDO_V02.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view SALDO_V02 ***

  CREATE OR REPLACE FORCE VIEW BARS.SALDO_V02 ("KF", "FDAT", "KV", "NBS", "POS", "NBS1", "DOS", "KOS") AS 
  SELECT KF,FDAT, kv, NBS, POS, NBS1, SUM (DOS) dos, SUM (KOS) kos   FROM SALDO_V   GROUP BY KF,FDAT,  kv,   NBS,  POS, NBS1;

PROMPT *** Create  grants  SALDO_V02 ***
grant SELECT                                                                 on SALDO_V02       to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SALDO_V02.sql =========*** End *** ====
PROMPT ===================================================================================== 
