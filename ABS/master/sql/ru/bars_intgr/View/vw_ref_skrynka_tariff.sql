prompt create view bars_intgr.vw_ref_skrynka_tariff
create or replace force view bars_intgr.vw_ref_skrynka_tariff
as
select  tariff,
        name,
        tip,
        o_sk,
        branch,
        basey,
        basem,
        kf
from bars.skrynka_tariff t;

comment on table bars_intgr.vw_ref_skrynka_tariff is 'Коды тарифов';
comment on column bars_intgr.vw_ref_skrynka_tariff.tariff is 'Код тарифа';
comment on column bars_intgr.vw_ref_skrynka_tariff.name is 'Наименование тарифа';
comment on column bars_intgr.vw_ref_skrynka_tariff.tip is 'Тип тарифа';
comment on column bars_intgr.vw_ref_skrynka_tariff.o_sk is 'Вид сейфа (размер)';
comment on column bars_intgr.vw_ref_skrynka_tariff.branch is 'Код отделения';
comment on column bars_intgr.vw_ref_skrynka_tariff.basey is 'База года 0 - календарный 1 - 365 дней 2 - 360';
comment on column bars_intgr.vw_ref_skrynka_tariff.basem is 'База месяца 0 - календарный (28-31 дней) 1 - 30 дней';
comment on column bars_intgr.vw_ref_skrynka_tariff.kf is 'Код филиала';