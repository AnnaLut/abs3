

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CRSOUR_ACCOUNTS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CRSOUR_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CRSOUR_ACCOUNTS ("ND", "NLS", "KV", "NMS", "BRANCH", "DAOS", "OSTC", "DAPP", "RNK", "OB22", "ACC") AS 
  select d.nd,
       a.nls,
       a.KV,
       a.NMS,
       a.BRANCH,
       a.DAOS,
       a.OSTC/100 as OSTC,
       a.DAPP,
       a.RNK,
       a.OB22,
       a.acc
   from cc_deal d
join cc_add n on n.nd = d.nd and n.adds = 0
join accounts a on a.acc = n.accs
join int_accn i on i.acc = a.acc and i.id = case when d.vidd = 3902 then 0 else 1 end
where d.vidd in (3902, 3903)
union all
select d.nd,
       ia.nls,
       ia.KV,
       ia.NMS,
       ia.BRANCH,
       ia.DAOS,
       ia.OSTC/100 as OSTC,
       ia.DAPP,
       ia.RNK,
       ia.OB22,
       ia.acc
   from cc_deal d
join cc_add n on n.nd = d.nd and n.adds = 0
join accounts a on a.acc = n.accs
join int_accn i on i.acc = a.acc and i.id = case when d.vidd = 3902 then 0 else 1 end
join accounts ia on ia.acc = i.acra
where d.vidd in (3902, 3903)
union all
select d.nd,
       ab.nls,
       ab.KV,
       ab.NMS,
       ab.BRANCH,
       ab.DAOS,
       ab.OSTC/100 as OSTC,
       ab.DAPP,
       ab.RNK,
       ab.OB22,
       ab.acc from cc_deal d
join cc_add n on n.nd = d.nd and n.adds = 0
join accounts a on a.acc = n.accs
join int_accn i on i.acc = a.acc and i.id = case when d.vidd = 3902 then 0 else 1 end
join accounts ab on ab.acc = i.acrb
where d.vidd in (3902, 3903);

PROMPT *** Create  grants  V_CRSOUR_ACCOUNTS ***
grant SELECT                                                                 on V_CRSOUR_ACCOUNTS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CRSOUR_ACCOUNTS.sql =========*** End 
PROMPT ===================================================================================== 
