prompt create view bars_intgr.vw_ref_skrynka
create or replace force view bars_intgr.vw_ref_skrynka
as
select  o_sk,
        n_sk,
        snum,
        keyused,
        isp_mo,
        keynumber,
        branch,
        kf
from bars.skrynka t;

comment on table bars_intgr.vw_ref_skrynka is 'Перелік сейфів';
comment on column bars_intgr.vw_ref_skrynka.o_sk is 'Вид сейфа';
comment on column bars_intgr.vw_ref_skrynka.n_sk is 'Номер сейфа (системный референс)';
comment on column bars_intgr.vw_ref_skrynka.snum is 'Номер сейфа (символьный для документов)';
comment on column bars_intgr.vw_ref_skrynka.keyused is 'Флаг - признак ключ выдан = 1, не выдан = 0';
comment on column bars_intgr.vw_ref_skrynka.isp_mo is 'Материально ответственное за сейф лицо';
comment on column bars_intgr.vw_ref_skrynka.keynumber is 'Номер ключа';
comment on column bars_intgr.vw_ref_skrynka.branch is 'Код відділення';
comment on column bars_intgr.vw_ref_skrynka.kf is 'Код филиала';