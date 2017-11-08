-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую)
define sfile_id = 252
define ssql_id  = 252,1252,6252

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: &&sfile_id');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (&&sfile_id))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # &&ssql_id');
end;
/
-- ***************************************************************************
-- ETL-20446   UPL - Оптимизация выгрузки uploading_pathes#56
-- DEBITS (252) Угоди бронювання
-- оптимизирован, условия не изменились
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

Insert into UPL_SQL  (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (252, 'with h1 as (select nd, max(idupd) idupd,
                   min(case when sos in (14,15) then effectdate else to_date(''31/12/9999'',''dd/mm/yyyy'') end) as date_close
              from BARS.CC_DEAL_UPDATE cu
             where cu.vidd=26
               and cu.sos >= 10
               and cu.EFFECTDATE <= to_date(:param1,''dd/mm/yyyy'')
             group by nd)
select 19 as arrtype, cc.nd, cc.SOS,
       case h1.date_close when to_date(''31/12/9999'',''dd/mm/yyyy'') then null else h1.date_close end as date_close,
       cc.CC_ID, cc.SDATE, cc.WDATE, cc.RNK, cc.VIDD, cc.LIMIT, cc.BRANCH, cc.KF, cc.IR, cc.PROD, s.KV
from bars.cc_deal_update cc
    join ( select n.nd, a.kv
             from BARS.ND_ACC n, BARS.ACCOUNTS  a
            where n.acc = a.acc
              and a.nls like ''26%''
         ) s on s.nd = cc.nd
    join h1 on cc.idupd=h1.idupd'
    ,
    'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Угоди бронювання', 
    '1.1');

Insert into UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (1252, 'with h1 as (select nd, max(idupd) idupd,
                   min(case when sos in (14,15) then effectdate else to_date(''31/12/9999'',''dd/mm/yyyy'') end) as date_close
              from BARS.CC_DEAL_UPDATE cu
             where cu.vidd=26
               and cu.sos >= 10
               and cu.EFFECTDATE
                    between bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1
                            and to_date(:param1,''dd/mm/yyyy'')
             group by nd)
select 19 as arrtype, cc.nd, cc.SOS,
       case h1.date_close when to_date(''31/12/9999'',''dd/mm/yyyy'') then null else h1.date_close end as date_close,
       cc.CC_ID, cc.SDATE, cc.WDATE, cc.RNK, cc.VIDD, cc.LIMIT, cc.BRANCH, cc.KF, cc.IR, cc.PROD, s.KV
from bars.cc_deal_update cc
    join ( select n.nd, a.kv
             from BARS.ND_ACC n, BARS.ACCOUNTS  a
            where n.acc = a.acc
              and a.nls like ''26%''
         ) s on s.nd = cc.nd
    join h1 on cc.idupd=h1.idupd', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Угоди бронювання', 
    '1.1');

/* --для разовой выгрузки - удалить
Insert into UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (6252, 'select 19 as arrtype, cc.nd, 0 SOS, cast(null as date) date_close, '' '' CC_ID,
    cast(null as date) SDATE, cast(null as date) WDATE, 0 RNK, 0 VIDD, 0 LIMIT,
    '' '' BRANCH, cc.KF, 0 IR, '' '' PROD, 0 KV
from bars.cc_deal cc join bars.cc_vidd v on v.vidd = cc.vidd
where cc.vidd=26 and cc.sos >= 10
    and v.custtype in (2,3) and v.tipd = 2 -- Розміщення (пасив)',
'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL,
'!!! Для перевірки повноти інформації - всі УГОДИ бронювання із оперативної таблиці',
    '1.0');
*/

-- ***********************
-- UPL_FILES
-- ***********************

-- ***********************
-- UPL_COLUMNS
-- ***********************

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************

