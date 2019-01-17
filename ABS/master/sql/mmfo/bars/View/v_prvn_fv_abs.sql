create or replace view v_prvn_fv_abs as 
select q.*, decode(kv,980,fv_abs,p_icurval(kv,fv_abs*100,Dat_last_work (TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy')-1) )/100) fv_absq 
from  (select kf,tip,kv,sum(nvl(fv_abs,0)) fv_abs 
       from prvn_osaq 
       group by kf,tip,kv) q 
where fv_abs <> 0;

grant SELECT on v_prvn_fv_abs       to BARS_ACCESS_DEFROLE;
/