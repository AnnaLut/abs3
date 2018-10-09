PROMPT ===================================================================================== 
PROMPT *** Run *** ====== Scripts /Sql/BARS/View/v_transform_forecast.sql ======*** Run *** 
PROMPT ===================================================================================== 

create or replace view v_transform_forecast as
select t.KF
       , t.RNK
       , t.KV
       , t.ACC
       , a.nbs
       , t.NLS
       , t.OB22
       , t.NEW_NBS
       , t.NEW_OB22
       , t.NEW_NLS
       , t.INSERT_DATE
from transform_2017_forecast t
join accounts a on a.acc = t.acc
where a.nbs in ('2605', '2625', '2655')
      and t.kf = sys_context('bars_context','user_mfo');

grant SELECT on v_transform_forecast to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ====== Scripts /Sql/BARS/View/v_transform_forecast.sql ======*** End *** 
PROMPT ===================================================================================== 
