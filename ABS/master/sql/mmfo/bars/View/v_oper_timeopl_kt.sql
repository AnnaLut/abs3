DROP VIEW BARS.V_OPER_TIMEOPL_KT;

CREATE OR REPLACE FORCE VIEW BARS.V_OPER_TIMEOPL_KT
       (
         PL    ,
         REF   ,
         TT    ,
         ND    ,
         S     ,
         NLSA  ,
         NLSB  ,
         NAM_A ,
         NAM_B ,
         ID_A  ,
         ID_B  ,
         MFOA  ,
         MFOB  ,
         BRANCH,
         VDAT  ,
         DAT
       )
AS
  SELECT F_TARIF_RKO( t.NTAR,
                      980   ,
                      o.NLSB,
                      o.S   ,
                      o.PDAT,
                      to_date('01/01/2015','dd/mm/yyyy'),
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
         o.PDAT
  FROM  OPER o, RKO_TTS t, ACCOUNTS a, OPLDOK d
  WHERE o.SOS = 5
    AND o.TT = t.TT
    AND t.DK = 1
    AND o.NLSB = a.NLS
    AND a.KV = 980
    AND a.NBS IN ('2560', '2565', '2600', '2603', '2604', '2650')
    AND o.REF = d.REF  AND  d.ACC = a.ACC  AND  d.DK = 1
    AND o.PDAT >= SYSDATE - 50
UNION ALL
  SELECT F_TARIF_RKO( 15    ,
                      980   ,
                      o.NLSB,
                      o.S   ,
                      o.PDAT,
                      to_date('01/01/2015','dd/mm/yyyy'),
                      o.NLSA,
                      o.NLSB,
                      o.MFOA,
                      o.MFOB,
                      'R01',
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
         o.PDAT
  FROM  OPER o, ACCOUNTS a, OPLDOK d
  WHERE o.SOS = 5
    AND o.TT = 'PS2'
    AND o.NLSB = a.NLS
    AND a.KV = 980
    AND a.NBS IN ('2560', '2565', '2600', '2603', '2604', '2650')
    AND o.REF = d.REF  AND  d.ACC = a.ACC  AND  d.DK = 1 AND  d.TT='R01'
    AND o.PDAT >= SYSDATE - 50;                               



GRANT DELETE, INSERT, SELECT, UPDATE, ON COMMIT REFRESH, QUERY REWRITE, DEBUG, FLASHBACK ON BARS.V_OPER_TIMEOPL_KT TO START1;

GRANT SELECT, FLASHBACK ON BARS.V_OPER_TIMEOPL_KT TO WR_REFREAD;


