prompt create view bars_intgr.vw_ref_skrynka_menu
create or replace force view bars_intgr.vw_ref_skrynka_menu
as
select  item,
        name,
        type,
        datename1,
        datename2,
        tt,
        sk,
        tt2,
        tt3,
        vob,
        vob2,
        vob3,
        numparname,
        branch,
        kf,
        strparname
from bars.skrynka_menu t;

comment on table bars_intgr.vw_ref_skrynka_menu is 'Операції сейфів';
comment on column bars_intgr.vw_ref_skrynka_menu.ITEM is 'Код операции';
comment on column bars_intgr.vw_ref_skrynka_menu.NAME is 'Наименование операции';
comment on column bars_intgr.vw_ref_skrynka_menu.TYPE is 'Тип операции';
comment on column bars_intgr.vw_ref_skrynka_menu.DATENAME1 is 'Входящий параметр: Дата С';
comment on column bars_intgr.vw_ref_skrynka_menu.DATENAME2 is 'Входящий параметр: Дата По';
comment on column bars_intgr.vw_ref_skrynka_menu.TT is 'Код операции';
comment on column bars_intgr.vw_ref_skrynka_menu.SK is 'Символ касcы';
comment on column bars_intgr.vw_ref_skrynka_menu.TT2 is 'Код операции';
comment on column bars_intgr.vw_ref_skrynka_menu.TT3 is 'Код операции';
comment on column bars_intgr.vw_ref_skrynka_menu.VOB is 'ИД квитанции';
comment on column bars_intgr.vw_ref_skrynka_menu.VOB2 is 'ИД квитанции';
comment on column bars_intgr.vw_ref_skrynka_menu.VOB3 is 'ИД квитанции';
comment on column bars_intgr.vw_ref_skrynka_menu.NUMPARNAME is 'Входящий параметр';
comment on column bars_intgr.vw_ref_skrynka_menu.BRANCH is 'Код отделения';
comment on column bars_intgr.vw_ref_skrynka_menu.KF is 'Код филиала';
comment on column bars_intgr.vw_ref_skrynka_menu.STRPARNAME is 'Регистрациионный номер договора (для пролонгации)';
