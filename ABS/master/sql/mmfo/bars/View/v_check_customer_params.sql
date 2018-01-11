

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CHECK_CUSTOMER_PARAMS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CHECK_CUSTOMER_PARAMS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CHECK_CUSTOMER_PARAMS ("BRANCH", "ISP", "RNK", "NMK", "TAG", "VAL") AS 
  select  branch, isp, rnk, nmk, replace(replace(replace(replace(replace(tag,'_1',''),'_2',''),'_3',''),'_4',''),'_5','') tag, val
from
(
select c.branch, c.ISP, c.RNK, c.NMK,
      case
        when codcagent in (2,4,6) and country = 804 then 'Несоответствие параметров: ''Вид контрагента''(codcagent)='||codcagent||' ''Страна''='||country
        else null
      end codcagent,
      case
        when codcagent not in (2,4,6) and country <> 804 then 'Несоответствие параметров: ''Вид контрагента''(codcagent)='||codcagent||' ''Страна''='||country
        else null
      end codcagent_1,
      case
        when k.k040 is null then 'Недопустимый параметр: ''Страна''='||country
        else null
      end country,
      case
        when codcagent not in (1,2) and custtype = 1 then 'Несоответствие параметров: ''Вид контрагента''(codcagent)='||codcagent||' ''Тип контрагента''(custtype)='||custtype
        else null
      end codcagent_2,
      case
        when codcagent not in (3,4) and custtype = 2 then 'Несоответствие параметров: ''Вид контрагента''(codcagent)='||codcagent||' ''Тип контрагента''(custtype)='||custtype
        else null
      end codcagent_3,
      case
        when codcagent not in (5,6) and custtype = 3 then 'Несоответствие параметров: ''Вид контрагента''(codcagent)='||codcagent||' ''Тип контрагента''(custtype)='||custtype
        else null
      end codcagent_4,
      case
        when codcagent > 6 and custtype not in (1,2) then 'Несоответствие параметров: ''Вид контрагента''(codcagent)='||codcagent||' ''Тип контрагента''(custtype)='||custtype
        else null
      end codcagent_5,
      case
        when k1.k060 is null and c.prinsider <> 0 then 'Недопустимый параметр: ''Инсайдер''(prinsider)='||prinsider
        else null
      end prinsider,
      case
        when replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(trim(c.okpo),'0',''),'1',''),'2',''),'3',''),'4',''),'5',''),'6',''),'7',''),'8',''),'9','') is not null
            then 'Недопустимый параметр: ''ОКПО''='||c.okpo
        else null
      end okpo,
      case
        when k2.k070 is null and country = 804 then  'Недопустимый параметр: k070='||ise
        else null
      end k070,
      case
        when k3.k080 is null and country = 804 then  'Недопустимый параметр: k080='||fs
        else null
      end k080,
      case
        when k4.k090 is null and country = 804 then  'Недопустимый параметр: k090='||oe
        else null
      end k090,
      case
        when k5.k110 is null and country = 804 then  'Недопустимый параметр: k110='||ved
        else null
      end k110,
      case
        when k6.k051 is null and country = 804 then  'Недопустимый параметр: k051='||sed
        else null
      end k051
from customer c
     left join kl_k040 k on k.k040 = c.country
     left join kl_k060 k1 on k1.k060 = c.prinsider
     left join kl_k070 k2 on k2.k070 = c.ise
     left join kl_k080 k3 on k3.k080 = c.fs
     left join kl_k090 k4 on k4.k090 = c.oe
     left join kl_k110 k5 on k5.k110 = c.ved
     left join kl_k051 k6 on k6.k051 = c.sed
where  nvl(c.date_off,to_date('01014000','ddmmyyyy')) > bankdate and
      (  (codcagent in (2,4,6) and country = 804) or
      (codcagent not in (2,4,6) and country <> 804) or
      k.k040 is null or
      (codcagent not in (1,2) and custtype = 1) or
      (codcagent not in (3,4) and custtype = 2) or
      (codcagent not in (5,6) and custtype = 3) or
      (codcagent > 6 and custtype not in (1,2)) or
      (k1.k060 is null and c.prinsider <> 0) or
      replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(trim(c.okpo),'0',''),'1',''),'2',''),'3',''),'4',''),'5',''),'6',''),'7',''),'8',''),'9','') is not null or
      (k2.k070 is null and country = 804) or
      (k3.k080 is null and country = 804) or
      (k5.k110 is null and country = 804) or
      (k6.k051 is null and country = 804)
      )
)
unpivot ( val FOR tag IN (codcagent,codcagent_1,codcagent_2,codcagent_3,codcagent_4,codcagent_5,country,prinsider,okpo,k070,k080,k090,k110,k051))
 ;

PROMPT *** Create  grants  V_CHECK_CUSTOMER_PARAMS ***
grant SELECT                                                                 on V_CHECK_CUSTOMER_PARAMS to BARSREADER_ROLE;
grant SELECT                                                                 on V_CHECK_CUSTOMER_PARAMS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CHECK_CUSTOMER_PARAMS to RPBN002;
grant SELECT                                                                 on V_CHECK_CUSTOMER_PARAMS to TECH005;
grant SELECT                                                                 on V_CHECK_CUSTOMER_PARAMS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CHECK_CUSTOMER_PARAMS.sql =========**
PROMPT ===================================================================================== 
