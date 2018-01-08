

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPTRPTPARAMS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPTRPTPARAMS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPTRPTPARAMS ("MODCODE", "DEALID", "DEALNUM", "DATBEG", "DATEND", "TYPENAME", "CUSTID", "CUSTNAME", "CURRENCYID") AS 
  select 'DPT', d.deposit_id, d.nd, to_char(d.dat_begin, 'dd.mm.yyyy'),
       to_char(d.dat_end, 'dd.mm.yyyy'), v.type_name, c.rnk, c.nmk, d.kv
  from dpt_deposit_clos d,
       dpt_vidd         v,
       customer         c
 where d.rnk    = c.rnk
   and d.vidd   = v.vidd
   and d.branch = sys_context('bars_context', 'user_branch')
   and (d.deposit_id, d.idupd) in (select deposit_id, max(idupd)
                                     from dpt_deposit_clos
                                    where bdate <= bankdate
                                    group by deposit_id)
 union all
select 'SOC', s.contract_id, s.contract_num, to_char(s.contract_date, 'dd.mm.yyyy'),
       to_char(s.closed_date, 'dd.mm.yyyy'), v.name, c.rnk, c.nmk, 980
  from social_contracts s,
       social_dpt_types v,
       customer         c
 where s.rnk     = c.rnk
   and s.type_id = v.type_id
   and s.branch  = sys_context('bars_context', 'user_branch')
 ;

PROMPT *** Create  grants  V_DPTRPTPARAMS ***
grant SELECT                                                                 on V_DPTRPTPARAMS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPTRPTPARAMS  to RPBN001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPTRPTPARAMS  to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_DPTRPTPARAMS  to WR_CREPORTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPTRPTPARAMS.sql =========*** End ***
PROMPT ===================================================================================== 
