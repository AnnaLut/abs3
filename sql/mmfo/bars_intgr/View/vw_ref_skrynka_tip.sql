prompt create view bars_intgr.vw_ref_skrynka_tip
create or replace force view bars_intgr.vw_ref_skrynka_tip
as
select  o_sk,
        name,
        s,
        branch,
        kf,
        etalon_id,
        cell_count
from bars.skrynka_tip;

comment on table bars_intgr.vw_ref_skrynka_tip is 'Виды депозитных сейфов';
comment on column bars_intgr.vw_ref_skrynka_tip.o_sk is 'Код вида сейфа (размера)';
comment on column bars_intgr.vw_ref_skrynka_tip.name is 'Наименование вида сейфа';
comment on column bars_intgr.vw_ref_skrynka_tip.s is 'Залоговая стоимость за ключ в формате (дробная часть - копейки)';
comment on column bars_intgr.vw_ref_skrynka_tip.branch is 'Код отделения';
comment on column bars_intgr.vw_ref_skrynka_tip.kf is 'Код филиала';