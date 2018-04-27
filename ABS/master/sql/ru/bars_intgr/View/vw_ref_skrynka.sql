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

comment on table bars_intgr.vw_ref_skrynka is '������ ������';
comment on column bars_intgr.vw_ref_skrynka.o_sk is '��� �����';
comment on column bars_intgr.vw_ref_skrynka.n_sk is '����� ����� (��������� ��������)';
comment on column bars_intgr.vw_ref_skrynka.snum is '����� ����� (���������� ��� ����������)';
comment on column bars_intgr.vw_ref_skrynka.keyused is '���� - ������� ���� ����� = 1, �� ����� = 0';
comment on column bars_intgr.vw_ref_skrynka.isp_mo is '����������� ������������� �� ���� ����';
comment on column bars_intgr.vw_ref_skrynka.keynumber is '����� �����';
comment on column bars_intgr.vw_ref_skrynka.branch is '��� ��������';
comment on column bars_intgr.vw_ref_skrynka.kf is '��� �������';