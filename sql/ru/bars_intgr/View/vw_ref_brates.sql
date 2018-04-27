prompt view/vw_ref_brates.sql
create or replace force view bars_intgr.vw_ref_brates as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
											BR_ID, 
											BR_TYPE, 
											b.NAME, 
											FORMULA, 
											INUSE, 
											b.COMM from bars.BRATES b;

comment on table BARS_INTGR.VW_REF_BRATES is '������� ���������� ������';
comment on column BARS_INTGR.VW_REF_BRATES.BR_ID is '��� ������� ������';
comment on column BARS_INTGR.VW_REF_BRATES.BR_TYPE is '��� ������� ���������� ������';
comment on column BARS_INTGR.VW_REF_BRATES.NAME is '�������� ���������� ������';
comment on column BARS_INTGR.VW_REF_BRATES.FORMULA is 'SQL-������� ��� ���� ������ =4';
comment on column BARS_INTGR.VW_REF_BRATES.INUSE is '1 - ����, 0 - ������';
