prompt view/vw_ref_ise.sql
create or replace force view bars_intgr.vw_ref_ise as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
ISE, 
t.NAME, 
D_CLOSE from bars.ISE t;

comment on table BARS_INTGR.VW_REF_ISE is 'Справочник секторов экономики';
comment on column BARS_INTGR.VW_REF_ISE.ISE is 'Код сектора';
comment on column BARS_INTGR.VW_REF_ISE.NAME is 'Наименование';
