prompt view/vw_ref_crisk.sql
create or replace force view bars_intgr.vw_ref_crisk as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
											CRISK, 
											c.NAME, 
											REZ, 
											REZ2, 
											REZ3, 
											REZ4, 
											REZ5 
from bars.CRISK c;

comment on table BARS_INTGR.VW_REF_CRISK is 'Категория риска';
comment on column BARS_INTGR.VW_REF_CRISK.CRISK is 'Категория риска';
comment on column BARS_INTGR.VW_REF_CRISK.NAME is 'Наименование';
comment on column BARS_INTGR.VW_REF_CRISK.REZ is 'Коэффициент резервирования крединтных операций в ин.вал. для клиентов имеющих источников валютной выручки';
comment on column BARS_INTGR.VW_REF_CRISK.REZ2 is 'Коэффициент резервирования крединтных операций в ин.вал. для клиентов не имеющих источников валютной выручки';
comment on column BARS_INTGR.VW_REF_CRISK.REZ3 is 'процент резервирования для валютных кредитов у которых есть источниками валютной выручки ';
comment on column BARS_INTGR.VW_REF_CRISK.REZ4 is 'процент резервирования для портфеля однородных кредитов';
