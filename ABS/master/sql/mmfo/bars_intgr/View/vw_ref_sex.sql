prompt view/vw_ref_sex.sql
create or replace force view bars_intgr.vw_ref_sex as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
ID, 
t.NAME 
from bars.SEX t;

comment on table BARS_INTGR.VW_REF_SEX is 'Пол';
comment on column BARS_INTGR.VW_REF_SEX.ID is 'Идентификатор пола';
comment on column BARS_INTGR.VW_REF_SEX.NAME is 'Наименование пола';
