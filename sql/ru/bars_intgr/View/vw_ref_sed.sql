prompt view/vw_ref_sed.sql
create or replace force view bars_intgr.vw_ref_sed as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
SED, 
t.NAME, 
D_CLOSE 
from bars.SED t;

comment on table BARS_INTGR.VW_REF_SED is '���������� �������� ���������';
comment on column BARS_INTGR.VW_REF_SED.SED is '��� ������� ���������';
comment on column BARS_INTGR.VW_REF_SED.NAME is '������������ ������� ���������';
comment on column BARS_INTGR.VW_REF_SED.D_CLOSE is '���� ������ ���������';
