

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OB22NU_REF_PO.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OB22NU_REF_PO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OB22NU_REF_PO ("REF", "FDAT") AS 
  SELECT p.ref ,p.fdat  FROM opldok p, v_ob22nu n 
               WHERE p.acc=n.acc  
               and  exists ( SELECT 1  FROM opldok
                               WHERE ref = p.ref and tt = 'PO3' ) 
 ;

PROMPT *** Create  grants  V_OB22NU_REF_PO ***
grant SELECT                                                                 on V_OB22NU_REF_PO to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OB22NU_REF_PO to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OB22NU_REF_PO to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OB22NU_REF_PO.sql =========*** End **
PROMPT ===================================================================================== 
