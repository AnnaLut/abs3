create or replace view V_PAY_MBDK as 
select y.pap, y.npp,  y.txt, x.nd, x.kv, x.nls, x.nlsn , 0 STP, 0 ok,
  x.ostc_a , x.ostc_B, x.ostb_a, x.ostb_b, x.ostf_a, x.ostf_b, x.acr_dat, x.wdate, x.limit, x.rnk, x.sdate  
from 
(
select d.nd, a.pap, a.nls, b.nls nlsn, a.kv, d.limit, d.rnk,  a.ostc/100 ostc_a, b.ostc/100 ostc_B, a.acc, 
  a.ostb/100 ostb_a, b.ostb/100 ostb_b,   a.ostf/100 ostf_a, b.ostf/100 ostf_b,   i.acr_dat , d.wdate  , d.sdate
 from cc_deal d, cc_add c, accounts a, accounts b, int_accn i
 where c.accs = a.acc and i.acra = b.acc and c.nd = d.nd  and d.nd = to_number( pul.Get_Mas_Ini_Val('ND' ))
  and i.acc  = a.acc and i.id = a.pap -1 
 ) x,
( select 1 pap, 10 NPP, 'Відправка на розміщення осн.суми' txt  from dual union all
  select 1    , 11    , 'Прийняти погашення оcн.суми'           from dual union all
  select 1    , 12    , 'Нарахувати %%/доходы'                  from dual union all 
  select 1    , 13    , 'Прийняти погашення %%'                 from dual union all
  select 2    , 20    , 'Прийняти на залучення осн.суму'        from dual union all
  select 2    , 21    , 'Повернути залучену осн.суму'           from dual union all
  select 2    , 22    , 'Нарахувати %%/витрати'                 from dual union all
  select 2    , 23    , 'Перерахувати нарах %%'                 from dual  
) y 
where x.pap = y.pap and x.kv = 980 -- про валюту - временно
  and (   y.npp = 10 and x.ostB_a = 0 and x.ostB_a = x.ostC_a
       OR y.npp = 11 and x.ostB_a < 0 and x.ostB_a = x.ostC_a
       OR y.npp = 12 and x.ostC_a < 0 and x.acr_dat < x.wdate -1  
       OR y.npp = 13 and x.ostB_b < 0 and x.ostB_b = x.ostC_b
       OR y.npp = 20 and x.ostB_a = 0 and x.ostB_a = x.ostC_a 
       OR y.npp = 21 and x.ostB_a > 0 and x.ostB_a = x.ostC_a 
       OR y.npp = 22 and x.ostC_a > 0 and x.acr_dat < x.wdate -1  
       OR y.npp = 23 and x.ostB_b > 0  and x.ostB_b = x.ostC_b 
  );


grant select on V_PAY_MBDK to start1;

