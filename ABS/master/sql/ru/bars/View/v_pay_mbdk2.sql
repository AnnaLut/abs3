create or replace view v_pay_mbdk2 as
select *
from   table(mbk.make_docinput(to_number(pul.get_mas_ini_val('ND'))));

grant select on v_pay_mbdk2 to bars_access_defrole;
