

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_KLBX_ACCOUNTS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_KLBX_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_KLBX_ACCOUNTS ("ACC", "NLS", "KV", "NMS", "BRANCH") AS 
  select acc, nls, kv, nms, branch
from bars.accounts a, table(sec.getAgrp(a.acc)) g,
        ( select ga.id, ga.scope  -- группы счетов, которые видит JBOSS
          from groups_staff gs,
               groups_staff_acc gsa,
               groups_acc ga
          where idu = 100 and approve = 1 and gs.idg = gsa.idg and gsa.ida = ga.id) gs
where   g.column_value = gs.id and
       (  ( branch in (select branch from v_klbx_branch where isactive = 1) and  gs.scope = 'LOCAL')   or
          ( branch in (select substr( branch,1, length(branch)- 7) from v_klbx_branch where isactive = 1 ) and gs.scope = 'PARENT') or
            gs.scope = 'GLOBAL'
       )
 ;

PROMPT *** Create  grants  V_KLBX_ACCOUNTS ***
grant SELECT                                                                 on V_KLBX_ACCOUNTS to KLBX;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_KLBX_ACCOUNTS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_KLBX_ACCOUNTS.sql =========*** End **
PROMPT ===================================================================================== 
