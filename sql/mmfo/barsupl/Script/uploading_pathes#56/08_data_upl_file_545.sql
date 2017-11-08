-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую)
define sfile_id = 545
define ssql_id  = 545

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
-- ETL-20447 UPL - Харьков и Тернополь не установили uploading_pathes#37 и 545-й запрос остался старым.
-- В результате 01-го числа приходили данные с корректирующими.
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

declare
    cl clob;
begin
    cl:= to_clob( 'select 4 as ND_TYPE, 16 as PRVN_TP, bars.gl.kf as KF,
           v.REPORT_DT, v.DEAL_ND,  v.DEAL_SUM, c.DEAL_KV, v.RATE, v.DEAL_RNK, c.CARD_ND,
           c.OPEN_DT,   v.MATUR_DT, c.CLOSE_DT,
           v.SS,        v.SN,       v.SP,       v.SPN,     v.CR9
      from BARS.BPK_CREDIT_DEAL     c
      join BARS.BPK_CREDIT_DEAL_VAR v
        on ( v.DEAL_ND = c.DEAL_ND )
     where to_date(:param1,''dd/mm/yyyy'') = BARS.DAT_NEXT_U(last_day(to_date(:param1,''dd/mm/yyyy''))+1,-1)
       and v.REPORT_DT = add_months(trunc(to_date(:param1,''dd/mm/yyyy''),''MM''),1)
       and v.ADJ_FLG = 0
       and c.OPEN_DT < v.REPORT_DT
       and ( c.CLOSE_DT Is Null
             OR
             c.CLOSE_DT >= add_months(v.REPORT_DT,-1)
             OR
             c.CLOSE_DT <  add_months(v.REPORT_DT,-1) AND Not ( v.SS  = 0 and v.SN = 0 and v.SP = 0 and v.SPN = 0 and v.CR9 = 0 )
           )');

    Insert into BARSUPL.UPL_SQL  (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
        Values
        (545, cl, 
      'declare
      l_report_date    date;  -- звітна дата
      l_last_work_day  date;  -- остан. робочий день звітного місяця
      l_adj_tp         pls_integer;  -- 1 - з / 0 - без коригуючих
    begin
      barsupl.bars_upload_usr.tuda;
      l_report_date   := trunc(sysdate,''MM'');
      l_last_work_day := BARS.DAT_NEXT_U(last_day(to_date(:param1,''dd/mm/yyyy''))+1,-1);
      if ( to_date(:param1,''dd/mm/yyyy'') = l_last_work_day )  then
        l_adj_tp := 0; -- без коригуючих
        BARS.BPK_CREDITS.FILL_BPK_CREDIT_DEAL( l_report_date, l_adj_tp );
        commit;
      end if;
    end;',NULL, 'Договора кредитних лімітів під БПК', '1.4');
end;
/

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (&&sfile_id);

Insert into UPL_FILES
   (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values
   (545, 545, 'CARD_LOANS', 'card_loans', 0, '09', NULL, '10', 0, 'Договора кредитних лімітів під БПК', 545, 'null', 'DELTA', 'ARR', 1, NULL, 1, 'AR', 0, 1);


-- ***********************
-- UPL_COLUMNS
-- ***********************

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
