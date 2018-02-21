-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
define sfile_id = 538
define ssql_id  = 538

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
-- ETL-22340 UPL - заменить харткод в PROFIT_ADJ_TXN (PRFTADJTXN0)
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);
 
Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (538, 'with n as (select ''60%''   as lnls from dual union all
           select ''61%''   as lnls from dual union all
           select ''700%''  as lnls from dual union all
           select ''701%''  as lnls from dual union all
           select ''705%''  as lnls from dual union all
           select ''706%''  as lnls from dual union all
           select ''7096%'' as lnls from dual union all
           select ''712%''  as lnls from dual union all
           select ''7140%'' as lnls from dual )
select o.REF, o.STMT, o.KF, o.FDAT, o.S, o.SQ, o.TT, o.DK, o.ACC
  from BARS.OPLDOK o
 where o.REF in ( select t.REF
                    from BARS.OPLDOK t
                    join BARS.OPER d
                      on ( d.REF = t.REF )
                   where ( t.FDAT, t.ACC ) in ( select FDAT, ACC
                                                  from BARS.SALDOA
                                                 where ACC in ( select a.ACC
                                                                  from BARS.ACCOUNTS a, n
                                                                 where a.nls like n.lnls
                                                                   and a.DAOS < trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
                                                                   and ( a.DAZS is Null or a.DAZS > trunc(to_date(:param1,''dd/mm/yyyy''),''MM'') )
                                                              )
                                                   and FDAT >= trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
                                                   and ( DOS <> 0 OR KOS <> 0 )
                                              )
                     and t.SOS = 5
                     and d.VOB = 96
                     and d.VDAT = BARS.DAT_NEXT_U(trunc(to_date(:param1,''dd/mm/yyyy''),''MM''),-1)
                )
   and o.TT not like ''PO_''
   and o.TT not like ''ZG_''',
   'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   NULL, 'Коригуючі транзакції по рахунках (для FineVare)', '1.4');

--declare l_clob clob;
--begin
--l_clob:= to_clob();
--end;
--/

-- ***********************
-- UPL_FILES
-- изменено описание файла. Исключен текст "60-ї групи".
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (&&sfile_id);

Insert into BARSUPL.UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, 
    order_id, nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (538, 538, 'PROFIT_ADJ_TXN', 'prftadjtxn0', 0, '09', NULL, '10', 0, 'Коригуючі транзакції по рахунках (для FineVare)', 538, 'null', 'DELTA', 'GL', 1, NULL, 1, 'prftadjtxn0', 1, 1);

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
