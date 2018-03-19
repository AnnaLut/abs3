prompt view/vw_ref_custtype.sql
create or replace force view bars_intgr.vw_ref_custtype as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
											CUSTTYPE, 
											c.NAME 
											from bars.CUSTTYPE c;

comment on table BARS_INTGR.VW_REF_CUSTTYPE is 'Типы клиентов';
comment on column BARS_INTGR.VW_REF_CUSTTYPE.CUSTTYPE is 'Код типа клиента';
comment on column BARS_INTGR.VW_REF_CUSTTYPE.NAME is 'Тип контрагента';
