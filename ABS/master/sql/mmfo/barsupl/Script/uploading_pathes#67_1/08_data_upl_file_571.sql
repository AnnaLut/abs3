-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 571
--define ssql_id  = 571,1571

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 571');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (571))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 571,1571');
end;
/
-- ***************************************************************************
-- TSK-0001183 ANL - анализ выгрузки депозитных линий ММСБ
-- TSK-0003096 UPL - зробити вивантаження договорів депозитиних ліній (траншів), поточних рахунків та їх параметрів із нового модуля депозитів ММСБ
-- 02_SMD_DEPOSIT_v03
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************

delete from BARSUPL.UPL_SQL where SQL_ID IN (571,1571);

declare l_clob clob;
begin
l_clob:= to_clob('with dt as ( select /*+ materialize */
                    bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1,
                    to_date (:param1, ''dd/mm/yyyy'') dt2,
                    bars.gl.kf
               from dual )
select ss.nd_type,
       ss.nd,
       ss.kf,
       ss.kv,
       ss.deal_number,
       ss.customer_id,
       ss.product_id,
       ss.start_date,
       ss.expiry_date,
       ss.close_date,
       ss.branch,
       ss.curator_id,
       ss.state_id,
       9 as tup,
       translate(ss.process_data, chr(9)||chr(10)||chr(13), ''   '') as process_data
  from ( select o.type_id as nd_type,
                o.object_id as nd,
                o.kf,
                tt.currency_id as kv,
                o.deal_number,
                o.customer_id,
                o.product_id,
                o.start_date,
                o.expiry_date,
                o.close_date,
                o.branch_id as branch,
                o.curator_id,
                o.state_id,
                s.process_data,
                row_number() over (partition by o.object_id order by s.id desc) rn
           from dt,
                barsupl.tmp_upl_dm_objects o
           left join bars.smb_deposit_log s on (s.object_id = o.object_id)
           join bars.smb_deposit tt on (tt.id = o.object_id)
          where (s.local_bank_date  <= dt.dt2 or s.local_bank_date is null)
            and (dt.kf= o.kf or dt.kf is null)
                 /* Если process_data пустой - значит договор в стадии заведения, изменения в smb_deposit_log отсутствуют
                    параметры можно брать из полей выгрузки, а не из XML. В этом случае записи будут приходить наперед */
            and ( s.object_id is null
             or   lower(s.process_data) like ''%smbdeposittranche%''
             or   lower(s.process_data) like ''%smbdepositondemand%'')
            and o.type_id in (24, 25)
       ) ss
 where 1=1
   and rn = 1');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values (571, l_clob, 'begin
     begin
       execute immediate ''begin barsupl.bars_upload_usr.tuda; end;'';
     exception
       when others then if sqlcode = -6550 then null; else raise; end if;
     end;
     -- заполнение витрины
     barsupl.fill_upl_dm_objects(p_bank_date => to_date(:param1,''dd/mm/yyyy''), p_clear_data => ''N'');
end;', NULL, 'Депозити ММСБ', '1.0');

end;
/

declare l_clob clob;
begin
l_clob:= to_clob('with dt as ( select /*+ materialize */
                    bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1,
                    to_date (:param1, ''dd/mm/yyyy'') dt2,
                    bars.gl.kf
               from dual )
select ss.nd_type,
       ss.nd,
       ss.kf,
       ss.kv,
       ss.deal_number,
       ss.customer_id,
       ss.product_id,
       ss.start_date,
       ss.expiry_date,
       ss.close_date,
       ss.branch,
       ss.curator_id,
       ss.state_id,
       9 as tup,
       translate(ss.process_data, chr(9)||chr(10)||chr(13), ''   '') as process_data
  from ( select o.type_id as nd_type,
                o.object_id as nd,
                o.kf,
                tt.currency_id as kv,
                o.deal_number,
                o.customer_id,
                o.product_id,
                o.start_date,
                o.expiry_date,
                o.close_date,
                o.branch_id as branch,
                o.curator_id,
                o.state_id,
                s.process_data,
                row_number() over (partition by o.object_id order by s.id desc) rn
           from dt,
                barsupl.tmp_upl_dm_objects o
           left join bars.smb_deposit_log s on (s.object_id = o.object_id)
           join bars.smb_deposit tt on (tt.id = o.object_id)
          where (s.local_bank_date  <= dt.dt2 or s.local_bank_date is null)
            and (s.global_bank_date >= dt.dt1  or s.global_bank_date is null) --FOR DELTA
            and (dt.kf= o.kf or dt.kf is null)
                 /* Если process_data пустой - значит договор в стадии заведения, изменения в smb_deposit_log отсутствуют
                    параметры можно брать из полей выгрузки, а не из XML. В этом случае записи будут приходить наперед */
            and ( s.object_id is null
             or   lower(s.process_data) like ''%smbdeposittranche%''
             or   lower(s.process_data) like ''%smbdepositondemand%'')
            and o.type_id in (24, 25)
       ) ss
 where 1=1
   and rn = 1');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values (1571, l_clob, 'begin
     begin
       execute immediate ''begin barsupl.bars_upload_usr.tuda; end;'';
     exception
       when others then if sqlcode = -6550 then null; else raise; end if;
     end;
     -- заполнение витрины
     barsupl.fill_upl_dm_objects(p_bank_date => to_date(:param1,''dd/mm/yyyy''), p_clear_data => ''N'');
end;', NULL, 'Депозити ММСБ', '1.0');

end;
/

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (571);

Insert into UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id, nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (571, 571, 'SMB_DEPOSIT', 'smb_deposit', 0, '09', NULL, '10', 0, 'Депозити ММСБ', 571, 'null', 'DELTA', 'ARR', 1, NULL, 1, 'AR', 1, 1);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (571);

Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (571, 1, 'ND_TYPE', 'Вид угоди', 'NUMBER', 5, 0, NULL, 'Y', 'N', NULL, NULL, NULL, 1, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (571, 2, 'ND', 'Ідентифікатор угоди', 'NUMBER', 38, 0, NULL, 'Y', 'N', NULL, NULL, NULL, 2, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (571, 3, 'KF', 'Код філіалу', 'VARCHAR2', 6, NULL, NULL, 'Y', 'N', NULL, NULL, NULL, 3, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (571, 4, 'KV', 'Валюта угиди', 'NUMBER', 3, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (571, 5, 'DEAL_NUMBER', 'Номер договору (паперового)', 'VARCHAR2', 100, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (571, 6, 'CUSTOMER_ID', 'Ідентифікатор клієнта', 'NUMBER', 38, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (571, 7, 'PRODUCT_ID', 'Ідентифікатор продукта', 'NUMBER', 38, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (571, 8, 'START_DATE', 'Дата початку дії траншу (первинна)', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '01.01.0001', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (571, 9, 'EXPIRY_DATE', 'Дата закінчення дії траншу (первинна)', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '01.01.0001', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (571, 10, 'CLOSE_DATE', 'Дата закриття траншу', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '01.01.0001', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (571, 11, 'BRANCH', 'Філіал банку, де обліковується угода', 'VARCHAR2', 30, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (571, 12, 'CURATOR_ID', 'Ідентифікатор співробітника банку', 'NUMBER', 38, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (571, 13, 'STATE_ID', 'Стан об''єкту', 'NUMBER', 38, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (571, 14, 'TUP', 'TUP для ХД', 'NUMBER', 3, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (571, 15, 'PROCESS_DATA', 'XML', 'VARCHAR2', 4000, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (571);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (571, 'smbdepo(KF)_$_banks(MFO)', 1, 402);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (571, 'smbdepo(KV)_$_tabval(KV)', 1, 296);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (571, 'smbdepo(CUSTOMER_ID,KF)_$_customer(RNK,KF)', 1, 121);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (571, 'smbdepo(PRODUCT_ID,TUP)_$_dealprod(ID,TUP)', 1, 576);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (571, 'smbdepo(BRANCH)_$_branch(BRANCH)', 1, 103);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (571, 'smbdepo(CURATOR_ID,KF)_$_staff(ID,KF)', 1, 181);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (571, 'smbdepo(CURATOR_ID)_$_staffad(ID)', 1, 182);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (571, 'smbdepo(STATE_ID)_$_objectstate(ID)', 1, 579);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (571);
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (571, 'smbdepo(KF)_$_banks(MFO)', 1, 'KF');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (571, 'smbdepo(KV)_$_tabval(KV)', 1, 'KV');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (571, 'smbdepo(CUSTOMER_ID,KF)_$_customer(RNK,KF)', 1, 'CUSTOMER_ID');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (571, 'smbdepo(CUSTOMER_ID,KF)_$_customer(RNK,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (571, 'smbdepo(PRODUCT_ID,TUP)_$_dealprod(ID,TUP)', 1, 'PRODUCT_ID');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (571, 'smbdepo(PRODUCT_ID,TUP)_$_dealprod(ID,TUP)', 2, 'TUP');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (571, 'smbdepo(BRANCH)_$_branch(BRANCH)', 1, 'BRANCH');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (571, 'smbdepo(CURATOR_ID,KF)_$_staff(ID,KF)', 1, 'CURATOR_ID');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (571, 'smbdepo(CURATOR_ID,KF)_$_staff(ID,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (571, 'smbdepo(CURATOR_ID)_$_staffad(ID)', 1, 'CURATOR_ID');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (571, 'smbdepo(STATE_ID)_$_objectstate(ID)', 1, 'STATE_ID');


-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (571);

Insert into BARSUPL.UPL_FILEGROUPS_RLN(GROUP_ID, FILE_ID, SQL_ID) Values (1, 571,  571);
Insert into BARSUPL.UPL_FILEGROUPS_RLN(GROUP_ID, FILE_ID, SQL_ID) Values (2, 571, 1571);
Insert into BARSUPL.UPL_FILEGROUPS_RLN(GROUP_ID, FILE_ID, SQL_ID) Values (3, 571,  571);
Insert into BARSUPL.UPL_FILEGROUPS_RLN(GROUP_ID, FILE_ID, SQL_ID) Values (4, 571, 1571);


