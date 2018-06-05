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

comment on table bars_intgr.vw_ref_skrynka_tariff2 is '�������� ������ ������ �� ���� 2';
comment on column bars_intgr.vw_ref_skrynka_tariff2.tariff is '��� ������';
comment on column bars_intgr.vw_ref_skrynka_tariff2.tariff_date is '���� �������� ������';
comment on column bars_intgr.vw_ref_skrynka_tariff2.daysfrom is '������� ������ � ����';
comment on column bars_intgr.vw_ref_skrynka_tariff2.daysto is 'ʳ���� ������ � ����';
comment on column bars_intgr.vw_ref_skrynka_tariff2.s is '���� ������';
comment on column bars_intgr.vw_ref_skrynka_tariff2.flag1 is '1 - ���� ������ �� 1 ���������� ����; 2 - ���� ������ �� 30 ����������� ���';
comment on column bars_intgr.vw_ref_skrynka_tariff2.proc is '������� ������';
comment on column bars_intgr.vw_ref_skrynka_tariff2.peny is '����� ������ �������';
comment on column bars_intgr.vw_ref_skrynka_tariff2.branch is '��� ��������';
comment on column bars_intgr.vw_ref_skrynka_tariff2.kf is '��� �������';