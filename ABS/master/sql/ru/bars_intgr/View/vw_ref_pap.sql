prompt view/vw_ref_pap.sql
create or replace force view bars_intgr.vw_ref_pap as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
PAP, 
t.NAME 
from bars.PAP t;

comment on table BARS_INTGR.VW_REF_PAP is '������� ����� - �����/������/���-���';
comment on column BARS_INTGR.VW_REF_PAP.PAP is '�������';
comment on column BARS_INTGR.VW_REF_PAP.NAME is '������������';
