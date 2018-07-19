-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов дл¤ файла выгрузки (список через зап¤тую, без пробелов)
--define sfile_id = 123
--define ssql_id  = 123, 1123

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 123');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (123))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 123, 1123');
end;
/
-- ***************************************************************************
-- ETL-24936 UPL - выгрузить данные по ЄДДР– (табл. person)
-- 
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (123, 1123);

Insert into BARSUPL.UPL_SQL(SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values(123, 'select p.RNK,
       p.SEX,
       p.BDAY,
       p.PASSP,
       p.NUMDOC,
       p.SER,
       p.PDATE,
       p.TELD,
       p.TELW,
       BARS.GL.KF,
       p.organ,
	     p.eddr_id
  from BARS.PERSON p
  join BARS.CUSTOMER c
    on ( c.RNK = p.RNK AND c.CUSTTYPE = 3 )
', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Клієнти - фізичні особи', '3.5');
	
Insert into BARSUPL.UPL_SQL(SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values (1123, 'with dt as ( select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
     tabc as ( select cu.rnk
                 from bars.customer_update cu, dt
                where global_bdate >= dt.dt1
                  and (effectdate <= dt.dt2 or (effectdate > dt.dt2 and chgaction = 1))
                  and cu.custtype = 3
                group by rnk
             ),
     tabw as (select cwu.rnk
                from bars.customerw_update cwu, dt
                where cwu.chgdate >= dt1
                  and coalesce(cwu.effectdate,cwu.chgdate) < dt2+1
                  and cwu.tag in (select tag
                                    from barsupl.upl_tag_lists l
                                   where l.tag_table = ''CUST_FIELD'')
                group by cwu.rnk
             ),
     tabp as ( select cu.rnk
                 from bars.person_update cu, dt
                where cu.global_bdate >= dt.dt1
                  and (cu.effectdate <= dt.dt2 or (cu.effectdate > dt.dt2 and cu.chgaction = ''I''))
                group by cu.rnk
             ),
        t as (select rnk from tabc union select rnk from tabp union select rnk from tabw)
select u.rnk, u.sex, u.bday, u.passp, u.numdoc, u.ser, u.pdate, u.teld, u.telw, bars.gl.kf, u.organ, u.eddr_id
  from bars.person_update u
 where u.idupd in (select max(cu.idupd)
                     from bars.person_update cu, t, dt
                    where cu.rnk = t.rnk
                      and ( cu.effectdate   <= dt.dt2
                       or ( cu.global_bdate >= dt.dt1 and cu.chgaction = ''I''))
                    group by cu.rnk)', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Клієнти - фізичні особи', '3.7');
--declare l_clob clob;
--begin
--l_clob:= to_clob();
--end;
--/

-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (123);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (123);

Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (123, 1, 'RNK', 'Регистрационный номер клиента', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, NULL, 1, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (123, 2, 'SEX', 'Пол', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', '-', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (123, 3, 'BDAY', 'Дата рождения', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '01.01.0001', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (123, 4, 'PASSP', 'Тип удостоверяющего документа', 'NUMBER', 2, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (123, 5, 'NUMDOC', '№ док', 'CHAR', 20, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (123, 6, 'SER', 'Серия док', 'CHAR', 10, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (123, 7, 'PDATE', 'Дата выдачи док', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '01.01.0001', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (123, 9, 'TELD', 'Домашний телефон', 'CHAR', 20, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', '-', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (123, 10, 'TELW', 'Рабочий телефон', 'CHAR', 20, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', '-', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (123, 11, 'KF', 'Код филиала', 'CHAR', 6, NULL, NULL, 'Y', 'N', NULL, NULL, NULL, 11, NULL);
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (123, 12, 'ORGAN', 'Организация, выдавшая удостоверяющий документ', 'CHAR', 70, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (123, 13, 'EDDR_ID', 'Номер записи в Едином государственном демографическом реестре', 'VARCHAR2', 20, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (123);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (123);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (123);

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
