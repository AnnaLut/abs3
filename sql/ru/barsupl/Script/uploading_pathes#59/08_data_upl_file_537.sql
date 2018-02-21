-- ***************************************************************************
set verify off
set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
define sfile_id = 537
define ssql_id  = 537

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
-- ETL-22622  UPL - изменить условия выгрузки файла MIR.SRC_ACNTADJBAL0 и MIR.SRC_PRFTADJTXN0 для чайлдов ЦБ
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

declare l_clob clob; l_clob1 clob;
begin
l_clob  := to_clob('select BARS.GL.KF, b.ACC,
       b.OST  - b.CRDOS  + b.CRKOS  as OST_COR,
       b.OSTQ - b.CRDOSQ + b.CRKOSQ as OST_COR_UAH
  from BARS.AGG_MONBALS b
  join BARS.ACCOUNTS    a
    on ( a.acc = b.acc )
  join BARSUPL.T0_NBS_LIST l
    on ( (l.nbs = a.nbs or a.nls like l.nbs || ''%'') AND nvl(a.OB22,''XX'') like l.OB22 )
 where b.fdat = add_months(trunc(to_date(:param1,''dd/mm/yyyy''),''MM''),-1)
   and ( b.CRDOS <> 0 or b.CRKOS <> 0 )
   and a.daos < trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
   and ( a.dazs is null or a.dazs >= trunc(to_date(:param1,''dd/mm/yyyy''),''MM'') )');
l_clob1 := to_clob('declare
  l_report_date    date;  -- звітна дата
begin
  BARSUPL.bars_upload_usr.tuda;
  l_report_date := trunc(to_date(:param1,''dd/mm/yyyy''),''MM'');
  -- Формування резервів по НБУ23 у відкладеному режимі
  BARSUPL.CALCULATE_PROVISION( l_report_date, bars.gl.kf );
end;');

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values (537, l_clob, l_clob1, NULL, 'Залишки рахунків змінені коригуючими документами (для FineVare)', '1.8');

end;
/

-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (&&sfile_id);

-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (&&sfile_id);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (&&sfile_id);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (&&sfile_id);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (&&sfile_id);

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
