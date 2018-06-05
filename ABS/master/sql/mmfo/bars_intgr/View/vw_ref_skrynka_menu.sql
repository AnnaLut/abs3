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

comment on table bars_intgr.vw_ref_skrynka_menu is '�������� ������';
comment on column bars_intgr.vw_ref_skrynka_menu.ITEM is '��� ��������';
comment on column bars_intgr.vw_ref_skrynka_menu.NAME is '������������ ��������';
comment on column bars_intgr.vw_ref_skrynka_menu.TYPE is '��� ��������';
comment on column bars_intgr.vw_ref_skrynka_menu.DATENAME1 is '�������� ��������: ���� �';
comment on column bars_intgr.vw_ref_skrynka_menu.DATENAME2 is '�������� ��������: ���� ��';
comment on column bars_intgr.vw_ref_skrynka_menu.TT is '��� ��������';
comment on column bars_intgr.vw_ref_skrynka_menu.SK is '������ ���c�';
comment on column bars_intgr.vw_ref_skrynka_menu.TT2 is '��� ��������';
comment on column bars_intgr.vw_ref_skrynka_menu.TT3 is '��� ��������';
comment on column bars_intgr.vw_ref_skrynka_menu.VOB is '�� ���������';
comment on column bars_intgr.vw_ref_skrynka_menu.VOB2 is '�� ���������';
comment on column bars_intgr.vw_ref_skrynka_menu.VOB3 is '�� ���������';
comment on column bars_intgr.vw_ref_skrynka_menu.NUMPARNAME is '�������� ��������';
comment on column bars_intgr.vw_ref_skrynka_menu.BRANCH is '��� ���������';
comment on column bars_intgr.vw_ref_skrynka_menu.KF is '��� �������';
comment on column bars_intgr.vw_ref_skrynka_menu.STRPARNAME is '���������������� ����� �������� (��� �����������)';
