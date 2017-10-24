CREATE OR REPLACE FORCE VIEW BARS.COUNT_CCK_WEB
(
   GRAA,
   GRA,
   GRB,
   GR1,
   GR2,
   GR3,
   GR4,
   GR5,
   GR51,
   DAT1,
   DAT2
)
AS
     SELECT NLSALT GRAA,
               pr
            || '.'
            || DECODE (prs, NULL, NULL, prs || '.')
            || DECODE (kv, NULL, NULL, kv)
               GRA,
            name GRB,
            n1 GR1,
            n2 GR2,
            n3 GR3,
            n4 GR4,
            uv GR5,
            n5 GR51,
            TO_DATE (pul.Get_Mas_Ini_Val ('sFdat1'), 'dd.mm.yyyy') dat1,
            TO_DATE (pul.Get_Mas_Ini_Val ('sFdat2'), 'dd.mm.yyyy') dat2
       FROM CCK_AN_WEB where rec_id = sys_context('bars_pul', 'reckoning_id')
   ORDER BY pr, prs, kv;


GRANT SELECT ON BARS.COUNT_CCK_WEB TO BARS_ACCESS_DEFROLE;

GRANT SELECT ON BARS.COUNT_CCK_WEB TO START1;