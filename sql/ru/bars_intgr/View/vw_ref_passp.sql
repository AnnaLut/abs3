prompt view/vw_ref_passp.sql
create or replace force view bars_intgr.vw_ref_passp as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
PASSP, 
cast(t.NAME as varchar2(250)) as "NAME", 
PSPTYP, 
NRF, 
REZID 
from bars.PASSP t;

comment on table BARS_INTGR.VW_REF_PASSP is '������������� ���������� ���';
comment on column BARS_INTGR.VW_REF_PASSP.PASSP is '���';
comment on column BARS_INTGR.VW_REF_PASSP.NAME is '������������';
comment on column BARS_INTGR.VW_REF_PASSP.PSPTYP is '��� ���������';
comment on column BARS_INTGR.VW_REF_PASSP.NRF is '������ �������� ���������';
comment on column BARS_INTGR.VW_REF_PASSP.REZID is '������������';
