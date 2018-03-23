create or replace view v_swi_mti_list_light as
select  "KOD_NBU","NAME", "NUM" from (
with tt as (select distinct NAME from V_SWI_MTI_LIST where kod_nbu  = '97')
select distinct decode(t.kod_nbu ,'94','97','95','97','96','97',t.kod_nbu ) KOD_NBU,
                decode(t.kod_nbu ,94,tt.name ,95,tt.name,96,tt.name,t.NAME ) name,
                t.NUM
from V_SWI_MTI_LIST t , tt, SW_SYSTEM s
where t.KOD_NBU is not null
  and s.kod_nbu = t.KOD_NBU
union all
select null KOD_NBU, 'Всі системи' NAME, null from dual)
order by KOD_NBU nulls first;

grant SELECT                                                on v_swi_mti_list_light    to BARS_ACCESS_DEFROLE;
