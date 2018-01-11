

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SW950_DOC.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SW950_DOC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SW950_DOC ("REF", "FDAT", "ACC", "DK", "S", "DETAIL", "SOS", "TH_REF", "TT") AS 
  SELECT o.REF,
          o.fdat,
          o.acc,
          o.dk,
          o.s,
          p.nazn detail,
          o.sos, 
          (select value from operw where tag='20' and ref=p.ref) value,
          p.tt
     FROM opldok o, oper p
    WHERE     o.REF = p.REF
          AND o.acc IN (SELECT acc FROM bic_acc)
          AND o.tt!='NOS'
          AND NOT EXISTS
                 (SELECT s.swref
                    FROM sw_oper s, sw_journal j, sw_stmt s
                   WHERE s.REF = o.REF AND s.swref = j.swref AND j.mt = s.mt)
     union all 
     SELECT o.REF,
          o.fdat,
          o.acc,
          o.dk,
          o.s,
          p.nazn detail,
          o.sos, 
          swj.trn value,
          p.tt
     FROM opldok o, oper p, sw_oper swo, sw_journal swj
    WHERE     o.REF = p.REF
          AND swj.swref=swo.swref
          AND swo.ref=p.ref
          AND o.acc IN (SELECT acc FROM bic_acc)
          AND o.tt='NOS'
          AND (p.sos=1 and p.nextvisagrp in('47'))
   WITH READ ONLY;

PROMPT *** Create  grants  V_SW950_DOC ***
grant SELECT                                                                 on V_SW950_DOC     to BARS013;
grant SELECT                                                                 on V_SW950_DOC     to BARSREADER_ROLE;
grant SELECT                                                                 on V_SW950_DOC     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SW950_DOC     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SW950_DOC     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SW950_DOC.sql =========*** End *** ==
PROMPT ===================================================================================== 
