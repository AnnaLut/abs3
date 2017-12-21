-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
define sfile_id = 162
define ssql_id  = 162,1162,2162,3162

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
-- ETL-20822 UPL - создать выгрузку общих связок: arr_acc1 + arr_accmbk
--
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

declare l_clob clob;
begin
l_clob:= to_clob('with  dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date(:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date(:param1, ''dd/mm/yyyy'') dt2 from dual ),
  acc_up as ( select /*+ materialize parallel(12)*/ max(u1.idupd) idupd, u1.acc, u1.nd
                from bars.nd_acc_update u1, dt
               where u1.effectdate <= dt.dt2
               group by u1.acc, u1.nd),
 deal_up as ( select /*+ materialize parallel(12)*/ max(u2.idupd) idupd
                from bars.cc_deal_update u2, dt, acc_up
               where u2.effectdate <= dt.dt2
                 and u2.nd = acc_up.nd
               group by u2.nd)
select /*+ ordered */
       unique u.ND, u.ACC, d.KF,
       case when d.VIDD in (10, 110) then 10
            when d.VIDD = 26 then 19
            when d.VIDD in (137, 237, 337) then 15
            else 3
       end  as ND_TYPE,
       v.CUSTTYPE,
       u.CHGACTION
  from deal_up,
       BARS.CC_DEAL_UPDATE d,
       BARS.ND_ACC_UPDATE  u,
       acc_up               ,
       BARS.CC_VIDD        v,
       BARS.ACCOUNTS       a
 where u.nd   = d.nd
   and d.vidd = v.vidd
   and a.acc = u.acc
   and a.rnk = d.rnk
   and u.idupd = acc_up.idupd
   and d.idupd = deal_up.idupd
   and (v.custtype <> 1 or d.sos <> 15)
 union all
select unique acc as nd,
              acc,
              bars.gl.kf,
              5 nd_type,
              null as custtype,
              u1.chgaction
  from bars.pawn_acc_update u1
where u1.idupd in
       (  select MAX (u1.idupd) idupd
            from bars.pawn_acc_update u1, dt
           where u1.effectdate <= dt.dt2
           group by u1.acc )');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (162, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL,
    'Связка договор-счет (кредиты+мбк+over+бро)', '1.0');
end;
/

declare l_clob clob;
begin
l_clob:= to_clob('with  dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date(:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date(:param1, ''dd/mm/yyyy'') dt2 from dual ),
  acc_up as ( select /*+ materialize parallel(12)*/ max(u1.idupd) idupd, u1.acc, u1.nd
                from bars.nd_acc_update u1, dt
               where u1.global_bdate >= dt.dt1
                 and u1.effectdate <= dt.dt2
               group by u1.acc, u1.nd),
 deal_up as ( select /*+ materialize parallel(12)*/ max(u2.idupd) idupd
                from bars.cc_deal_update u2, dt, acc_up
               where u2.effectdate <= dt.dt2
                 and u2.nd = acc_up.nd
               group by u2.nd)
select /*+ ordered */
       unique u.ND, u.ACC, d.KF,
       case when d.VIDD in (10, 110) then 10
            when d.VIDD = 26 then 19
            when d.VIDD in (137, 237, 337) then 15
            else 3
       end  as ND_TYPE,
       v.CUSTTYPE,
       u.CHGACTION
  from deal_up,
       BARS.CC_DEAL_UPDATE d,
       BARS.ND_ACC_UPDATE  u,
       acc_up               ,
       BARS.CC_VIDD        v,
       BARS.ACCOUNTS       a
 where u.nd   = d.nd
   and d.vidd = v.vidd
   and a.acc = u.acc
   and a.rnk = d.rnk
   and u.idupd = acc_up.idupd
   and d.idupd = deal_up.idupd
union all
select unique acc as nd,
              acc,
              bars.gl.kf,
              5 nd_type,
              null as custtype,
              u1.chgaction
  from bars.pawn_acc_update u1
where u1.idupd in
       (  select MAX (u1.idupd) idupd
            from bars.pawn_acc_update u1, dt
           where u1.effectdate between dt.dt1 and dt.dt2
           group by u1.acc )');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (1162, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL,
    'Связка договор-счет (кредиты+мбк+over+бро)', '1.0');

end;
/

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (&&sfile_id);

Insert into UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id, nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (162, 162, 'ARRACC0', 'arracc0', 0, '09', NULL, '10', 0, 'Связка договор-счет (кредиты+мбк+over+бро)', 162, 'null', 'DELTA', 'ARR', 1, NULL, 1, 'arraccrln', 1, 1);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (&&sfile_id);

Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type,  col_length, col_scale, col_format, pk_constr, nullable,  null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (162, 1, 'ND', 'Номер договора', 'NUMBER',  15, 0, NULL, 'Y', 'N',  NULL, NULL, '0', 2, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type,  col_length, col_scale, col_format, pk_constr, nullable,  null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (162, 2, 'ACC', 'Внутренний номер счета', 'NUMBER',  15, 0, NULL, 'Y', 'N',  NULL, NULL, '0', 4, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type,  col_length, col_scale, col_format, pk_constr, nullable,  null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (162, 3, 'KF', 'Код филиала', 'VARCHAR2',  6, NULL, NULL, 'Y', 'N',  NULL, NULL, '-', 3, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type,  col_length, col_scale, col_format, pk_constr, nullable,  null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (162, 4, 'ND_TYPE', 'Тип договора', 'NUMBER',  2, 0, NULL, 'Y', 'N',  NULL, NULL, '0', 1, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type,  col_length, col_scale, col_format, pk_constr, nullable,  null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (162, 5, 'CUSTTYPE', 'Тип клиента 3 - физическое лицо 2 - юридическое лицо 1 - банк', 'NUMBER', 1, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type,  col_length, col_scale, col_format, pk_constr, nullable,  null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (162, 6, 'CHGACTION', 'Тип изменений', 'CHAR',  1, NULL, NULL, NULL, 'Y',  NULL, NULL, '-', NULL, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (&&sfile_id);

Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (162, 'arracc0(ACC,KF)_$_account(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (162, 'arracc0(KF)_$_banks(KF)', 2, 402);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (162, 'arracc0(ND_TYPE)_$_arrtype(TYPE_ID)', 2, 261);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (162, 'arracc0(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 1, 161);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (&&sfile_id);

Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (162, 'arracc0(ACC,KF)_$_account(ACC,KF)', 1, 'ACC');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (162, 'arracc0(ACC,KF)_$_account(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (162, 'arracc0(KF)_$_banks(KF)', 1, 'KF');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (162, 'arracc0(ND_TYPE)_$_arrtype(TYPE_ID)', 1, 'ND_TYPE');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (162, 'arracc0(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 5, 'KF');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (162, 'arracc0(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 2, 'ND');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (162, 'arracc0(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 1, 'ND_TYPE');

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (&&sfile_id);

Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (1, 162,  162);
Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (2, 162, 1162);
Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (3, 162,  162);
Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (4, 162, 1162);



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
