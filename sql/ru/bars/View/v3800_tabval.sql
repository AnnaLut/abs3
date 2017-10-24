create or replace view V3800_TABVAL as 
  select * from tabval t 
  where exists (select kv from accounts where nbs ='3800' and dazs is null and kv = t.kv) and kv <> 980 ;

grant select on V3800_TABVAL to BARS_ACCESS_DEFROLE ;