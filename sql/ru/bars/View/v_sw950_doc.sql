

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SW950_DOC.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SW950_DOC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SW950_DOC ("REF", "FDAT", "ACC", "DK", "S", "DETAIL", "SOS") AS 
  select o.ref, o.fdat, o.acc, o.dk, o.s, p.nazn detail, o.sos
  from opldok o, oper p
 where o.ref = p.ref
   and o.acc in (select acc from bic_acc)
   and not exists (select s.swref
                     from sw_oper s, sw_journal j, sw_stmt s
                    where s.ref   = o.ref
                      and s.swref = j.swref
                      and j.mt    = s.mt    )
with read only;

PROMPT *** Create  grants  V_SW950_DOC ***
grant SELECT                                                                 on V_SW950_DOC     to BARS013;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SW950_DOC     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SW950_DOC.sql =========*** End *** ==
PROMPT ===================================================================================== 
