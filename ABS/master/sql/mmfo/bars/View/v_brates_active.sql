

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BRATES_ACTIVE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BRATES_ACTIVE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BRATES_ACTIVE ("BR_ID", "BR_NAME", "TYPE_ID", "TYPE_NAME", "BRANCH_ID", "BRANCH_NAME", "DAT", "CUR_ID", "CUR_CODE", "CUR_NAME", "LIMIT", "RATE") AS 
  select b.br_id, b.name, t.br_type, t.name, v.branch, r.name, v.bdate, l.kv, l.lcv, l.name, v.s, v.rate
  from brates b, br_types t, tabval l, branch r,
       (select n.branch, n.br_id br_id, n.bdate bdate, n.kv kv, null s, n.rate rate
          from br_normal_edit n
         where (n.br_id, n.branch, n.kv, n.bdate) = (select n1.br_id, n1.branch, n1.kv, max(n1.bdate)
                                                       from br_normal_edit n1
                                                      where n1.br_id = n.br_id
                                                        and n1.branch = n.branch
                                                        and n1.kv = n.kv
                                                        and n1.bdate <= bankdate
                                                      group by n1.br_id, n1.branch, n1.kv)
         union all
        select t.branch, t.br_id br_id, t.bdate bdate, t.kv kv, t.s s, t.rate rate
          from br_tier_edit t
         where (t.br_id, t.branch, t.kv, t.bdate) = (select t1.br_id, t1.branch, t1.kv, max(t1.bdate)
                                                       from br_tier_edit t1
                                                      where t1.br_id = t.br_id
                                                        and t1.branch = t.branch
                                                        and t1.kv = t.kv
                                                        and t1.bdate <= bankdate
                                                      group by t1.br_id, t1.branch, t1.kv)
       ) v
 where b.br_id   = v.br_id
   and b.br_type = t.br_type
   and v.kv = l.kv
   and v.branch = r.branch
 union all
select b.br_id, b.name, t.br_type, t.name, null, null, null, null, null, null, null, null
  from brates b, br_types t
 where b.br_type = t.br_type
   and not exists (select 1 from br_normal n where n.br_id = b.br_id)
   and not exists (select 1 from br_tier t   where t.br_id = b.br_id)
 ;

PROMPT *** Create  grants  V_BRATES_ACTIVE ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BRATES_ACTIVE to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_BRATES_ACTIVE to DPT_ADMIN;
grant SELECT                                                                 on V_BRATES_ACTIVE to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BRATES_ACTIVE to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_BRATES_ACTIVE to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BRATES_ACTIVE.sql =========*** End **
PROMPT ===================================================================================== 
