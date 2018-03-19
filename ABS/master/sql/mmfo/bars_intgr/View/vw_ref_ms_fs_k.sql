prompt view/vw_ref_ms_fs_k.sql
create or replace force view bars_intgr.vw_ref_ms_fs_k as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
cast(ID as number(38)) as ID, 
t.NAME 
from bars.MS_FS_K t;

comment on table BARS_INTGR.VW_REF_MS_FS_K is 'Орг-прав. форма клиента';
comment on column BARS_INTGR.VW_REF_MS_FS_K.ID is 'Код';
comment on column BARS_INTGR.VW_REF_MS_FS_K.NAME is 'Наименование';

