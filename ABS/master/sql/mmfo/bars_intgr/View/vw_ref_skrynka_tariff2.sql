prompt create view bars_intgr.vw_ref_skrynka_tariff2
create or replace force view bars_intgr.vw_ref_skrynka_tariff2
as
select  tariff,
        tariff_date,
        daysfrom,
        daysto,
        s,
        flag1,
        proc,
        peny,
        branch,
        kf
from bars.skrynka_tariff2 t;

comment on table bars_intgr.vw_ref_skrynka_tariff2 is 'Описание ставки тарифа по типу 2';
comment on column bars_intgr.vw_ref_skrynka_tariff2.tariff is 'Код тарифа';
comment on column bars_intgr.vw_ref_skrynka_tariff2.tariff_date is 'Дата введення тарифу';
comment on column bars_intgr.vw_ref_skrynka_tariff2.daysfrom is 'Початок періода в днях';
comment on column bars_intgr.vw_ref_skrynka_tariff2.daysto is 'Кінець періода в днях';
comment on column bars_intgr.vw_ref_skrynka_tariff2.s is 'Сума тарифу';
comment on column bars_intgr.vw_ref_skrynka_tariff2.flag1 is '1 - сума тарифу за 1 календарній день; 2 - сума тарифу за 30 календарних днів';
comment on column bars_intgr.vw_ref_skrynka_tariff2.proc is 'Процент знижки';
comment on column bars_intgr.vw_ref_skrynka_tariff2.peny is 'Денна ставка штрафів';
comment on column bars_intgr.vw_ref_skrynka_tariff2.branch is 'Код відділення';
comment on column bars_intgr.vw_ref_skrynka_tariff2.kf is 'Код филиала';