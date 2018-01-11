

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ACC_TARIF.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ACC_TARIF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ACC_TARIF ("ACC", "TYPE", "KOD", "TAR", "PR", "SMIN", "KV_SMIN", "SMAX", "KV_SMAX", "BDATE", "EDATE") AS 
  select acc, 2 type, kod, tar, pr, smin, kv_smin, smax, kv_smax, bdate, edate
  from acc_tarif
 where trunc(bankdate,'dd')>=decode(bdate,null,trunc(bankdate,'dd'),bdate)
   and trunc(bankdate,'dd')<=decode(edate,null,trunc(bankdate,'dd'),edate)
 union all
-- 1-по схеме тарифов / 0-общий
select c.acc, decode(c.ids,0,0,1), t.kod, t.tar, t.pr, t.smin, t.kv_smin, t.smax, t.kv_smax, null, null
  from -- список счетов и их схем тарифов
       ( select a.acc, nvl(m.id,0) ids
           from accounts a,
                -- список действующих схем тарифов счетов
                ( select w.acc, m.id
                    from accountsw w, tarif_scheme m
                   where w.tag = 'SHTAR' and trim(w.value) = to_char(m.id) ) m
           where a.acc = m.acc(+) ) c,
       -- список тарифов для каждой схемы
       v_sh_tarif t
 where c.ids = t.id
   and not exists ( select 1
                      from acc_tarif
                     where acc = c.acc
                       and kod = t.kod
                       and trunc(bankdate,'dd')>=decode(bdate,null,trunc(bankdate,'dd'),bdate)
                       and trunc(bankdate,'dd')<=decode(edate,null,trunc(bankdate,'dd'),edate) ) ;

PROMPT *** Create  grants  V_ACC_TARIF ***
grant SELECT                                                                 on V_ACC_TARIF     to BARSREADER_ROLE;
grant SELECT                                                                 on V_ACC_TARIF     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ACC_TARIF     to CUST001;
grant SELECT                                                                 on V_ACC_TARIF     to START1;
grant SELECT                                                                 on V_ACC_TARIF     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ACC_TARIF.sql =========*** End *** ==
PROMPT ===================================================================================== 
