CREATE OR REPLACE FORCE VIEW BARS.V_OVR_INTX
(
   NPP,
   CDAT,
   ACC8,
   ACC,
   IP8,
   IA8,
   IP2,
   IA2,
   RNK,
   VN,
   AKT8,
   PAS8,
   S2,
   S8,
   PR2,
   PR8,
   PR,
   SAL8,
   OST2,
   KP,
   KA
)
AS
   SELECT npp,
          cdat,
          acc8,
          acc,
          IP8,
          IA8,
          IP2,
          IA2,
          rnk,
          vn,
          Akt8 / 100 AKT8,
          Pas8 / 100 PAS8,
          ROUND (S2, 0) / 100 S2,
          ROUND (S8, 0) / 100 S8,
          ROUND (PR2, 0) / 100 PR2,
          ROUND (PR8, 0) / 100 PR8,
          ROUND (PR, 0) / 100 PR,
          sal8 / 100 SAL8,
          Ost2 / 100 ost2,
          ROUND (KP, 4) KP,
          ROUND (KA, 4) KA
     FROM bars.OVR_INTX where ISP = BARS.USER_ID ;


GRANT SELECT ON BARS.V_OVR_INTX TO BARSREADER_ROLE;

GRANT SELECT ON BARS.V_OVR_INTX TO BARS_ACCESS_DEFROLE;

GRANT SELECT ON BARS.V_OVR_INTX TO START1;

GRANT SELECT ON BARS.V_OVR_INTX TO UPLD;
