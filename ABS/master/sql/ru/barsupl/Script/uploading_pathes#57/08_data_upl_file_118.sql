-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
define sfile_id = 118
define ssql_id  = 118,1118,2118

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
-- ETL-20823 -UPL - выгрузить из АБС в ХД параметры договора/счёта для IFRS9: BUSINESS_MODEL, IFRS_CATEGORY, SPPI, Ринкова ставка (INTRT), Референс реструкт.договору (ND_REST) с соответствующими справочниками
-- выгружать только теги без справочников
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (118, 'with dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
     tg as ( select /*+ materialize */ tag, ref_id from BARSUPL.UPL_TAG_LISTS where tag_table = ''ACC_FIELD'' and coalesce(ref_id, 0) = 0)
select u.acc, bars.gl.kf, u.tag, u.value, u.chgaction
  from BARS.ACCOUNTSW_UPDATE u
 where u.idupd in ( select MAX(u1.idupd)
                      from dt, BARS.ACCOUNTSW_UPDATE u1
                      join tg on ( tg.tag = u1.tag )
                     where u1.effectdate <= dt.dt2
                     group by u1.acc, u1.tag )',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
  NULL, 'Значение доп. реквизитов счета', '3.4');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (1118, 'with dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
     tg as ( select /*+ materialize */ tag, ref_id from BARSUPL.UPL_TAG_LISTS where tag_table = ''ACC_FIELD'' and coalesce(ref_id, 0) = 0)
select u.acc, bars.gl.kf, u.tag, u.value, u.chgaction
  from BARS.ACCOUNTSW_UPDATE u
 where u.idupd in ( select MAX(u1.idupd)
                      from dt, BARS.ACCOUNTSW_UPDATE u1
                      join tg on ( tg.tag = u1.tag )
                     where u1.effectdate between dt.dt1 and dt.dt2
                     group by u1.acc, u1.tag )',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
  NULL, 'Значение доп. реквизитов счета', '3.5');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (2118, 'with dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
   tg_d as ( select /*+ materialize */ tag, ref_id from BARSUPL.UPL_TAG_LISTS where tag_table = ''ACC_FIELD'' and coalesce(ref_id, 0) = 0 and tag not in (''DATEOFKK'', ''INTRT'', ''ND_REST'')),
   tg_f as ( select /*+ materialize */ tag, ref_id from BARSUPL.UPL_TAG_LISTS where tag_table = ''ACC_FIELD'' and coalesce(ref_id, 0) = 0 and tag in (''DATEOFKK'', ''INTRT'', ''ND_REST''))
select u.acc, bars.gl.kf, u.tag, u.value, u.chgaction
  from BARS.ACCOUNTSW_UPDATE u
 where u.idupd in ( select MAX(u1.idupd)
                      from dt, BARS.ACCOUNTSW_UPDATE u1
                      join tg_d on ( tg_d.tag = u1.tag )
                     where u1.effectdate between dt.dt1 and dt.dt2
                     group by u1.acc, u1.tag )
union all
select u.acc, bars.gl.kf, u.tag, u.value, u.chgaction
  from BARS.ACCOUNTSW_UPDATE u
 where u.idupd in ( select MAX(u1.idupd)
                      from dt, BARS.ACCOUNTSW_UPDATE u1
                      join tg_f on ( tg_f.tag = u1.tag )
                     where u1.effectdate <= dt.dt2
                     group by u1.acc, u1.tag )',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
  NULL, 'Значение доп. реквизитов счета (delta+full по тегу)', '1.1');

--declare l_clob clob;
--begin
--l_clob:= to_clob();
--end;
--/

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
