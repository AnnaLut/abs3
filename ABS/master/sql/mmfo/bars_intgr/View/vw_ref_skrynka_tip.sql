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

comment on table bars_intgr.vw_ref_skrynka_tip is '���� ���������� ������';
comment on column bars_intgr.vw_ref_skrynka_tip.o_sk is '��� ���� ����� (�������)';
comment on column bars_intgr.vw_ref_skrynka_tip.name is '������������ ���� �����';
comment on column bars_intgr.vw_ref_skrynka_tip.s is '��������� ��������� �� ���� � ������� (������� ����� - �������)';
comment on column bars_intgr.vw_ref_skrynka_tip.branch is '��� ���������';
comment on column bars_intgr.vw_ref_skrynka_tip.kf is '��� �������';