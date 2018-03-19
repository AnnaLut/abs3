prompt view/vw_ref_rang.sql
create or replace force view bars_intgr.vw_ref_rang as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
RANG, 
t.NAME 
from bars.rang t;

comment on table BARS_INTGR.VW_REF_RANG is 'Виды блокировок счетов';
comment on column BARS_INTGR.VW_REF_RANG.RANG is 'Код';
comment on column BARS_INTGR.VW_REF_RANG.NAME is 'Наименование';
