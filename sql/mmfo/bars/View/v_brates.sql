

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BRATES.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BRATES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BRATES ("BR_ID", "BR_NAME", "TYPE_ID", "TYPE_NAME", "BRANCH_ID", "BRANCH_NAME", "DAT", "CUR_ID", "CUR_CODE", "CUR_NAME", "LIMIT", "RATE") AS 
  select b.br_id, b.name, t.br_type, t.name, v.branch, r.name,
       v.bdate, l.kv, l.lcv, l.name, v.s, v.rate
  from brates b, br_types t, tabval l, branch r,
       (select n.branch, n.br_id br_id, n.bdate bdate, n.kv kv, null s, n.rate rate
          from br_normal_edit n
         union all
        select t.branch, t.br_id br_id, t.bdate bdate, t.kv kv, t.s s, t.rate rate
          from br_tier_edit t
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

PROMPT *** Create  grants  V_BRATES ***
grant SELECT                                                                 on V_BRATES        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BRATES        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_BRATES        to DPT_ADMIN;
grant SELECT                                                                 on V_BRATES        to START1;
grant SELECT                                                                 on V_BRATES        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BRATES        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_BRATES        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BRATES.sql =========*** End *** =====
PROMPT ===================================================================================== 
