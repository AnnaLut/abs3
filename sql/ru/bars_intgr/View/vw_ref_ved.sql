prompt view/vw_ref_ved.sql
create or replace force view bars_intgr.vw_ref_ved as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
VED, 
t.NAME, 
OELIST, 
D_CLOSE 
from bars.VED t;

comment on table BARS_INTGR.VW_REF_VED is '��� ������������� ������������';
comment on column BARS_INTGR.VW_REF_VED.VED is '���';
comment on column BARS_INTGR.VW_REF_VED.NAME is '������������';
comment on column BARS_INTGR.VW_REF_VED.D_CLOSE is '���� ��������';
