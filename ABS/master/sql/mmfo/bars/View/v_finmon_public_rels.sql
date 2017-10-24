

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FINMON_PUBLIC_RELS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FINMON_PUBLIC_RELS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FINMON_PUBLIC_RELS ("ID", "NAME", "TERMIN", "PRIZV", "FNAME", "BIRTH", "BIO", "TERMINMOD") AS 
  select ID,
 NAME,
 TERMIN,
 PRIZV,
 FNAME,
 BIRTH,
 DBMS_LOB.SUBSTR(BIO,4000),
 TERMINMOD
from FINMON_PUBLIC_RELS;

PROMPT *** Create  grants  V_FINMON_PUBLIC_RELS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_FINMON_PUBLIC_RELS to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_FINMON_PUBLIC_RELS to FINMON01;
grant FLASHBACK,SELECT                                                       on V_FINMON_PUBLIC_RELS to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FINMON_PUBLIC_RELS.sql =========*** E
PROMPT ===================================================================================== 
