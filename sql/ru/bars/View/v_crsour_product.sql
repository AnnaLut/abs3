create or replace view v_crsour_product as
select t.vidd, t.name
from   cc_vidd t
where  t.vidd in (3902, 3903);

grant select on v_crsour_product to bars_access_defrole;
