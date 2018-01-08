

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FINMON_REFT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FINMON_REFT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FINMON_REFT ("ORIGIN", "C1", "C4", "C6", "C7", "C8", "C9", "C2", "C13", "C34", "C20", "C5", "C37", "NAME_HASH") AS 
  select '√ƒ‘Ã' origin, c1, c4, c6, c7, c8, c9, c2, c13, c34, c20, c5, c37, name_hash
  from finmon_reft
 where c6 is not null
    or c7 is not null
    or c8 is not null
    or c9 is not null
union all
select '√ƒ‘Ã' origin, a.c1, t.c4, a.c6, a.c7, a.c8, a.c9, t.c2, t.c13, t.c34, t.c20, t.c5, t.c37, a.name_hash
  from finmon_reft_akalist a, finmon_reft t
 where (a.c6 is not null
    or a.c7 is not null
    or a.c8 is not null
    or a.c9 is not null)
   and a.c1 = t.c1;

PROMPT *** Create  grants  V_FINMON_REFT ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_FINMON_REFT   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_FINMON_REFT   to FINMON01;
grant FLASHBACK,SELECT                                                       on V_FINMON_REFT   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FINMON_REFT.sql =========*** End *** 
PROMPT ===================================================================================== 
