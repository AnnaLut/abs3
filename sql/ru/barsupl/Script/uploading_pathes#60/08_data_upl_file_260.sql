-- ***************************************************************************
-- ETL-23212 - UPL - отключить от загрузки файлы credits, kazna, arracc1 и arracc_mbk
-- 14.03.2018
-- ***************************************************************************

set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 260
--define ssql_id  = 260


begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 260');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (260))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 260');
end;
/

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (260);

Insert into BARSUPL.UPL_FILES
   (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, 
    DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, 
    ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, 
    SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values
   (260, 260, 'ARRACCRLN_MBK', 'arraccrln_mbk', 0, 
    '09', NULL, '10', 0, 'Связь договор-счет для межбанковских договоров', 
    15, 'null', 'DELTA', 'ARR', 0, 
    NULL, 1, 'arraccrln', 1, 1);

	
--COMMIT;

-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (260);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (260);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (260);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (260);

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
