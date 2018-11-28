prompt view v_sto_operw
create or replace force view v_sto_operw
as
select w.idd,
       w.kf,
       w.tag,
       f.name,
       w.value
from sto_operw w
left join op_field f on w.tag = f.tag;

grant select on v_sto_operw to bars_access_defrole;

comment on table v_sto_operw is 'Предустановленные допреквизиты макета рег.платежа';