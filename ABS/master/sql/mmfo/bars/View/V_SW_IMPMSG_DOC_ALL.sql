CREATE OR REPLACE FORCE VIEW BARS.V_SW_IMPMSG_DOC_ALL
(
   REF,
   VDAT,
   NLSA,
   NLSB,
   AMOUNT,
   LCV,
   DIG,
   DK,
   NAZN,
   ACCD,
   ACCK,
   S,
   FDAT,
   TAG20,
   TT,
   NEXTVISAGRP
)
AS
     SELECT p.REF,
            p.vdat,
            p.nlsa,
            p.nlsb,
            p.s amount,
            t.lcv,
            t.dig,
            p.dk,
            p.nazn,
            o1.acc accd,
            o2.acc acck,
            o1.s,
            o1.fdat,
            (SELECT SUBSTR (swow.VALUE, 1, 150)
               FROM sw_operw swow, sw_oper swo
              WHERE     swow.swref = swo.swref
                    AND swow.tag = '20'
                    AND swo.REF = p.REF
                    AND ROWNUM = 1)
               tag20,
            p.tt,
            p.nextvisagrp
       FROM opldok o1,
            opldok o2,
            oper p,
            accounts a1,
            accounts a2,
            tabval t
      WHERE     p.kv = t.kv
            AND p.REF = o1.REF
            AND o1.dk = 0
            AND o2.dk = 1
            AND o1.REF = o2.REF
            AND o1.stmt = o2.stmt
            --    AND p.vdat >= bankdate - 3
            --    AND o1.fdat >= bankdate - 3
            --    AND o2.fdat >= bankdate - 3
            AND o1.acc = a1.acc
            AND o2.acc = a2.acc
            AND (a1.nbs IN ('1500', '1600') OR a2.nbs IN ('1500', '1600'))
   ORDER BY p.vdat DESC
   WITH READ ONLY;


CREATE OR REPLACE PUBLIC SYNONYM V_SW_IMPMSG_DOC_ALL FOR BARS.V_SW_IMPMSG_DOC_ALL;


GRANT SELECT ON BARS.V_SW_IMPMSG_DOC_ALL TO BARS013;

GRANT SELECT ON BARS.V_SW_IMPMSG_DOC_ALL TO BARS_ACCESS_DEFROLE;

GRANT SELECT ON BARS.V_SW_IMPMSG_DOC_ALL TO START1;
