

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BPK_BRANCH.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BPK_BRANCH ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BPK_BRANCH ("BRANCH", "NAME", "CODE") AS 
  select "BRANCH","NAME","VAL"
  from ( select b.branch, b.name, p.val
           from branch b, branch_parameters p
          where b.branch = p.branch(+)
            and p.tag(+) = 'BPK_BRANCH'
            and length(b.branch) >= 15
          union all
         select null, null, null from dual )
 where branch is not null;

PROMPT *** Create  grants  V_BPK_BRANCH ***
grant SELECT                                                                 on V_BPK_BRANCH    to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BPK_BRANCH    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_BPK_BRANCH    to OBPC;
grant SELECT                                                                 on V_BPK_BRANCH    to UPLD;
grant FLASHBACK,SELECT                                                       on V_BPK_BRANCH    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BPK_BRANCH.sql =========*** End *** =
PROMPT ===================================================================================== 
