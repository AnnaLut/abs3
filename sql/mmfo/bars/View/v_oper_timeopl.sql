

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OPER_TIMEOPL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OPER_TIMEOPL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OPER_TIMEOPL ("PL", "REF", "TT", "ND", "S", "NLSA", "NLSB", "NAM_A", "NAM_B", "ID_A", "ID_B", "MFOA", "MFOB", "BRANCH", "VDAT", "DAT") AS 
  SELECT F_TARIF_RKO( t.NTAR,
                      980   ,
                      o.NLSA,
                      o.S   ,
                      nvl( (SELECT MAX (DAT)
                            FROM   OPER_VISA
                            WHERE  REF = o.REF AND GROUPID not in (30,80)),
                           o.PDAT
                         )  ,
                      F_DKON_KV (d.FDAT, d.FDAT),
                      o.NLSA,
                      o.NLSB,
                      o.MFOA,
                      o.MFOB,
                      t.TT  ,
                      a.ACC ,
                      o.D_REC,
                      o.REF
                    ) / 100,
         o.REF,
         o.TT,
         o.ND,
         o.S / 100,
         o.NLSA,
         o.NLSB,
         o.NAM_A,
         o.NAM_B,
         o.ID_A,
         o.ID_B,
         o.MFOA,
         o.MFOB,
         o.BRANCH,
         d.FDAT,
         (SELECT nvl(MAX(DAT),o.PDAT)
          FROM   OPER_VISA
          WHERE  REF = o.REF AND GROUPID not in (30,80)
         ) DAT
  FROM  OPER o, RKO_TTS t, ACCOUNTS a, OPLDOK d
  WHERE o.SOS = 5
    AND o.TT = t.TT
    AND t.DK = 0
    AND o.NLSA = a.NLS
    AND a.KV = 980
    AND a.NBS in ('2560', '2565', '2600', '2603', '2604', '2650')
    AND o.REF = d.REF  AND  d.ACC = a.ACC  AND  d.DK = 0
    AND o.PDAT >= SYSDATE - 50;

PROMPT *** Create  grants  V_OPER_TIMEOPL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_OPER_TIMEOPL  to ABS_ADMIN;
grant DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on V_OPER_TIMEOPL  to BARS_ACCESS_DEFROLE;
grant DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on V_OPER_TIMEOPL  to START1;
grant FLASHBACK,SELECT                                                       on V_OPER_TIMEOPL  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OPER_TIMEOPL.sql =========*** End ***
PROMPT ===================================================================================== 
