prompt view/vw_ref_ise.sql
create or replace force view bars_intgr.vw_ref_ise as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
ISE, 
cast(t.NAME as varchar2(190)) as "NAME", 
D_CLOSE from bars.ISE t;

comment on table BARS_INTGR.VW_REF_ISE is '���������� �������� ���������';
comment on column BARS_INTGR.VW_REF_ISE.ISE is '��� �������';
comment on column BARS_INTGR.VW_REF_ISE.NAME is '������������';
