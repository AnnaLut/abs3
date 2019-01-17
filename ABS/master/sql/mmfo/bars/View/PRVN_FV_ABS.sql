create or replace view PRVN_FV_ABS as 
select kf  ,
       rnk ,
       tip ,
       nd  ,
       kv  ,
       rezb,
       rez9,
       comm, 
       fv_abs 
from prvn_osaq 
where fv_abs <> 0  order by fv_abs desc;

grant SELECT on FV9P       to BARS_ACCESS_DEFROLE;


