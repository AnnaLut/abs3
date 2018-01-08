

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBS_PROFTAG.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBS_PROFTAG ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBS_PROFTAG ("PR", "ID", "TAG", "NAME", "NSINAME", "PAR") AS 
  select 1 pr, id, tag, name, nsiname, null par from nbs_proftag
union all
select 2, spid, name, semantic, nsiname, tag from sparam_list
where inuse=1
 ;

PROMPT *** Create  grants  V_NBS_PROFTAG ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_NBS_PROFTAG   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBS_PROFTAG   to CUST001;
grant SELECT                                                                 on V_NBS_PROFTAG   to NBS_PROF;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_NBS_PROFTAG   to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_NBS_PROFTAG   to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_NBS_PROFTAG   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBS_PROFTAG.sql =========*** End *** 
PROMPT ===================================================================================== 
