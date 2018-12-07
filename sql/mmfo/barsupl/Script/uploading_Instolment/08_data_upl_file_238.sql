-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 238
--define ssql_id  = 238,1238

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 238');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (238))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 238,1238');
end;
/
-- ***************************************************************************
-- TSK-0000806 ANL - анализ выгрузки кредита рассрочка (instalment)
-- COBUINST-14   Вивантаження даних для СД по продукту Instalment
-- новый 'Графік сплати Інстолмент'
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (238,1238);

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (238, 'with dt as ( select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
     nd as ( select p.CHAIN_IDT, p.KF, p.PLAN_NUM
               from ( select  t.CHAIN_IDT, t.INS_BD, t.KF, t.PLAN_NUM, max(t.PLAN_NUM) over (partition by t.CHAIN_IDT) PN
                        from bars.ow_inst_totals_hist t, dt
                       where t.INS_BD <= dt.dt2
                    ) p
              where p.PLAN_NUM = p.PN)
select 23 as ND_TYPE, pr.CHAIN_IDT as ND, pr.KF, pr.SEQ_NUMBER as IDP, pr.STATUS, pr.EFF_DATE, pr.DUE_DATE, pr.REP_DATE,
       pr.TOTAL_AMOUNT*100 as TOTAL_AMOUNT, sph.FEE*100 as FEE, sph.INT*100 as INT, sph.PRINCIPAL*100 as PRINCIPAL
  from ( select KF, CHAIN_IDT, IDP, FEE, INT, PRINCIPAL
           from (select sp.KF, sp.CHAIN_IDT, sp.IDP, sp.CODE, sp.TOTAL_AMOUNT
                   from bars.ow_inst_sub_p_hist sp, nd
                  where sp.CHAIN_IDT = nd.CHAIN_IDT
                    and sp.PLAN_NUM = nd.PLAN_NUM
                 ) pivot (sum(TOTAL_AMOUNT) for CODE in (''FEE'' as FEE, ''INT'' as INT, ''PRINCIPAL'' as PRINCIPAL))) sph
  left join bars.ow_inst_portions pr on (sph.CHAIN_IDT = pr.CHAIN_IDT and sph.IDP = pr.SEQ_NUMBER and sph.KF = pr.KF)',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Графік сплати Інстолмент', '1.0');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (1238, 'with dt as ( select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
     nd as ( select p.CHAIN_IDT, p.KF, p.PLAN_NUM
               from ( select  t.CHAIN_IDT, t.INS_BD, t.KF, t.PLAN_NUM, max(t.PLAN_NUM) over (partition by t.CHAIN_IDT) PN
                        from bars.ow_inst_totals_hist t, dt
                       where t.INS_BD >= dt.dt2
                    ) p
              where p.PLAN_NUM = p.PN)
select 23 as ND_TYPE, pr.CHAIN_IDT as ND, pr.KF, pr.SEQ_NUMBER as IDP, pr.STATUS, pr.EFF_DATE, pr.DUE_DATE, pr.REP_DATE,
       pr.TOTAL_AMOUNT*100 as TOTAL_AMOUNT, sph.FEE*100 as FEE, sph.INT*100 as INT, sph.PRINCIPAL*100 as PRINCIPAL
  from ( select KF, CHAIN_IDT, IDP, FEE, INT, PRINCIPAL
           from (select sp.KF, sp.CHAIN_IDT, sp.IDP, sp.CODE, sp.TOTAL_AMOUNT
                   from bars.ow_inst_sub_p_hist sp, nd
                  where sp.CHAIN_IDT = nd.CHAIN_IDT
                    and sp.PLAN_NUM = nd.PLAN_NUM
                 ) pivot (sum(TOTAL_AMOUNT) for CODE in (''FEE'' as FEE, ''INT'' as INT, ''PRINCIPAL'' as PRINCIPAL))) sph
  left join bars.ow_inst_portions pr on (sph.CHAIN_IDT = pr.CHAIN_IDT and sph.IDP = pr.SEQ_NUMBER and sph.KF = pr.KF)',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Графік сплати Інстолмент', '1.0');

--declare l_clob clob;
--begin
--l_clob:= to_clob();
--end;
--/

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (238);

Insert into UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id,
    nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (238, 238, 'OW_INST_SH', 'ow_inst_sh', 0, '09', NULL, '10', 0, 'Графік сплати Інстолмент', 238, 'null', 'DELTA', 'EVENT', 1, NULL, 1, 'owinstshedule', 1, 1);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (238);

Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (238, 1, 'ND_TYPE', 'Вид угоди', 'NUMBER', 2, 0, NULL, 'Y', 'N', NULL, NULL, '0', 1, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (238, 2, 'ND', 'ID первоначального графика погашения', 'NUMBER', 22, 0, NULL, 'Y', 'N', NULL, NULL, '0', 2, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (238, 3, 'KF', 'Код філії', 'CHAR', 6, NULL, NULL, 'Y', 'N', NULL, NULL, '-', 3, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (238, 4, 'IDP', 'Номер порції', 'NUMBER', 22, 0, NULL, 'Y', 'N', NULL, NULL, '0', 4, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (238, 5, 'STATUS', 'Статус', 'VARCHAR2', 30, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (238, 6, 'EFF_DATE', 'Дата виставления до погашення', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31/12/9999', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (238, 7, 'DUE_DATE', 'Кінцевий термін погашення', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31/12/9999', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (238, 8, 'REP_DATE', 'Дата погашення', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31/12/9999', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (238, 9, 'TOTAL_AMOUNT', 'Загальна сума складової порції', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (238, 10, 'FEE', 'Cума погашення комісії', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (238, 11, 'INT', 'Cума погашення відсотків', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (238, 12, 'PRINCIPAL', 'Cума погашення основного боргу', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);


-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (238);

Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (238, 'owinstshd(STATUS)_$_owinststatus(SID)', 1, 240);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (238, 'owinstshd(ND_TYPE,ND,KF)_$_owinstdl(ND_TYPE,ND,KF)', 1, 237);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (238);

Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (238, 'owinstshd(STATUS)_$_owinststatus(SID)', 1, 'STATUS');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (238, 'owinstshd(ND_TYPE,ND,KF)_$_owinstdl(ND_TYPE,ND,KF)', 1, 'ND_TYPE');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (238, 'owinstshd(ND_TYPE,ND,KF)_$_owinstdl(ND_TYPE,ND,KF)', 2, 'ND');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (238, 'owinstshd(ND_TYPE,ND,KF)_$_owinstdl(ND_TYPE,ND,KF)', 3, 'KF');

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (238);

Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (1, 238,  238);
Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (2, 238, 1238);
Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (3, 238,  238);
Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (4, 238, 1238);

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
