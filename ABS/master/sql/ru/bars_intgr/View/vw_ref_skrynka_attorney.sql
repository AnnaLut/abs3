prompt create view bars_intgr.vw_ref_skrynka_attorney
create or replace force view bars_intgr.vw_ref_skrynka_attorney
as
select  nd,
        rnk,
        date_from,
        date_to,
        cancel_date,
        '/'||cast(bars.F_OURMFO_G as varchar2(6)) || '/' branch,
        cast(bars.F_OURMFO_G as varchar2(6)) as kf
from bars.skrynka_attorney t;

comment on table bars_intgr.vw_ref_skrynka_attorney is '������ ����������� �� ��������� ������';
comment on column bars_intgr.vw_ref_skrynka_attorney.nd is '����� ��������';
comment on column bars_intgr.vw_ref_skrynka_attorney.rnk is '����� ������� �����';
comment on column bars_intgr.vw_ref_skrynka_attorney.date_from is '���� �������';
comment on column bars_intgr.vw_ref_skrynka_attorney.date_to is '���� ����������';
comment on column bars_intgr.vw_ref_skrynka_attorney.cancel_date is '���� ������������ ����������';
comment on column bars_intgr.vw_ref_skrynka_attorney.branch is '��� ��������';
comment on column bars_intgr.vw_ref_skrynka_attorney.kf is '��� �������';