prompt view/vw_ref_cat_chornobyl.sql
create or replace force view bars_intgr.vw_ref_cat_chornobyl as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
											c.CODE, 
											c.CATEGORY 
											from bars.CAT_CHORNOBYL c;

comment on table BARS_INTGR.VW_REF_CAT_CHORNOBYL is 'Категорія громадян, які постраждали внаслідок Чорнобильської катастрофи';
comment on column BARS_INTGR.VW_REF_CAT_CHORNOBYL.CODE is 'Код';
comment on column BARS_INTGR.VW_REF_CAT_CHORNOBYL.CATEGORY is 'Категорія';

