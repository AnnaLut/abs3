DROP VIEW BARS.V_OPER_TIMEOPL;

CREATE OR REPLACE FORCE VIEW BARS.V_OPER_TIMEOPL
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
                      o.NLSA,
                      o.S   ,
                      nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
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
         nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT) DAT
  FROM  OPER o, RKO_TTS t, ACCOUNTS a, OPLDOK d
  WHERE o.SOS = 5
    AND o.TT = t.TT
    AND t.DK = 0
    AND o.NLSA = a.NLS
    AND a.KV = 980
    AND a.NBS in ('2560', '2565', '2600', '2603', '2604', '2650')
    AND o.REF = d.REF  AND  d.ACC = a.ACC  AND  d.DK = 0
    AND o.PDAT >= SYSDATE - 50;



GRANT DELETE, INSERT, SELECT, UPDATE, ON COMMIT REFRESH, QUERY REWRITE, DEBUG, FLASHBACK ON BARS.V_OPER_TIMEOPL TO START1;

GRANT SELECT, FLASHBACK ON BARS.V_OPER_TIMEOPL TO WR_REFREAD;


