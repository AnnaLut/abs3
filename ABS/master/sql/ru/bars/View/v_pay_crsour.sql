create or replace view v_pay_crsour as
select *
from   table(cdb_mediator.make_docinput(to_number(pul.get_mas_ini_val('ND'))));

grant select on v_pay_crsour to bars_access_defrole;
