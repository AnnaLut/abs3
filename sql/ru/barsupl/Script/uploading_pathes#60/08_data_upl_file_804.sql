-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 804
--define ssql_id  = 804

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 804');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (804))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 804');
end;
/

-- ***************************************************************************
-- ETL-15759 - upl - АВТОТЕСТЫ
-- ETL-23257 - UPL - проверка изменения структур в АБС
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (804);
declare 
    cl1 clob;
    cl2 clob;
begin
cl1:=to_clob('with tbl as (select s.OWNER, s.OBJECT_NAME from barsupl.UPL_SOURCES s where s.OBJECT_TYPE in (''TABLE'', ''VIEW'') and s.CHECKED = ''Y'' )
select bars.gl.kf, acol.OWNER, acol.TABLE_NAME, acol.COLUMN_NAME, acol.COLUMN_ID, acol.DATA_TYPE, acol.DATA_LENGTH, acol.DATA_PRECISION, acol.NULLABLE
  from (select atc.OWNER, atc.TABLE_NAME, atc.COLUMN_NAME, atc.COLUMN_ID, atc.DATA_TYPE, atc.DATA_LENGTH, atc.DATA_PRECISION, atc.NULLABLE
          from sys.ALL_TAB_COLUMNS atc join tbl on (ATC.OWNER = tbl.OWNER and ATC.TABLE_NAME = tbl.OBJECT_NAME )
        ) acol
  full outer join
        (select *
           from ( select fie.*, rank() over (partition by fie.OWNER, fie.TABLE_NAME, fie.COLUMN_NAME order by DATE_VER desc) as rn
                    from barsupl.UPL_SOURCES_FIELDS fie
                    join tbl on (fie.OWNER = tbl.OWNER and fie.TABLE_NAME = tbl.OBJECT_NAME and fie.UPL_BANKDATE < to_date(:param1, ''dd/mm/yyyy'')) )
          where rn = 1
        )fl
    on (fl.OWNER = acol.OWNER and fl.TABLE_NAME= acol.TABLE_NAME and fl.COLUMN_NAME = acol.COLUMN_NAME)
 where decode(acol.COLUMN_ID, fl.COLUMN_ID,1,0)=0  or
       decode(acol.DATA_TYPE, fl.DATA_TYPE,1,0)=0  or
       decode(acol.DATA_LENGTH, fl.DATA_LENGTH,1,0)=0 or
       decode(acol.DATA_PRECISION, fl.DATA_PRECISION,1,0)=0 or
       decode(acol.NULLABLE, fl.NULLABLE,1,0)=0');

cl2:=to_clob('begin
       insert into barsupl.UPL_SOURCES_FIELDS (OWNER, TABLE_NAME, COLUMN_NAME, COLUMN_ID, DATA_TYPE, DATA_LENGTH, DATA_PRECISION, NULLABLE, UPL_BANKDATE, DATE_VER)
       with tbl as (select s.OWNER, s.OBJECT_NAME from barsupl.UPL_SOURCES s where s.OBJECT_TYPE in (''TABLE'', ''VIEW'') and s.CHECKED = ''Y'' )
       select acol.OWNER, acol.TABLE_NAME, acol.COLUMN_NAME, acol.COLUMN_ID, acol.DATA_TYPE, acol.DATA_LENGTH, acol.DATA_PRECISION, acol.NULLABLE, to_date(:param1, ''dd/mm/yyyy''), sysdate
         from (select atc.OWNER, atc.TABLE_NAME, atc.COLUMN_NAME, atc.COLUMN_ID, atc.DATA_TYPE, atc.DATA_LENGTH, atc.DATA_PRECISION, atc.NULLABLE
                 from sys.ALL_TAB_COLUMNS atc join tbl on (ATC.OWNER = tbl.OWNER and ATC.TABLE_NAME = tbl.OBJECT_NAME )
               ) acol
         full outer join
               (select *
                  from ( select fie.*, rank() over (partition by fie.OWNER, fie.TABLE_NAME, fie.COLUMN_NAME order by DATE_VER desc) as rn
                           from barsupl.UPL_SOURCES_FIELDS fie
                           join tbl on (fie.OWNER = tbl.OWNER and fie.TABLE_NAME = tbl.OBJECT_NAME and fie.UPL_BANKDATE < to_date(:param1, ''dd/mm/yyyy'')) )
                 where rn = 1
               )fl
           on (fl.OWNER = acol.OWNER and fl.TABLE_NAME= acol.TABLE_NAME and fl.COLUMN_NAME = acol.COLUMN_NAME)
        where decode(acol.COLUMN_ID, fl.COLUMN_ID,1,0)=0  or
              decode(acol.DATA_TYPE, fl.DATA_TYPE,1,0)=0  or
              decode(acol.DATA_LENGTH, fl.DATA_LENGTH,1,0)=0 or
              decode(acol.DATA_PRECISION, fl.DATA_PRECISION,1,0)=0 or
              decode(acol.NULLABLE, fl.NULLABLE,1,0)=0;
       commit;
exception
  when dup_val_on_index then rollback;
end;');

      Insert into BARSUPL.UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
       Values (804, cl1, NULL, cl2, 'Перевірка змін структури таблиць', '1.0');
end;
/

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (804);

Insert into BARSUPL.UPL_FILES  (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, 
                                ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values   (804, 804, 'CHNG_TAB', 'chngtab', 0, '09', NULL, '10', 0, 'Перевірка змін структури таблиць', 804, 'null', 'WHOLE', 'EVENT', 1, NULL, 1, 'chngtab', 0, 1);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (804);

Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (804, 0, 'KF', 'Код фiлiалу (МФО)', 'VARCHAR2', 6, NULL, NULL, 'Y', 'N', NULL, NULL, NULL, 4, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (804, 1, 'OWNER' , 'Схема объекта БД', 'VARCHAR2', 30, NULL, NULL,  'Y', 'N', NULL, NULL, NULL, 1, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (804, 2, 'TABLE_NAME' , 'Имя таблицы', 'VARCHAR2', 30, NULL, NULL,  'Y', 'N', NULL, NULL, NULL, 2, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (804, 3, 'COLUMN_NAME' , 'Имя колонки','VARCHAR2', 30, NULL, NULL, 'Y',  'N', NULL, NULL, NULL, 3, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (804, 4, 'COLUMN_ID' , 'Номер колонки', 'NUMBER', 10, 0, NULL, NULL,   'N', NULL, NULL, 0, NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (804, 5, 'DATA_TYPE' , 'Тип поля', 'VARCHAR2',   106, NULL, NULL, NULL, 'N', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (804, 6, 'DATA_LENGTH' , 'Длина поля', 'NUMBER', 8,  0, NULL, NULL,  'N', NULL, NULL, 0, NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (804, 7, 'DATA_PRECISION' , 'DATA_PRECISION', 'NUMBER', 8, 0, NULL, NULL, 'N', NULL, NULL, 0, NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (804, 8, 'NULLABLE' , 'Пустое значение', 'VARCHAR2', 1, NULL, NULL, NULL, 'N', NULL, NULL, 'N/A', NULL, NULL);


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
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (804);

Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values   (80, 804,  804);


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