-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 544
--define ssql_id  = 544

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 544');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (544))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 544');
end;
/
-- ***************************************************************************
-- ETL-19913 ANL - АНАЛИЗ ИЗМЕНЕНИЙ В СВЯЗИ С ВЫДЕЛЕНИЕМ КРЕДИТНЫХ ЛИНИЙ ЮО
-- больше не используется PRVN_FLOW_DEALS_VAR
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (544);

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (544, 'select 3 as ND_TYPE, 13 as PRVN_TP, bars.gl.kf as KF,
       p.ID,   p.ND,   p.FDAT, p.SS,
       p.SPD,  p.SN,   p.SK,   p.LIM1,
       p.LIM2, p.DAT1, p.DAT2, p.SPN,
       p.SNO,  p.SP,   p.SN1,  p.SN2,
       p.MDAT
  from BARS.PRVN_FLOW_DETAILS   p
/*  join BARS.PRVN_FLOW_DEALS_VAR v
    on ( v.ID = p.ID and v.ZDAT = p.MDAT )*/
 where to_date(:param1,''dd/mm/yyyy'') = BARS.DAT_NEXT_U(last_day(to_date(:param1,''dd/mm/yyyy''))+1,-1)
   and p.MDAT = add_months(trunc(to_date(:param1,''dd/mm/yyyy''),''MM''),1)
   and Not ( p.SS  = 0 and p.SPD = 0 and p.SN = 0 and p.SK  = 0 and
             p.SPN = 0 and p.SNO = 0 and p.SP = 0 and p.SN1 = 0 and p.SN2 = 0 )
/*   and ( v.VIDD in ( 1, 2, 3, 11, 12, 13 )
         or
         vidd between 1500 and 1599 )*/',
'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
 NULL, 'Таблиця грош.потоків КД-угод для сховища', '1.7');


--declare l_clob clob;
--begin
--l_clob:= to_clob();
--end;
--/

-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (544);

-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (544);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (544);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (544);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (544);

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
