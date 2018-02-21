-- ***************************************************************************
set verify off
set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
define sfile_id = 548
define ssql_id  = 548

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
-- ETL-22190 UPL - upload new table in MIR-scheme (таблица миграции субдоговров по КЛ)
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

declare l_clob        clob;
        l_clob_before clob;
begin
l_clob:= to_clob('select 3 as ND_TYPE, 13 as PRVN_TP, c.KF,
       c.ID,    c.ND,   c.NDO,   c.ACC,   c.KV, c.VIDD,
       c.SDATE, c.TIP,   c.KV8,  c.ACC8,  c.DATE_CLOSE
  from BARSUPL.TMP_PRVN_DEALS_CONST_NDO n
  join BARS.PRVN_FLOW_DEALS_CONST c on (n.id = c.id)');

l_clob_before:= to_clob('declare
  l_ndg_cnt number;
  l_stmt    varchar2(500);
begin
  -- пока поля PRVN_FLOW_DEALS_CONST.NDO нет в таблице, используем TEMPORARY TABLE для выгрузки
  barsupl.bars_upload_usr.tuda;

  begin
      l_stmt := ''CREATE GLOBAL TEMPORARY TABLE BARSUPL.TMP_PRVN_DEALS_CONST_NDO
                    ( ID          NUMBER,
                      ND          NUMBER,
                      NDO         NUMBER,
                      KF          VARCHAR2(6)
                    ) ON COMMIT PRESERVE ROWS'';
      execute immediate l_stmt;
  exception
    when others then
         if sqlcode = -955 then
          l_stmt := ''truncate table BARSUPL.TMP_PRVN_DEALS_CONST_NDO'';
          execute immediate l_stmt;
          null;
         else raise;
         end if;
  end;

  select count(*)
    into l_ndg_cnt
    from all_TAB_COLS
   where owner = ''BARS''
     and table_name = ''PRVN_FLOW_DEALS_CONST''
     and COLUMN_NAME = ''NDO'';

  if l_ndg_cnt > 0 then
     l_stmt := ''insert into BARSUPL.TMP_PRVN_DEALS_CONST_NDO select id, nd, ndo, kf from bars.PRVN_FLOW_DEALS_CONST where ndo is not null'';
     execute immediate l_stmt;
     commit;
  end if;

end;');

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values   (548, l_clob, l_clob_before, NULL, 'Таблица связей идентификаторов КД после разделения', '1.0');

end;
/

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (&&sfile_id);

Insert into BARSUPL.UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, 
    order_id, nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (548, 548, 'PRVN_DEALS_KL', 'prvn_deals_kl', 0, '09', NULL, '10', 0, 'Таблица связей идентификаторов КД после разделения', 548, 'null', 'WHOLE', 'ARR', 1, NULL, 1, 'AR', 0, 1);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (&&sfile_id);

Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (548, 1, 'ND_TYPE', 'Тип договора', 'NUMBER', 2, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (548, 2, 'PRVN_TP', 'Тип "суб.договора"', 'NUMBER', 2, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (548, 3, 'KF', 'Код філіалу', 'CHAR', 6, NULL, NULL, NULL, 'N', NULL, NULL, '-', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (548, 4, 'ID', 'Ід в табл prvn_flow_deals_const', 'NUMBER', 38, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (548, 5, 'ND', 'Реф КД АБС', 'NUMBER', 15, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (548, 6, 'NDO', 'Реф Ген. КД АБС', 'NUMBER', 15, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (548, 7, 'ACC', 'АСС норм тіла(рах)', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (548, 8, 'KV', 'код вал рах.', 'NUMBER', 3, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (548, 9, 'VIDD', 'Вид КД', 'NUMBER', 5, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (548, 10, 'SDATE', 'Дата початку', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31/12/9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (548, 11, 'TIP', NULL, 'CHAR', 3, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (548, 12, 'KV8', 'код вал КД', 'NUMBER', 3, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (548, 13, 'ACC8', 'АССС тіла(КД)', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (548, 14, 'DATE_CLOSE', 'Дата закриття договору', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31/12/9999', NULL, NULL);

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
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (&&sfile_id);

Insert into BARSUPL.UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (1, 548, 548);
Insert into BARSUPL.UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (2, 548, 548);
Insert into BARSUPL.UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (3, 548, 548);
Insert into BARSUPL.UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (4, 548, 548);

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
