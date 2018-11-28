prompt view V_STO_GRP_UI
create or replace force view v_sto_grp_ui as
select idg, name, tobo, kf
from sto_grp;

grant select on v_sto_grp_ui to bars_access_defrole;

comment on table v_sto_grp_ui is 'Группы регулярных платежей (веб)';
comment on column v_sto_grp_ui.idg is 'ИД группы';
comment on column v_sto_grp_ui.name is 'Название группы';
comment on column v_sto_grp_ui.tobo is 'Бранч, под которым заведена группа';
comment on column v_sto_grp_ui.kf is 'Код филиала';
