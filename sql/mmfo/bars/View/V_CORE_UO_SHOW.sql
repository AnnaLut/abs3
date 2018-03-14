PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CORE_UO_SHOW.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CORE_UO_SHOW ***

create or replace view V_CORE_UO_SHOW as
select u.rnk,
 u.kf,
 u.nameur,
 u.isrez,
 u.codedrpou,
 u.registryday,
 u.numberregistry,
 u.k110,
 u.ec_year,
 u.countrycodnerez,
 u.ismember,
 u.iscontroller,
 u.ispartner,
 u.isaudit,
 u.k060,
 fp.sales,
 fp.ebit,
 fp.ebitda,
 fp.totaldebt,
 fpg.salesgr,
 fpg.ebitgr,
 fpg.ebitdagr,
 fpg.totaldebtgr,
 fpg.classgr,
 u.STATUS,
 u.STATUS_MESSAGE,
 fpp.sales as salespr,
 fpp.ebit as ebitpr,
 fpp.ebitda as ebitdapr,
 fpp.totaldebt as totaldebtpr,
 'Перегляд' as credit,
 'Перегляд' as plege,
 'Перегляд' as GROUPUR,
 'Перегляд' as PARTNERS,
 'Перегляд' as OWNERPP,
 'Перегляд' as OWNERJUR
 from V_CORE_PERSON_UO u,
 V_CORE_FINPERFORMANCE_UO fp,
 V_CORE_FINPERFORMANCEGR_UO fpg,
 V_CORE_FINPERFORMANCEPR_UO fpp
 where u.rnk = fp.rnk(+)
 and u.rnk = fpg.rnk(+)
 and u.rnk = fpp.rnk(+)
 order by u.rnk;

PROMPT *** Create  grants  V_CORE_UO_SHOW ***
grant SELECT                                                                 on V_CORE_UO_SHOW to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CORE_UO_SHOW.sql =========**
PROMPT ===================================================================================== 
