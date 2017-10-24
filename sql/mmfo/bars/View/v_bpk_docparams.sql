

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BPK_DOCPARAMS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BPK_DOCPARAMS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BPK_DOCPARAMS ("BRANCH", "NAME", "FIO", "FIOR", "DOVER", "POSADA", "POSADAR", "PHONE") AS 
  select "BRANCH","NAME","FIO","FIOR","DOVER","POSADA","POSADAR","PHONE"
  from ( select b.branch, b.name,
                min(decode(p.tag,'BPK_BOSS_FIO',p.val,null)) fio,
                min(decode(p.tag,'BPK_BOSS_FIOR',p.val,null)) fior,
                min(decode(p.tag,'BPK_DOVER',p.val,null)) dover,
                min(decode(p.tag,'BPK_POSADA',p.val,null)) posada,
                min(decode(p.tag,'BPK_POSADAR',p.val,null)) posadar,
                min(decode(p.tag,'BPK_PHONE',p.val,null)) phone
           from branch b, branch_parameters p
          where b.branch = p.branch(+)
            and p.tag(+) like 'BPK%'
            and b.branch like sys_context ('bars_context', 'user_branch_mask')
          group by b.branch, b.name
          union all
         select null, null, null, null, null, null, null, null from dual )
 where branch is not null;

PROMPT *** Create  grants  V_BPK_DOCPARAMS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BPK_DOCPARAMS to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_BPK_DOCPARAMS to OBPC;
grant FLASHBACK,SELECT                                                       on V_BPK_DOCPARAMS to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BPK_DOCPARAMS.sql =========*** End **
PROMPT ===================================================================================== 
