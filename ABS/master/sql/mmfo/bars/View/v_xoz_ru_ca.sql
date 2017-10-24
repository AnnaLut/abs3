CREATE OR REPLACE FORCE VIEW BARS.V_XOZ_RU_CA
(
   REC,
   MFOA,
   NLSA,
   NAM_A,
   S,
   D_REC,
   NAZN,
   REF1,
   REFD_RU,
   OB22,
   RU,
   NAME,
   PROD
)
AS
   SELECT w.REC,
          w.MFOA,
          w.NLSA,
          w.NAM_A,
          w.S,
          w.D_REC,
          w.NAZN,
          SUBSTR (xoz.DREC (w.D_REC, 'F1'), 1, 38) REF1,
          SUBSTR (xoz.DREC (w.D_REC, 'FD'), 1, 38) REFD_RU,
          SUBSTR (xoz.DREC (w.D_REC, 'OB'), 1, 2) OB22,
          b.ru,
          b.name,
          SUBSTR (w.nlsa, 1, 4) || SUBSTR (xoz.DREC (w.D_REC, 'OB'), 1, 2)
             PROD
     FROM (SELECT a.REc,
                  a.mfoa,
                  a.nlsa,
                  a.nam_a,
                  a.s / 100 s,
                  a.d_rec,
                  a.nazn
             FROM tzaproS z, arc_rrP a
            WHERE     a.rec = Z.rec
                  AND a.dk = 2
                  AND a.mfob = '300465'
                  AND a.nlsb = '35105'
                  AND a.id_b = '00032129'
                  AND a.d_rec LIKE '#COB:%#CF1:%#CFD:%#') w,
          banks_ru b
    WHERE b.mfo = w.mfoa;

/

ALTER VIEW V_XOZ_RU_CA
    COMPILE; 
/
