-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 7543
--define ssql_id  = 7543

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 7543');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (7543))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 7543');
end;
/
-- ***************************************************************************
-- ETL-24964  UPL - перенести вызов функции построения графиков Т0 из PRVN_DEALS(543, 7543) в PRVN_FLOW(544, 7544)
-- установлен critical_flg = 0
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (7543);

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (7543, 'select prvn.ND_TYPE, prvn.PRVN_TP, prvn.KF,    prvn.ID,    prvn.ND,    prvn.ACC,
       prvn.KV,      prvn.VIDD,    prvn.RNK,   prvn.SDATE, prvn.WDATE, prvn.TIP,
       prvn.KV8,     prvn.ACC8,    prvn.PR_TR, prvn.I_CR9, prvn.PV,    prvn.PV0,
       prvn.IR,      prvn.IRR0,    prvn.K,     prvn.k1,    prvn.OST,   prvn.OST8,
       prvn.OSTQ,    prvn.OST8Q,   prvn.SN,    prvn.CR9,   prvn.SPN,   prvn.SNO,
       prvn.SN8,     prvn.SK0,     prvn.SK9,   prvn.SDI,   prvn.S36,   prvn.SP,
       prvn.DATE_CLOSE,            prvn.ZDAT,  BARS.DAT_NEXT_U(prvn.ZDAT, -1) as OST_DAT,
       prvn.SD1,     prvn.SD2
  from ( select 3 as ND_TYPE, 13 as PRVN_TP, bars.gl.kf as KF,
                c.ID,    c.ND,   c.ACC,   c.KV,
                c.VIDD,  v.RNK,  c.SDATE, v.WDATE,
                c.TIP,   c.KV8,  c.ACC8,  v.PR_TR,
                v.I_CR9, v.PV,   v.PV0,   v.IR,
                v.IRR0,  v.K,    v.k1,    v.OST,
                v.OST8,  v.OSTQ, v.OST8Q, v.SN,
                v.CR9,   v.SPN,  v.SNO,   v.SN8,
                v.SK0,   v.SK9,  v.SDI,   v.S36,
                v.SP,    v.SD1,  v.SD2,
                v.ZDAT,  c.DATE_CLOSE,
                count(1) over (partition by c.ND) as ND_QTY
           from BARS.PRVN_FLOW_DEALS_VAR v
          inner
           join BARS.PRVN_FLOW_DEALS_CONST c
             on ( c.ID = v.ID )
          where v.ZDAT = trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
            and ( v.vidd in ( 1, 2, 3, 11, 12, 13 )
                  or
                  v.vidd between 1500 and 1599 )
            and c.DAOS < v.ZDAT
       ) prvn
 where vidd in ( 1, 11, 12, 13 ) and ND_QTY > 1
    or vidd in ( 2, 3 )
    or vidd between 1500 and 1599',
'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
 NULL, 'Таблиця субугод КД для сховища на звітну дату (для FineVare)', '1.11');


--declare l_clob clob;
--begin
--l_clob:= to_clob();
--end;
--/

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (7543);

Insert into UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, 
    order_id, nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (7543, 7543, 'PRVN_DEALS_T0', 'prvn_deals0', 0, '09', NULL, '10', 0, 'Таблиця КД-угод для сховища с доп. инфо на звитну дату', 
    7543, 'null', 'WHOLE', 'ARR', 1, NULL, 1, 'AR', 0, 1);

-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (7543);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (7543);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (7543);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (7543);

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
