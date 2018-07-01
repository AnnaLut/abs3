-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 267
--define ssql_id  = 267

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 267');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (267))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 267');
end;
/

-- ***************************************************************************
-- ETL-24571 UPL - добавить в выгрузку файл по месячному снимоку баланса - трансформированному после внедрения IFRS 9
-- COBUMMFO-7942  Просимо додати до вивантаження місячний знімок балансу - трансформованний після впровадження IFRS9. Доопрацювання стосується ММФО і Міленіуму.
--
-- добавлено условие из-за отсутствия политик на таблице
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (267);

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (267, 'select bars.gl.kf as KF, a.FDAT, a.ACC, a.RNK, a.OST, a.DOS, a.KOS, a.OSTQ, a.DOSQ, a.KOSQ,
       a.CRDOS, a.CRDOSQ, a.CRKOS, a.CRKOSQ, a.CUDOS, a.CUDOSQ, a.CUKOS, a.CUKOSQ, a.DOS9, a.DOSQ9, a.KOS9, a.KOSQ9, a.KV
  from BARS.AGG_MONBALS9 a
 where a.FDAT = TO_DATE(:param1,''dd/mm/yyyy'')
   and a.kf = bars.gl.kf', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
 NULL, 'Накопительные балансы за месяц IFRS9', '1.1');

-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (267);

-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (267);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (267);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (267);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (267);

/*
begin
    if  barsupl.bars_upload_utl.is_mmfo > 1 then
         -- ************* MMFO *************
    else
         -- ************* RU *************
    end if;
end;
/
*/
