-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 237
--define ssql_id  = 237,1237

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 237');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (237))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 237,1237');
end;
/

-- ***************************************************************************
-- TSK-0000806 ANL - анализ выгрузки кредита рассрочка (instalment)
-- COBUINST-14   Вивантаження даних для СД по продукту Instalment
-- новый 'Суб. договора Інстолмент'
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (237,1237);

--declare l_clob clob;
--begin
--l_clob:= to_clob();
--end;
--/

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (237, 'with dt as ( select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
select 23 as ND_TYPE, 4 as CARD_ND_TYPE, p.ND as BPK_ND, p.CONTRACT, p.CHAIN_IDT as ND, p.KF, p.STATUS, p.TOTAL_AMOUNT*100 as TOTAL_AMOUNT,
       p.SUB_INT_RATE, p.SUB_FEE_RATE, p.EFF_RATE, p.TENOR,
       p.POSTING_DATE, p.PAY_B_DATE, p.END_DATE_P, p.END_DATE_F, p.OVD_90_DAYS
  from ( select  t.*, max(t.PLAN_NUM) over (partition by t.CHAIN_IDT) PN
           from bars.ow_inst_totals_hist t, dt
          where t.INS_BD <= dt.dt2
       ) p
 where p.PLAN_NUM = p.PN',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
 NULL, 'Суб. договора Інстолмент', '1.0');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (1237, 'with dt as ( select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
select 23 as ND_TYPE, 4 as CARD_ND_TYPE, p.ND as BPK_ND, p.CONTRACT, p.CHAIN_IDT as ND, p.KF, p.STATUS, p.TOTAL_AMOUNT*100 as TOTAL_AMOUNT,
       p.SUB_INT_RATE, p.SUB_FEE_RATE, p.EFF_RATE, p.TENOR,
       p.POSTING_DATE, p.PAY_B_DATE, p.END_DATE_P, p.END_DATE_F, p.OVD_90_DAYS
  from ( select  t.*, max(t.PLAN_NUM) over (partition by t.CHAIN_IDT) PN
           from bars.ow_inst_totals_hist t, dt
          where t.INS_BD >= dt.dt2
       ) p
 where p.PLAN_NUM = p.PN',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
 NULL, 'Суб. договора Інстолмент', '1.0');

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (237);

Insert into UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id,
    nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (237, 237, 'OW_INST_DEAL', 'ow_inst_deal', 0, '09', NULL, '10', 0, 'Суб. договора Інстолмент', 237, 'null', 'DELTA', 'ARR', 1, NULL, 1, 'AR', 1, 1);


-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (237);

Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (237, 1, 'ND_TYPE', 'Вид угоди', 'NUMBER', 2, 0, NULL, 'Y', 'N', NULL, NULL, '0', 1, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (237, 2, 'CARD_ND_TYPE', 'Вид для БПК угоди', 'NUMBER', 2, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (237, 3, 'BPK_ND', 'Внутрішній код карткової угоди', 'NUMBER', 22, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (237, 4, 'CONTRACT', 'ID контракта', 'NUMBER', 22, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (237, 5, 'ND', 'ID первоначального графика погашения', 'NUMBER', 22, 0, NULL, 'Y', 'N', NULL, NULL, '0', 2, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (237, 6, 'KF', 'Код філії', 'CHAR', 6, NULL, NULL, 'Y', 'N', NULL, NULL, '-', 3, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (237, 7, 'STATUS', 'Статус', 'VARCHAR2', 30, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (237, 8, 'TOTAL_AMOUNT', 'Загальна сума (коп)', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (237, 9, 'SUB_INT_RATE', '% ставка', 'NUMBER', 22, 12, '999999999990D009999999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (237, 10, 'SUB_FEE_RATE', 'Комісія', 'NUMBER', 22, 12, '999999999990D009999999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (237, 11, 'EFF_RATE', 'Еффективна % ставка', 'NUMBER', 22, 12, '999999999990D009999999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (237, 12, 'TENOR', 'Кількість порцій', 'NUMBER', 22, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (237, 13, 'POSTING_DATE', 'Банківська дата оплати в ПЦ', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31/12/9999', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (237, 14, 'PAY_B_DATE', 'Банківська дата оплати в АБС', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31/12/9999', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (237, 15, 'END_DATE_P', 'Планова дата закриття субдоговору', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31/12/9999', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (237, 16, 'END_DATE_F', 'Фактична дата закриття субдоговору', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31/12/9999', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (237, 17, 'OVD_90_DAYS', 'Дата визнання договору проблемним', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31/12/9999', NULL, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (237);

Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (237, 'owinstdl(STATUS)_$_owinststatus(SID)', 1, 240);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (237, 'owinstdl(CARD_ND_TYPE,BPK_ND,KF)_$_cards(TYPE,ND,KF)', 1, 241);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (237);

Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (237, 'owinstdl(STATUS)_$_owinststatus(SID)', 1, 'STATUS');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (237, 'owinstdl(CARD_ND_TYPE,BPK_ND,KF)_$_cards(TYPE,ND,KF)', 1, 'CARD_ND_TYPE');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (237, 'owinstdl(CARD_ND_TYPE,BPK_ND,KF)_$_cards(TYPE,ND,KF)', 2, 'BPK_ND');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (237, 'owinstdl(CARD_ND_TYPE,BPK_ND,KF)_$_cards(TYPE,ND,KF)', 3, 'KF');

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (237);

Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (1, 237,  237);
Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (2, 237, 1237);
Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (3, 237,  237);
Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (4, 237, 1237);


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
