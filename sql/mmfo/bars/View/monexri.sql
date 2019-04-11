PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/MONEXRI.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view MONEXRI ***

  CREATE OR REPLACE FORCE VIEW BARS.MONEXRI ("KOD_NBU", "FDAT1", "FDAT2", "FL", "RU", "NAME_RU", "KV", "OB22", "S_2909", "K_2909", "S_2809", "K_2809", "S_0000", "K_0000", "I_2909", "R_2809", "RK_2809", "KOMB1", "KOMB2", "KOMB3", "RET_SEND", "S_3739") AS 
  SELECT 
 i.KOD_NBU,i.FDAT1,i.FDAT2,i.FL, i.RU,i.NAME_RU,i.KV,i.OB22,i.S_2909,i.K_2909,i.S_2809,i.K_2809,i.S_0000,i.K_0000,i.I_2909,i.R_2809,i.RK_2809,i.komb1,i.komb2,i.komb3,I.RET_SEND,(i.S_3739+I.RET_SEND) S_3739 
FROM 
  (SELECT r.kod_nbu,   r.fl,  r.kv, r.ob22, TO_NUMBER (NULL) RU,  MONEX.UNAME ( trim(r.Branch) ) NAME_RU,            MIN (r.FDAT) fdat1,    MAX (r.FDAT) fdat2, 
          SUM (r.S_2909) S_2909, SUM (r.K_2909) k_2909, SUM (r.S_2809) S_2809, SUM (r.K_2809) K_2809, SUM (r.S_0000) S_0000,
          SUM (r.K_0000) k_0000, SUM (r.S_2909 + r.K_2909) I_2909, SUM (r.S_2809 + r.S_0000) R_2809, SUM (r.K_2809 + r.K_0000) RK_2809,
          SUM (      r.S_2809  + r.S_0000    + r.K_2809    + r.K_0000    - r.S_2909    - r.K_2909)    S_3739,
          SUM (r.Komb1) komb1,   SUM (r.Komb2) komb2,  SUM (r.Komb3) komb3,    SUM (nvl( r.RET_SEND, 0) ) RET_SEND
   FROM monexr r, V_SFDAT v  WHERE r.fdat >= v.B AND r.fdat <= v.E  GROUP BY r.kod_nbu,   r.fl, MONEX.UNAME ( trim(r.Branch) ) , r.kv, r.ob22
   UNION ALL
   SELECT r.kod_nbu,  r.fl,  r.KV, r.ob22,  TO_NUMBER (NULL) RU, 'ÐÀÇÎÌ ïî Ñèñò+Âàë' NAME_RU,      MIN (r.FDAT) fdat1,        MAX (r.FDAT) fdat2,
          SUM (r.S_2909) S_2909, SUM (r.K_2909) k_2909, SUM (r.S_2809) S_2809, SUM (r.K_2809) K_2809, SUM (r.S_0000) S_0000,
          SUM (r.K_0000) k_0000, SUM (r.S_2909 + r.K_2909) I_2909, SUM (r.S_2809 + r.S_0000) R_2809,  SUM (r.K_2809 + r.K_0000) RK_2809,
          SUM (      r.S_2809    + r.S_0000    + r.K_2809    + r.K_0000    - r.S_2909    - r.K_2909)    S_3739,
          SUM (r.Komb1) komb1,      SUM (r.Komb2) komb2,        SUM (r.Komb3) komb3, SUM (nvl( r.RET_SEND, 0) ) RET_SEND
   FROM monexr r, V_SFDAT v   WHERE r.fdat >= v.B AND r.fdat <= v.E  GROUP BY r.kod_nbu,  r.fl,  r.kv,  r.ob22
) i;

PROMPT *** Create  grants  MONEXRI ***
grant SELECT                                                                 on MONEXRI         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MONEXRI         to UPLD;
grant SELECT                                                                 on MONEXRI         to START1;
grant SELECT                                                                 on MONEXRI         to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/MONEXRI.sql =========*** End *** ======
PROMPT ===================================================================================== 
