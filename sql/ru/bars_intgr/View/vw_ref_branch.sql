prompt view/vw_ref_branch.sql
create or replace force view bars_intgr.vw_ref_branch as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
											BRANCH, 
											b.NAME, 
											B040, 
											DESCRIPTION, 
											IDPDR, 
											DATE_OPENED, 
											DATE_CLOSED, 
											DELETED, 
											SAB, 
											OBL from bars.BRANCH b;

comment on table BARS_INTGR.VW_REF_BRANCH is '��������� �����';
comment on column BARS_INTGR.VW_REF_BRANCH.BRANCH is '��� �������������� ���������';
comment on column BARS_INTGR.VW_REF_BRANCH.NAME is '������������ �������������� ���������';
comment on column BARS_INTGR.VW_REF_BRANCH.B040 is '��� ������������� ����� �� ����������� ��� SPR_B040.dbf';
comment on column BARS_INTGR.VW_REF_BRANCH.DESCRIPTION is '�������� �������������';
comment on column BARS_INTGR.VW_REF_BRANCH.IDPDR is '���������� ��. �������������';
comment on column BARS_INTGR.VW_REF_BRANCH.DATE_OPENED is '���� �������� ���������';
comment on column BARS_INTGR.VW_REF_BRANCH.DATE_CLOSED is '���� �������� ������';
