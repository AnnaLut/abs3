PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CORE_FO_SHOW.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CORE_FO_SHOW ***

create or replace view V_CORE_FO_SHOW as
select p.rnk,
 p.kf,
 p.lastname,
 p.firstname,
 p.middlename,
 p.isrez,
 p.inn,
 p.birthday,
 p.countrycodnerez,
 p.k060,
 p.education,
 p.typew,
 p.codedrpou,
 p.namew,
 adr.codregion,
 adr.area,
 adr.zip,
 adr.city,
 adr.streetaddress,
 adr.houseno,
 adr.adrkorp,
 adr.flatno,
 pro.real6month,
 pro.noreal6month,
 fam.status_f,
 fam.members,
 p.STATUS,
 p.STATUS_MESSAGE,
 'Перегляд' as DOCUMENT,
 'Перегляд' as credit,
 'Перегляд' as plege
 from V_CORE_PERSON_FO p,
 V_CORE_ADDRESS_FO adr,
 V_CORE_PROFIT_FO pro,
 V_CORE_FAMILY_FO fam
 where p.rnk = adr.rnk(+)
 and p.rnk = pro.rnk(+)
 and p.rnk = fam.rnk(+)
 order by p.rnk;


PROMPT *** Create  grants  V_CORE_FO_SHOW ***
grant SELECT                                                                 on V_CORE_FO_SHOW to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CORE_FO_SHOW.sql =========**
PROMPT ===================================================================================== 
