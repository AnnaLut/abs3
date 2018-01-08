

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CRSOUR_PORTFOLIO.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CRSOUR_PORTFOLIO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CRSOUR_PORTFOLIO ("ND", "DEAL_MFO", "DEAL_NUMBER", "CURRENCY_CODE", "PARTY_ID", "PARTY_MFO", "PARTY_NAME", "START_DATE", "EXPIRY_DATE", "DEAL_AMOUNT", "ACCOUNT_REST", "ACCOUNT_PLAN_REST", "INTEREST_RATE", "MAIN_ACCOUNT", "INTEREST_ACCOUNT", "PARTY_MAIN_ACCOUNT", "PARTY_INTEREST_ACCOUNT", "STATE_ID", "STATE_NAME", "ACC") AS 
  select d.nd,
       d.kf deal_mfo,
       d.cc_id deal_number,
       a.kv currency_code,
       d.rnk party_id,
       b.mfo party_mfo,
       c.nmk party_name,
       d.sdate start_date,
       d.wdate expiry_date,
       dd.s deal_amount,
       a.ostc / 100 account_rest,
       a.ostb / 100 account_plan_rest,
       (select min(ir.ir) keep (dense_rank last order by ir.bdat)
        from   int_ratn ir
        where  ir.acc = ia.acc and
               ir.id = a.pap - 1 and
               ir.bdat <= bankdate()) interest_rate,
       nvl(a.nls, ' ') main_account,
       nvl(aa.nls, ' ') interest_account,
       nvl(dd.acckred, ' ') party_main_account,
       nvl(dd.accperc, ' ') party_interest_account,
       d.sos state_id,
       'Активна' state_name,
       a.acc
from cc_deal d
join cc_add dd on dd.nd = d.nd and dd.adds = 0
join cc_vidd v on v.vidd = d.vidd
left join customer c on c.rnk = d.rnk
left join custbank b on b.rnk = d.rnk
left join accounts a on a.acc = dd.accs
left join int_accn ia on ia.acc = a.acc and
                         ia.id = a.pap - 1
left join accounts aa on aa.acc = ia.acra
where d.vidd in (3902, 3903) and
      d.sos <> 15 and
      a.dazs is null;

PROMPT *** Create  grants  V_CRSOUR_PORTFOLIO ***
grant SELECT                                                                 on V_CRSOUR_PORTFOLIO to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CRSOUR_PORTFOLIO.sql =========*** End
PROMPT ===================================================================================== 
