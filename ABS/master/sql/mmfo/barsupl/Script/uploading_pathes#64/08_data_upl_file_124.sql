-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 124
--define ssql_id  = 124 1124

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 124');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (124))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 124, 1124');
end;
/
-- ***************************************************************************
-- ETL-25047 UPL - add upload new fields in MIR.SRC_CUSTREL of Customer_reL
-- 
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (124, 1124);

Insert into BARSUPL.UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (124, 'select cr.RNK, cr.REL_ID,
       case when cr.REL_INTEXT = 0 then -cr.REL_RNK else cr.REL_RNK end as REL_RNK,
       cr.REL_INTEXT, cr.TYPE_ID, BARS.GL.KF,
       case cr.CHGACTION
         when 1 then ''I''
         when 2 then ''U''
         when 3 then ''D''
         else to_char(cr.CHGACTION)
       end as CHGACTION,
	   cr.BDATE,
	   cr.EDATE
  from BARS.CUSTOMER_REL_UPDATE cr
 where cr.IDUPD in ( select max(IDUPD)
                       from BARS.CUSTOMER_REL_UPDATE
                      where EFFECTDATE <= to_date(:param1,''dd/mm/yyyy'')
                      group by RNK, REL_ID, REL_RNK, REL_INTEXT )
   and ( ( cr.effectdate < to_date(:param1,''dd/mm/yyyy'') and cr.chgaction <> 3 )
        or cr.effectdate = to_date(:param1,''dd/mm/yyyy'') )', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Лица, имеющие отношение к клиенту', '1.2');

Insert into BARSUPL.UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (1124, 'select cr.RNK, cr.REL_ID,
       case when cr.REL_INTEXT = 0 then -cr.REL_RNK else cr.REL_RNK end as REL_RNK,
       cr.REL_INTEXT, cr.TYPE_ID, BARS.GL.KF,
       case cr.CHGACTION
         when 1 then ''I''
         when 2 then ''U''
         when 3 then ''D''
         else to_char(cr.CHGACTION)
       end as CHGACTION,
	   cr.BDATE,
	   cr.EDATE
  from BARS.CUSTOMER_REL_UPDATE cr
 where cr.IDUPD in ( select max(idupd)
                       from BARS.CUSTOMER_REL_UPDATE
                      where EFFECTDATE between bars_upload_usr.get_last_work_date(to_date(:param1,''dd/mm/yyyy'')) + 1
                                           and to_date(:param1,''dd/mm/yyyy'')
                      group by RNK, REL_ID, REL_RNK, REL_INTEXT )', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Лица, имеющие отношение к клиенту', '1.2');

-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (124);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (124);

Insert into BARSUPL.UPL_COLUMNS(FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (124, 1, 'RNK', 'РНК', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, '0', 2, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS(FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (124, 2, 'REL_ID', 'Код отношения', 'NUMBER', 5, 0, NULL, 'Y', 'N', NULL, NULL, '0', 3, NULL);
Insert into BARSUPL.UPL_COLUMNS(FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (124, 3, 'REL_RNK', 'РНК связанного лица', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, '0', 4, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS(FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (124, 4, 'REL_INTEXT', 'Тип связанного лица (1-клиент банка, 0-НЕклиент банка)', 'NUMBER', 5, 0, NULL, 'Y', 'N', NULL, NULL, '0', 5, NULL);
Insert into BARSUPL.UPL_COLUMNS(FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (124, 7, 'TYPE_ID', 'Идентификатор типа довереного лица', 'NUMBER', 5, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS(FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (124, 8, 'KF', 'Код филиала', 'CHAR', 6, NULL, NULL, 'Y', 'N', NULL, NULL, '-', 1, NULL);
Insert into BARSUPL.UPL_COLUMNS(FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (124, 9, 'CHGACTION', 'Код типу оновлення (I,U,D)', 'CHAR', 1, NULL, NULL, NULL, 'N', NULL, NULL, '-', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS(FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (124, 10, 'BDATE', 'Дата начала действия доверенности', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31/12/9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS(FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (124, 11, 'EDATE', 'Дата окончания действия доверенности', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31/12/9999', NULL, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (124);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (124);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (124);

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
