-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
define sfile_id = 546
define ssql_id  = 546

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
-- ETL-21161 UPL - изменить фильтр по балансовым счетам в выгрузке файла FEEADJTXN0 в связи с изменением плана счетов
-- 
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

declare l_clob clob;
begin
  l_clob:= to_clob('select o.REF, o.STMT, o.KF, o.FDAT, o.S, o.SQ, o.TT, o.DK, o.ACC, d.VDAT
  from BARS.OPLDOK o join BARS.OPER d on ( d.REF = o.REF )
 where o.REF in ( select t.REF
                    from BARS.OPLDOK t
                    join BARS.OPER d
                      on ( d.REF = t.REF )
                   where ( t.FDAT, t.ACC ) in ( select FDAT, ACC
                                                  from BARS.SALDOA
                                                 where ACC in ( select ACC
                                                                  from BARS.ACCOUNTS
                                                                 where (NBS in (1215,1216,1315,1316,1325,1326,1335,1336,1406,1407,1416,
                                                                               1417,1426,1427,1436,1437,1446,1447,1515,1516,1525,1526,1615,
                                                                               1616,1625,1626,2015,2016,2026,2036,2065,2066,2075,2076,2085,
                                                                               2086,2105,2106,2115,2116,2125,2126,2135,2136,2205,2206,2215,
                                                                               2216,2226,2235,2236,2616,2617,2636,2637,2653,2656,2706,2707,
                                                                               3016,3017,3116,3117,3216,3217,3306,3307,3316,3317,3326,3327,
                                                                               3336,3337,3346,3347,3600,3666,3667,
                                                                               2025, 2035, 1536, 1546, 3566, 2046, 2316, 2396, 2326, 2306,
                                                                               2346, 2356, 2146, 2366, 2386, 2376, 2246, 2406, 2456, 2416,
                                                                               2426, 2436)
                                                                    or TIP in (''SDI'', ''SPI''))
                                                                   and DAOS < trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
                                                                   and ( DAZS is Null or DAZS > trunc(to_date(:param1,''dd/mm/yyyy''),''MM'') )
                                                              )
                                                   and FDAT >= trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
                                                   and ( DOS <> 0 OR KOS <> 0 )
                                              )
                     and t.SOS = 5
                     and d.VOB = 96
                     and d.VDAT = BARS.DAT_NEXT_U(trunc(to_date(:param1,''dd/mm/yyyy''),''MM''),-1)
                )
   and o.TT not like ''PO_''
   and o.TT not like ''ZG_''');

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (546, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
    NULL, 'Коригуючі транзакції по рахунках дисконту (для FineVare)', '1.1');

end;
/

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
