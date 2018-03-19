prompt view/vw_ref_prinsider.sql
create or replace force view bars_intgr.vw_ref_prinsider as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
PRINSIDER, 
PRINSIDERLV1, 
t.NAME, 
D_OPEN, 
D_CLOSE 
from bars.PRINSIDER t;

comment on table BARS_INTGR.VW_REF_PRINSIDER is 'Признак инсайдера';
comment on column BARS_INTGR.VW_REF_PRINSIDER.PRINSIDER is 'Признак инсайдера';
comment on column BARS_INTGR.VW_REF_PRINSIDER.PRINSIDERLV1 is 'Пр инсайдера 1-го уровня';
comment on column BARS_INTGR.VW_REF_PRINSIDER.NAME is 'Наименование';
comment on column BARS_INTGR.VW_REF_PRINSIDER.D_OPEN is 'Дата відкриття коду';
comment on column BARS_INTGR.VW_REF_PRINSIDER.D_CLOSE is 'Дата закриття коду';
