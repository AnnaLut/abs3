

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_KLBX_ACCOUNTS_CTX.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_KLBX_ACCOUNTS_CTX ***

  CREATE OR REPLACE FORCE VIEW BARS.V_KLBX_ACCOUNTS_CTX ("ACC", "NLS", "KV", "NMS", "BRANCH") AS 
  select acc, nls, kv, nms, a.branch
from bars.accounts a, table(sec.getAgrp(a.acc)) g, v_klbx_branch vb,
        ( select ga.id, ga.scope  -- группы счетов, которые видит JBOSS
          from groups_staff gs,
               groups_staff_acc gsa,
               groups_acc ga
          where idu = 100 and approve = 1 and gs.idg = gsa.idg and gsa.ida = ga.id) gs
where   g.column_value = gs.id and
       (  ( a.branch = sys_context('bars_context','user_branch') and  gs.scope = 'LOCAL')   or
          ( a.branch = substr( sys_context('bars_context','user_branch'),1, length(sys_context('bars_context','user_branch'))- 7) and gs.scope = 'PARENT') or
            gs.scope = 'GLOBAL'
       )
       -- я как бранч, участвую в оффлайн обработке
       and  sys_context('bars_context','user_branch') = vb.branch and vb.isactive = 1
 ;

PROMPT *** Create  grants  V_KLBX_ACCOUNTS_CTX ***
grant SELECT                                                                 on V_KLBX_ACCOUNTS_CTX to BARSREADER_ROLE;
grant SELECT                                                                 on V_KLBX_ACCOUNTS_CTX to KLBX;
grant SELECT                                                                 on V_KLBX_ACCOUNTS_CTX to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_KLBX_ACCOUNTS_CTX to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_KLBX_ACCOUNTS_CTX.sql =========*** En
PROMPT ===================================================================================== 
