prompt view/vw_ref_cust_mark_types.sql
create or replace force view bars_intgr.vw_ref_cust_mark_types as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
											MARK_CODE, 
											MARK_NAME, 
											NEED_DOCS, 
											OPEN_SELF 
											from bars.CUST_MARK_TYPES t;

comment on table BARS_INTGR.VW_REF_CUST_MARK_TYPES is '������� "��������� ������" �볺��� ��';
comment on column BARS_INTGR.VW_REF_CUST_MARK_TYPES.MARK_CODE is '��� ������';
comment on column BARS_INTGR.VW_REF_CUST_MARK_TYPES.MARK_NAME is '����� ������';
comment on column BARS_INTGR.VW_REF_CUST_MARK_TYPES.NEED_DOCS is '����������� ������� �������������� ��������� ( 1 - ���, 0 - � )';
comment on column BARS_INTGR.VW_REF_CUST_MARK_TYPES.OPEN_SELF is '�볺�� ������� ������� ��������� ( 1 - ���, 0 - � )';

