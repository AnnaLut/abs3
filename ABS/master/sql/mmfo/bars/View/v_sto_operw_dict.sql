prompt view v_sto_operw_dict
create or replace force view v_sto_operw_dict
as
select r.tt,
       o.tag,
       o.name,
       ot.tab,
       o.nomodify,
       o.vspo_char,
       o.chkr,
       o.default_value,
       o.type
from op_field o
join op_rules r on o.tag = r.tag
left join op_tag_tab ot on o.tag = ot.tag;

grant select on v_sto_operw_dict to bars_access_defrole;

comment on table v_sto_operw_dict is 'Справочник доступных допреквизитов для операции (исп. в предустановленных допреквизитах STO)';