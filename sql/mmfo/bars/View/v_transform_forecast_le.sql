PROMPT ===================================================================================== 
PROMPT *** Run *** ==== Scripts /Sql/BARS/View/v_transform_forecast_le.sql ====*** Run *** 
PROMPT ===================================================================================== 

create or replace view v_transform_forecast_le as
select t.KF
       , t.RNK
       , t.KV
       , t.ACC
       , t.nbs
       , t.NLS
       , t.OB22
       , t.NEW_NBS
       , t.NEW_OB22
       , t.NEW_NLS
       , t.INSERT_DATE
from v_transform_forecast t
where t.nbs in ('2605', '2655');

grant SELECT on v_transform_forecast_le to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ===== Scripts /Sql/BARS/View/v_transform_forecast_le.sql ====*** End *** 
PROMPT ===================================================================================== 
