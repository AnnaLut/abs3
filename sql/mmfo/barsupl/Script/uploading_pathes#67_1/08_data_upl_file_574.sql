-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 574
--define ssql_id  = 574,1574

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 574');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (574))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 574,1574');
end;
/
-- ***************************************************************************
-- TSK-0001183 ANL - анализ выгрузки депозитных линий ММСБ
-- TSK-0003096 UPL - зробити вивантаження договорів депозитиних ліній (траншів), поточних рахунків та їх параметрів із нового модуля депозитів ММСБ
-- 06_SMD_ATTRIBUTE_v01
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************

delete from BARSUPL.UPL_SQL where SQL_ID IN (574,1574);

declare l_clob clob;
begin
l_clob:= to_clob('with  tg as ( select /*+ inline */
                     distinct tag, ak.id as tag_id, ak.save_history_flag, ak.value_by_date_flag, ak.small_value_flag
                from barsupl.upl_tag_lists l
                join bars.attribute_kind ak  on (ak.attribute_code = l.tag)
               where l.tag_table in (''SMB_TRANCHE'', ''SMB_ON_DEMAND'') and coalesce(l.ref_id, 0) = 0 and l.isuse = 1),
      dt as ( select /*+ materialize */
                     bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1,
                     to_date (:param1, ''dd/mm/yyyy'') dt2,
                     bars.gl.kf,
                     ''fm99999999999999999999999999999999999990D999999999999999999999999'' as nls_fmt_num,
                     ''NLS_NUMERIC_CHARACTERS = ''''.,'''''' as nls_fmt_dec
                from dual ),
      --все параметры и договоров по которым были изменения в истории, либо параметр не историзируемый но хранится по дате
      dl as ( select /* materialize */ distinct
                     ob.type_id,
                     ob.object_id,
                     ob.kf,
                     tg1.tag_id,
                     tg1.tag,
                     max(id) over (partition by ob.object_id, ob.kf, tg1.tag_id) as id
                     , tg1.save_history_flag
                     , tg1.value_by_date_flag
                from dt,
                     (select tag, tag_id, save_history_flag, value_by_date_flag from tg where value_by_date_flag = ''Y'' or save_history_flag = ''Y'') tg1
                cross join barsupl.tmp_upl_dm_objects ob
                left join bars.attribute_history h on (h.attribute_id = tg1.tag_id and ob.object_id = h.object_id)
               where (trunc(h.sys_time) <= dt.dt2
                  or (h.object_id is null and tg1.save_history_flag = ''N''))
                 and ob.type_id in (24, 25))
 -- все параметры по дате
 select dl.type_id as nd_type,
        dl.object_id as nd,
        dl.kf,
        dl.tag,
        coalesce( coalesce(rtrim(to_char(  av.NUMBER_VALUE, dt.nls_fmt_num, dt.nls_fmt_dec), ''.''),   av.STRING_VALUE, to_char(  av.DATE_VALUE, ''ddmmyyyy'')),
                  coalesce(rtrim(to_char(avs.NUMBER_VALUES, dt.nls_fmt_num, dt.nls_fmt_dec), ''.''), avs.STRING_VALUES, to_char(avs.DATE_VALUES, ''ddmmyyyy''))
                ) as value,
        av.value_date --действует с даты
   from dt,
       (select tag, tag_id, save_history_flag, value_by_date_flag from tg where value_by_date_flag = ''Y'') tg1 --- and save_history_flag = ''N''
   join dl on (dl.tag_id = tg1.tag_id)
   join bars.attribute_value_by_date av on (av.attribute_id = tg1.tag_id and dl.object_id = av.object_id)
   --join barsupl.tmp_upl_dm_objects ob on (ob.object_id = av.object_id)
   left join bars.attribute_values avs on (avs.nested_table_id = av.nested_table_id)
  where dl.type_id in (24, 25)
 union all
 -- все параметры не по датам и не историзируемые и small_value_flag = ''N'' (всегда полная выгрузка)
 select ob.type_id as nd_type,
        ob.object_id as nd,
        ob.kf,
        tg1.tag,
        coalesce( coalesce(rtrim(to_char( av.NUMBER_VALUE,  dt.nls_fmt_num, dt.nls_fmt_dec), ''.''),  av.STRING_VALUE,  to_char( av.DATE_VALUE, ''ddmmyyyy'')),
                  coalesce(rtrim(to_char(avs.NUMBER_VALUES, dt.nls_fmt_num, dt.nls_fmt_dec), ''.''), avs.STRING_VALUES, to_char(avs.DATE_VALUES, ''ddmmyyyy''))
                ) as value,
        null as value_date
   from dt,
        (select tag, tag_id, save_history_flag, value_by_date_flag from tg where value_by_date_flag = ''N'' and save_history_flag = ''N'' and small_value_flag = ''N'') tg1
   join bars.attribute_value av on (av.attribute_id = tg1.tag_id)
   join barsupl.tmp_upl_dm_objects ob on (ob.object_id = av.object_id)
   left join bars.attribute_values avs on (avs.nested_table_id = av.nested_table_id)
  where ob.type_id in (24, 25)
 union all
 -- все параметры не по датам и не историзируемые и small_value_flag = ''Y'' (всегда полная выгрузка)
 select ob.type_id as nd_type,
        ob.object_id as nd,
        ob.kf,
        tg1.tag,
        coalesce( coalesce(rtrim(to_char(av.NUMBER_VALUE,  dt.nls_fmt_num, dt.nls_fmt_dec), ''.''), av.STRING_VALUE,  to_char(av.DATE_VALUE, ''ddmmyyyy'')),
                  coalesce(rtrim(to_char(avs.NUMBER_VALUES, dt.nls_fmt_num, dt.nls_fmt_dec), ''.''), avs.STRING_VALUES, to_char(avs.DATE_VALUES, ''ddmmyyyy''))
                ) as value,
        null as value_date
   from dt,
        (select tag, tag_id, save_history_flag, value_by_date_flag from tg where value_by_date_flag = ''N'' and save_history_flag = ''N'' and small_value_flag = ''Y'') tg1
   join bars.attribute_small_value av on (av.attribute_id = tg1.tag_id)
   join barsupl.tmp_upl_dm_objects ob on (ob.object_id = av.object_id)
   left join bars.attribute_values avs on (avs.nested_table_id = av.nested_table_id)
  where ob.type_id in (24, 25)
 union all
 -- все параметры не по датам историзируемые
 select dl.type_id as nd_type,
        dl.object_id as nd,
        dl.kf,
        dl.tag,
        coalesce(rtrim(to_char( h.NUMBER_VALUE,  dt.nls_fmt_num, dt.nls_fmt_dec), ''.''),  h.STRING_VALUE,  to_char( h.DATE_VALUE, ''ddmmyyyy'')) as value,
        h.valid_from as value_date
   from dt,
        dl
   join  bars.attribute_history h on (h.id = dl.id and h.attribute_id = dl.tag_id and h.object_id = dl.object_id)
   where dl.value_by_date_flag = ''N'' and dl.save_history_flag = ''Y''');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (574, l_clob, 'begin
     begin
       execute immediate ''begin barsupl.bars_upload_usr.tuda; end;'';
     exception
       when others then if sqlcode = -6550 then null; else raise; end if;
     end;
     -- заполнение витрины
     barsupl.fill_upl_dm_objects(p_bank_date => to_date(:param1,''dd/mm/yyyy''), p_clear_data => ''N'');
end;', NULL, 'Атрибуты депозитов ММСБ', '1.0');

end;
/

declare l_clob clob;
begin
l_clob:= to_clob('with  tg as ( select /*+ inline */
                     distinct tag, ak.id as tag_id, ak.save_history_flag, ak.value_by_date_flag, ak.small_value_flag
                from barsupl.upl_tag_lists l
                join bars.attribute_kind ak  on (ak.attribute_code = l.tag)
               where l.tag_table in (''SMB_TRANCHE'', ''SMB_ON_DEMAND'') and coalesce(l.ref_id, 0) = 0 and l.isuse = 1),
      dt as ( select /*+ materialize */
                     bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1,
                     to_date (:param1, ''dd/mm/yyyy'') dt2,
                     bars.gl.kf,
                     ''fm99999999999999999999999999999999999990D999999999999999999999999'' as nls_fmt_num,
                     ''NLS_NUMERIC_CHARACTERS = ''''.,'''''' as nls_fmt_dec
                from dual ),
      --все параметры и договоров по которым были изменения в истории, либо параметр не историзируемый но хранится по дате
      dl as ( select /* materialize */ distinct
                     ob.type_id,
                     ob.object_id,
                     ob.kf,
                     tg1.tag_id,
                     tg1.tag,
                     max(id) over (partition by ob.object_id, ob.kf, tg1.tag_id) as id
                     , tg1.save_history_flag
                     , tg1.value_by_date_flag
                from dt
                join (select tag, tag_id, save_history_flag, value_by_date_flag from tg where value_by_date_flag = ''Y'' or save_history_flag = ''Y'') tg1 on (1=1)
                cross join barsupl.tmp_upl_dm_objects ob
                left join bars.attribute_history h on (h.attribute_id = tg1.tag_id and ob.object_id = h.object_id )
               where (trunc(h.sys_time) between dt.dt1 and dt.dt2
                  or (h.object_id is null and tg1.save_history_flag = ''N''))
                 and ob.type_id in (24, 25))
 -- все параметры по дате
 select dl.type_id as nd_type,
        dl.object_id as nd,
        dl.kf,
        dl.tag,
        coalesce( coalesce(rtrim(to_char(  av.NUMBER_VALUE, dt.nls_fmt_num, dt.nls_fmt_dec), ''.''),   av.STRING_VALUE, to_char(  av.DATE_VALUE, ''ddmmyyyy'')),
                  coalesce(rtrim(to_char(avs.NUMBER_VALUES, dt.nls_fmt_num, dt.nls_fmt_dec), ''.''), avs.STRING_VALUES, to_char(avs.DATE_VALUES, ''ddmmyyyy''))
                ) as value,
        av.value_date --действует с даты
   from dt,
       (select tag, tag_id, save_history_flag, value_by_date_flag from tg where value_by_date_flag = ''Y'') tg1 --- and save_history_flag = ''N''
   join dl on (dl.tag_id = tg1.tag_id)
   join bars.attribute_value_by_date av on (av.attribute_id = tg1.tag_id and dl.object_id = av.object_id)
   --join barsupl.tmp_upl_dm_objects ob on (ob.object_id = av.object_id)
   left join bars.attribute_values avs on (avs.nested_table_id = av.nested_table_id)
  where dl.type_id in (24, 25)
 union all
 -- все параметры не по датам и не историзируемые и small_value_flag = ''N'' (всегда полная выгрузка)
 select ob.type_id as nd_type,
        ob.object_id as nd,
        ob.kf,
        tg1.tag,
        coalesce( coalesce(rtrim(to_char( av.NUMBER_VALUE,  dt.nls_fmt_num, dt.nls_fmt_dec), ''.''),  av.STRING_VALUE,  to_char( av.DATE_VALUE, ''ddmmyyyy'')),
                  coalesce(rtrim(to_char(avs.NUMBER_VALUES, dt.nls_fmt_num, dt.nls_fmt_dec), ''.''), avs.STRING_VALUES, to_char(avs.DATE_VALUES, ''ddmmyyyy''))
                ) as value,
        null as value_date
   from dt,
        (select tag, tag_id, save_history_flag, value_by_date_flag from tg where value_by_date_flag = ''N'' and save_history_flag = ''N'' and small_value_flag = ''N'') tg1
   join bars.attribute_value av on (av.attribute_id = tg1.tag_id)
   join barsupl.tmp_upl_dm_objects ob on (ob.object_id = av.object_id)
   left join bars.attribute_values avs on (avs.nested_table_id = av.nested_table_id)
  where ob.type_id in (24, 25)
 union all
 -- все параметры не по датам и не историзируемые и small_value_flag = ''Y'' (всегда полная выгрузка)
 select ob.type_id as nd_type,
        ob.object_id as nd,
        ob.kf,
        tg1.tag,
        coalesce( coalesce(rtrim(to_char(av.NUMBER_VALUE,  dt.nls_fmt_num, dt.nls_fmt_dec), ''.''), av.STRING_VALUE,  to_char(av.DATE_VALUE, ''ddmmyyyy'')),
                  coalesce(rtrim(to_char(avs.NUMBER_VALUES, dt.nls_fmt_num, dt.nls_fmt_dec), ''.''), avs.STRING_VALUES, to_char(avs.DATE_VALUES, ''ddmmyyyy''))
                ) as value,
        null as value_date
   from dt,
        (select tag, tag_id, save_history_flag, value_by_date_flag from tg where value_by_date_flag = ''N'' and save_history_flag = ''N'' and small_value_flag = ''Y'') tg1
   join bars.attribute_small_value av on (av.attribute_id = tg1.tag_id)
   join barsupl.tmp_upl_dm_objects ob on (ob.object_id = av.object_id)
   left join bars.attribute_values avs on (avs.nested_table_id = av.nested_table_id)
  where ob.type_id in (24, 25)
 union all
 -- все параметры не по датам историзируемые
 select dl.type_id as nd_type,
        dl.object_id as nd,
        dl.kf,
        dl.tag,
        coalesce(rtrim(to_char( h.NUMBER_VALUE,  dt.nls_fmt_num, dt.nls_fmt_dec), ''.''),  h.STRING_VALUE,  to_char( h.DATE_VALUE, ''ddmmyyyy'')) as value,
        h.valid_from as value_date
   from dt,
        dl
   join  bars.attribute_history h on (h.id = dl.id and h.attribute_id = dl.tag_id and h.object_id = dl.object_id)
   where dl.value_by_date_flag = ''N'' and dl.save_history_flag = ''Y''');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (1574, l_clob, 'begin
     begin
       execute immediate ''begin barsupl.bars_upload_usr.tuda; end;'';
     exception
       when others then if sqlcode = -6550 then null; else raise; end if;
     end;
     -- заполнение витрины
     barsupl.fill_upl_dm_objects(p_bank_date => to_date(:param1,''dd/mm/yyyy''), p_clear_data => ''N'');
end;', NULL, 'Атрибуты депозитов ММСБ', '1.0');

end;
/

-- ***********************
-- UPL_FILES
-- ***********************

delete from BARSUPL.UPL_FILES where FILE_ID IN (574);

Insert into UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id, nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (574, 574, 'SMB_ATTRIBUTE', 'smbattribute', 0, '09', NULL, '10', 0, 'Атрибуты депозитов ММСБ', 574, 'null', 'DELTA', 'EVENT', 1, NULL, 1, 'SMB_ATTRIBUTE', 1, 1);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (574);

Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (574, 1, 'ND_TYPE', 'Вид угоди', 'NUMBER', 5, 0, NULL, 'Y', 'N', NULL, NULL, NULL, 1, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (574, 2, 'ND', 'Ідентифікатор угоди', 'NUMBER', 38, 0, NULL, 'Y', 'N', NULL, NULL, NULL, 2, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (574, 3, 'KF', 'Код філіалу', 'VARCHAR2', 6, NULL, NULL, 'Y', 'N', NULL, NULL, NULL, 3, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (574, 4, 'TAG', 'Код додаткового реквізиту', 'VARCHAR2', 100, NULL, NULL, 'Y', 'N', NULL, NULL, 'N/A', 4, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (574, 5, 'VALUE', 'Значення додаткового реквізиту', 'VARCHAR2', 500, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (574, 6, 'VALUE_DATE', 'Дата параметру', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '01.01.0001', NULL, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (574);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (574, 'smbattribute(KF)_$_banks(MFO)', 1, 402);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (574, 'smbattribute(TAG)_$_attributetype(ATTRIBUTE_CODE)', 1, 578);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (574, 'smbattribute(ND_TYPE,ND,KF)_$_smbdepo(ND_TYPE,ND,KF)', 1, 571);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (574);
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (574, 'smbattribute(KF)_$_banks(MFO)', 1, 'KF');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (574, 'smbattribute(TAG)_$_attributetype(ATTRIBUTE_CODE)', 1, 'TAG');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (574, 'smbattribute(ND_TYPE,ND,KF)_$_smbdepo(ND_TYPE,ND,KF)', 1, 'ND_TYPE');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (574, 'smbattribute(ND_TYPE,ND,KF)_$_smbdepo(ND_TYPE,ND,KF)', 2, 'ND');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (574, 'smbattribute(ND_TYPE,ND,KF)_$_smbdepo(ND_TYPE,ND,KF)', 3, 'KF');

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (574);

Insert into BARSUPL.UPL_FILEGROUPS_RLN(GROUP_ID, FILE_ID, SQL_ID) Values (1, 574,  574);
Insert into BARSUPL.UPL_FILEGROUPS_RLN(GROUP_ID, FILE_ID, SQL_ID) Values (2, 574, 1574);
Insert into BARSUPL.UPL_FILEGROUPS_RLN(GROUP_ID, FILE_ID, SQL_ID) Values (3, 574,  574);
Insert into BARSUPL.UPL_FILEGROUPS_RLN(GROUP_ID, FILE_ID, SQL_ID) Values (4, 574, 1574);
