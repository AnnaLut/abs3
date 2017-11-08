-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую)
define sfile_id = 221
define ssql_id  = 6221

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
-- ETL-20206 UPL - initial upload - 99 группа uploading_pathes#56
-- Для исправления данных необходим initial по следующим файлам:
-- 1. accvals в части тега "DATEOFKK";
-- 2. deposits (исправление признака онлайн депозитов).
-- 3. collatndn (для тестирования качества данных)
-- 4. collatndo (для тестирования качества данных)
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);
/* -- 6221-удалить
Insert into UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (6221, 'select 1 type,
       d.DEPOSIT_ID,
       d.VIDD,
       d.ACC,
       d.KV,
       d.RNK,
       d.DAT_BEGIN,
       d.DAT_END,
       d.MFO_P,
       d.LIMIT,
       d.DATZ,
       d.FREQ,
       d.ND,
       d.BRANCH,
       0 STATUS,
       d.ACC_D,
       d.MFO_D,
       d.NMS_D,
       d.STOP_ID,
       d.KF,
       d.USERID,
       v.BSD,
       d.CNT_DUBL,
       w.VALUE as CASHLESS,
       d.ARCHDOC_ID,
       6 as TUP,
       d.WB
  from bars.dpt_deposit_clos d
 inner
  join bars.dpt_vidd v on (v.vidd = d.vidd)
  left
  join bars.dpt_depositw w on (w.dpt_id = d.deposit_id and w.tag = ''NCASH'')
 where d.idupd in ( select MAX(idupd) idupd
                      from bars.dpt_deposit_clos
                     where bdate between to_date(''24/07/2017'', ''dd/mm/yyyy'') and to_date(:param1, ''dd/mm/yyyy'')
                       and kf = bars.gl.kf
                     group by deposit_id )
   and d.kf = bars.gl.kf',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL,
 'Депозитний портфель ФО', '2.0');
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
 -- удалить SQL_ID, если где-то привязан
delete from BARSUPL.UPL_FILEGROUPS_RLN where SQL_ID IN (&&ssql_id);


