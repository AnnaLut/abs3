CREATE OR REPLACE FORCE VIEW BARS.V_XOZ_IDZ
(
   BRANCH,
   OB22,
   NLS,
   NMS,
   VDAT,
   S,
   REF,
   REF1,
   FDAT,
   MDATE,
   KOLD
)
AS
   SELECT a.branch,
          a.ob22,
          a.nls,
          a.nms,
          o.vdat,
          o.s / 100 s,
          o.REF,
          x.REF1,
          x.fdat,
          x.MDATE,
          x.MDATE - x.fdat KOLD
     FROM accounts a,
          XOZ_RU_CA z,
          xoz_ref x,
          oper o
    WHERE     x.acc = a.acc
          AND z.ref1 = x.ref1
          AND z.ref2 IS NULL
          AND x.ref2 IS NULL
          AND o.REF = z.REFD_RU;

/ 