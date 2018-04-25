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

comment on table bars_intgr.vw_ref_skrynka_tariff is '���� �������';
comment on column bars_intgr.vw_ref_skrynka_tariff.tariff is '��� ������';
comment on column bars_intgr.vw_ref_skrynka_tariff.name is '������������ ������';
comment on column bars_intgr.vw_ref_skrynka_tariff.tip is '��� ������';
comment on column bars_intgr.vw_ref_skrynka_tariff.o_sk is '��� ����� (������)';
comment on column bars_intgr.vw_ref_skrynka_tariff.branch is '��� ���������';
comment on column bars_intgr.vw_ref_skrynka_tariff.basey is '���� ���� 0 - ����������� 1 - 365 ���� 2 - 360';
comment on column bars_intgr.vw_ref_skrynka_tariff.basem is '���� ������ 0 - ����������� (28-31 ����) 1 - 30 ����';
comment on column bars_intgr.vw_ref_skrynka_tariff.kf is '��� �������';