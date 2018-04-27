prompt view/vw_ref_country.sql
create or replace force view bars_intgr.vw_ref_country as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
											COUNTRY, 
											c.NAME, 
											GRP, 
											FATF 
											from bars.COUNTRY c;

comment on table BARS_INTGR.VW_REF_COUNTRY is 'Справочник стран-эмитентов валют';
comment on column BARS_INTGR.VW_REF_COUNTRY.COUNTRY is 'Код страны';
comment on column BARS_INTGR.VW_REF_COUNTRY.NAME is 'Наименование страны';
comment on column BARS_INTGR.VW_REF_COUNTRY.GRP is 'Группа';

