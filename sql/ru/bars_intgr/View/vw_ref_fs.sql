prompt view/vw_ref_fs.sql
create or replace force view bars_intgr.vw_ref_fs as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
FS, 
t.NAME, 
D_CLOSE from bars.FS t;

comment on table BARS_INTGR.VW_REF_FS is '���������� ���� �������������';
comment on column BARS_INTGR.VW_REF_FS.FS is '��� �����';
comment on column BARS_INTGR.VW_REF_FS.NAME is '������������';
comment on column BARS_INTGR.VW_REF_FS.D_CLOSE is '���� ������ ���������';
