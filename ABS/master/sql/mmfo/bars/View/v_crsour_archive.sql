

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CRSOUR_ARCHIVE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CRSOUR_ARCHIVE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CRSOUR_ARCHIVE ("ND", "DEAL_MFO", "DEAL_NUMBER", "CURRENCY_CODE", "PARTY_ID", "PARTY_MFO", "PARTY_NAME", "START_DATE", "EXPIRY_DATE", "DEAL_AMOUNT", "ACCOUNT_REST", "INTEREST_RATE", "MAIN_ACCOUNT", "INTEREST_ACCOUNT", "PARTY_MAIN_ACCOUNT", "PARTY_INTEREST_ACCOUNT", "STATE_CODE", "STATE_NAME", "ACC") AS 
  select d.nd,
       d.kf deal_mfo,
       d.cc_id deal_number,
       a.kv currency_code,
       d.rnk party_id,
       (select b.mfo from custbank b where b.rnk = d.rnk) party_mfo,
       c.nmk party_name,
       d.sdate start_date,
       d.wdate expiry_date,
       dd.s deal_amount,
       a.ostc / 100 account_rest,
       (select min(ir.ir) keep(dense_rank last order by ir.bdat)
          from int_ratn ir
         where ir.acc = ia.acc
           and ir.id = case
                 when v.tipd = 1 then 0 else 1
               end
           and ir.bdat <= bankdate()) interest_rate,
       a.nls main_account,
       aa.nls interest_account,
       dd.acckred party_main_account,
       dd.accperc party_interest_account,
       d.sos state_code,
       'Закрита' state_name,
       a.acc
  from cc_deal d
  join cc_add dd
    on dd.nd = d.nd
   and dd.adds = 0
  join cc_vidd v
    on v.vidd = d.vidd
  left join customer c
    on c.rnk = d.rnk
  left join accounts a
    on a.acc = dd.accs
  left join int_accn ia
    on ia.acc = a.acc
   and ia.id = case
         when v.tipd = 1 then 0 else 1
       end
  left join accounts aa
    on aa.acc = ia.acra
 where d.vidd in (3902,3903) and d.sos = 15;

PROMPT *** Create  grants  V_CRSOUR_ARCHIVE ***
grant SELECT                                                                 on V_CRSOUR_ARCHIVE to BARSREADER_ROLE;
grant SELECT                                                                 on V_CRSOUR_ARCHIVE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CRSOUR_ARCHIVE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CRSOUR_ARCHIVE.sql =========*** End *
PROMPT ===================================================================================== 
