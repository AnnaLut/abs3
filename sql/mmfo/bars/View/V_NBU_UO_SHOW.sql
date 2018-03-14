

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBU_UO_SHOW.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBU_UO_SHOW ***

 CREATE OR REPLACE FORCE VIEW BARS.V_NBU_UO_SHOW AS 
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
 fpp.sales as salespr,
 fpp.ebit as ebitpr,
 fpp.ebitda as ebitdapr,
 fpp.totaldebt as totaldebtpr,
 u.status,
 u.status_message,
 'Перегляд' as credit,
 'Перегляд' as plege,
 'Перегляд' as GROUPUR,
 'Перегляд' as PARTNERS,
 'Перегляд' as OWNERPP,
 'Перегляд' as OWNERJUR
 from NBU_PERSON_UO u,
 NBU_FINPERFORMANCE_UO fp,
 NBU_FINPERFORMANCEGR_UO fpg,
 NBU_FINPERFORMANCEPR_UO fpp
 where u.rnk = fp.rnk(+)
 and u.rnk = fpg.rnk(+)
 and u.rnk = fpp.rnk(+)
 order by u.rnk;

grant SELECT                                  on V_NBU_UO_SHOW   to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBU_UO_SHOW.sql =========*** End *** 
PROMPT ===================================================================================== 
