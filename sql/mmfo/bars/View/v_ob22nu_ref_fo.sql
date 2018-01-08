

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OB22NU_REF_FO.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OB22NU_REF_FO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OB22NU_REF_FO ("REF", "FDAT") AS 
  SELECT p.REF, p.fdat
     FROM opldok p, v_ob22nu n
    WHERE p.acc = n.acc
          AND NOT EXISTS (SELECT 1 FROM opldok
                          WHERE REF = p.REF AND tt = 'PO3')
          and not exists     (select 1 from oper_visa where
                          ref=p.ref and groupid=81) 
 ;

PROMPT *** Create  grants  V_OB22NU_REF_FO ***
grant SELECT                                                                 on V_OB22NU_REF_FO to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OB22NU_REF_FO to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OB22NU_REF_FO to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OB22NU_REF_FO.sql =========*** End **
PROMPT ===================================================================================== 
