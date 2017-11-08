-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов дл€ файла выгрузки (список через зап€тую)
define sfile_id = 118
define ssql_id  = 118,1118,2118,6118

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
-- ƒл€ исправлени€ данных необходим initial по следующим файлам:
-- 1. accvals в части тега "DATEOFKK";
-- 2. deposits (исправление признака онлайн депозитов).
-- 3. collatndn (для тестирования качества данных)
-- 4. collatndo (для тестирования качества данных)
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

Insert into UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (118, 'select u.acc, bars.gl.kf, u.tag, u.value, u.chgaction
  from BARS.ACCOUNTSW_UPDATE u
 where u.idupd in ( select MAX(u1.idupd)
                      from BARS.ACCOUNTSW_UPDATE u1
                      join BARSUPL.UPL_TAG_LISTS tl on ( tl.tag = u1.tag )
                     where u1.effectdate <= TO_DATE(:param1, ''dd/mm/yyyy'')
                       and tl.tag_table = ''ACC_FIELD''
                     group by u1.acc, u1.tag )',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL,
 '«начение доп. реквизитов счета', '3.3');

Insert into UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (1118, 'select u.acc, bars.gl.kf, u.tag, u.value, u.chgaction
  from BARS.ACCOUNTSW_UPDATE u
 where u.idupd in ( select MAX(u1.idupd)
                      from BARS.ACCOUNTSW_UPDATE u1
                      join BARSUPL.UPL_TAG_LISTS tl on ( tl.tag = u1.tag )
                     where u1.effectdate between bars_upload_usr.get_last_work_date(to_date(:param1,''dd/mm/yyyy'')) + 1
                                             and to_date(:param1, ''dd/mm/yyyy'')
                       and tl.tag_table = ''ACC_FIELD''
                     group by u1.acc, u1.tag )',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL,
 '«начение доп. реквизитов счета', '3.4');

Insert into UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (2118, 'select u.acc, bars.gl.kf, u.tag, u.value, u.chgaction
  from BARS.ACCOUNTSW_UPDATE u
 where u.idupd in ( select MAX(u1.idupd)
                      from BARS.ACCOUNTSW_UPDATE u1
                      join BARSUPL.UPL_TAG_LISTS tl on ( tl.tag = u1.tag )
                     where u1.effectdate between bars_upload_usr.get_last_work_date(to_date(:param1,''dd/mm/yyyy'')) + 1
                                             and to_date(:param1, ''dd/mm/yyyy'')
                       and tl.tag_table = ''ACC_FIELD''
                       and tl.tag <> ''DATEOFKK''
                     group by u1.acc, u1.tag )
union all
select u.acc, bars.gl.kf, u.tag, u.value, u.chgaction
  from BARS.ACCOUNTSW_UPDATE u
 where u.idupd in ( select MAX(u1.idupd)
                      from BARS.ACCOUNTSW_UPDATE u1
                      join BARSUPL.UPL_TAG_LISTS tl on ( tl.tag = u1.tag )
                     where u1.effectdate <= TO_DATE(:param1, ''dd/mm/yyyy'')
                       and tl.tag_table = ''ACC_FIELD''
                       and tl.tag = ''DATEOFKK''
                     group by u1.acc, u1.tag )',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL,
 '«начение доп. реквизитов счета (delta+full по тегу)', '1.0');



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
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (&&sfile_id);

Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (1, 118, 118);
Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (2, 118, 1118);
Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (3, 118, 118);
Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (4, 118, 1118);



