

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OB22NU_REF_81.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OB22NU_REF_81 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OB22NU_REF_81 ("REF", "FDAT", "SOS") AS 
  SELECT distinct p.REF, p.fdat,'-' SOS
    FROM opldok p, v_ob22nu n
    WHERE p.acc = n.acc  AND NOT EXISTS (SELECT 1 FROM opldok
                          WHERE REF = p.REF AND tt = 'PO3')
                         and  not exists     (select 1 from oper_visa where
                          ref=p.ref and groupid=81)
union ALL
SELECT distinct p.REF, p.fdat,'*' SOS
     FROM opldok p, v_ob22nu n
    WHERE p.acc = n.acc   and  exists     (select 1 from oper_visa where
                          ref=p.ref and groupid=81)
 ;

PROMPT *** Create  grants  V_OB22NU_REF_81 ***
grant SELECT                                                                 on V_OB22NU_REF_81 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OB22NU_REF_81 to NALOG;
grant SELECT                                                                 on V_OB22NU_REF_81 to RPBN001;
grant SELECT                                                                 on V_OB22NU_REF_81 to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OB22NU_REF_81 to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OB22NU_REF_81.sql =========*** End **
PROMPT ===================================================================================== 
