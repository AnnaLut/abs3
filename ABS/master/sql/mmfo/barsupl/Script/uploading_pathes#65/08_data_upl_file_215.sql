-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 215 
--define ssql_id  = 215, 1215

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 215');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (215))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 215, 125');
end;
/
-- ***************************************************************************
-- ETL-25045   UPL - upload in MIR table VIP_FLAGS
-- 
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (215, 1215);

Insert into BARSUPL.UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
Values  (215, 'with kf as (select /*+ materialize */
                   coalesce( bars_upload.get_param(''KF''),
                            (select kf from barsupl.upl_regions where CODE_CHR = bars_upload.get_param(''REGION_PRFX''))
                           ) kf
              from dual),
     dt as ( select to_date (:param1, ''dd/mm/yyyy'') dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
select mfo, to_number(rnk), fio_manager, phone_manager, mail_manager, account_manager
  from ( select mfo, rnk, fio_manager, phone_manager, mail_manager, account_manager,
                row_number() over (partition by v.rnk order by idupd desc) rn
           from bars.vip_flags_arc v, dt, kf
          where v.EFFECTDATE <= dt.dt2
            and v.MFO = KF.KF
       )
  where rn = 1', 
              'begin barsupl.bars_upload_usr.suda; end;',
              'begin barsupl.bars_upload_usr.tuda(null); end;', 'Інформація по клієнтам VIP', '1.0');

Insert into BARSUPL.UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
Values  (1215, 'with kf as (select /*+ materialize */
                   coalesce( bars_upload.get_param(''KF''),
                            (select kf from barsupl.upl_regions where CODE_CHR = bars_upload.get_param(''REGION_PRFX''))
                           ) kf
              from dual),
     dt as ( select to_date (:param1, ''dd/mm/yyyy'') dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
select mfo, to_number(rnk), fio_manager, phone_manager, mail_manager, account_manager
  from ( select mfo, rnk, fio_manager, phone_manager, mail_manager, account_manager,
                row_number() over (partition by v.rnk order by idupd desc) rn
           from bars.vip_flags_arc v, dt, kf
          where v.GLOBAL_BDATE >= dt.dt1
            and v.EFFECTDATE <= dt.dt2
            and v.MFO = KF.KF
       )
  where rn = 1',
              'begin barsupl.bars_upload_usr.suda; end;',
              'begin barsupl.bars_upload_usr.tuda(null); end;', 'Інформація по клієнтам VIP (дельта)', '1.0');

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (215);

Insert into BARSUPL.UPL_FILES
   (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, 
    DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, 
    ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, 
    SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values
   (215, 215, 'VIP_FLAGS', 'vip_flags', 0, 
    '09', NULL, '10', 0, 'Інформація по клієнтам VIP', 
    92, 'null', 'DELTA', 'IP', 1, 
    NULL, 1, 'IP', 0, 1);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (215);

Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
Values (215,    1,  'MFO',  'Код филиала',  'VARCHAR2', 6,  NULL,   NULL,   'Y',    'N',    NULL,   NULL,   '0',    2,  NULL);
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
Values (215,    2,  'RNK',  'Реєстраційний номер клієнта',  'NUMBER', 20, 0,   NULL,   'Y',    'N',    NULL,   NULL,   '0',    1,  'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
Values (215,    3,  'FIO_MANAGER',  'Імя керівника',  'VARCHAR2', 250,    NULL,   NULL,   NULL,   'Y',    NULL,   NULL,   'N/A',  NULL,   NULL);
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
Values (215,    4,  'PHONE_MANAGER',    'Телефон керівника', 'VARCHAR2', 30, NULL,   NULL,   NULL,   'Y',    NULL,   NULL,   'N/A',  NULL,   NULL);
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
Values (215,    5,  'MAIL_MANAGER', 'Почта керівника',   'VARCHAR2', 100,    NULL,   NULL,   NULL,   'Y',    NULL,   NULL,   'N/A',  NULL,   NULL);
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
Values (215,    6,  'ACCOUNT_MANAGER',  'ID керівника',  'NUMBER',   10, 0,  NULL,   NULL,   'Y',    NULL,   NULL,   '0',    NULL,   NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (215);

Insert into BARSUPL.UPL_CONSTRAINTS(FILE_ID, CONSTR_NAME, PRIORITY, FK_FILEID) Values (215, 'vipfl(RNK,MFO)_$_customer(RNK,KF)', 1, 121);
Insert into BARSUPL.UPL_CONSTRAINTS(FILE_ID, CONSTR_NAME, PRIORITY, FK_FILEID) Values (215, 'vipfl(MFO)_$_banks(MFO)', 2, 402);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (215);

Insert into BARSUPL.UPL_CONS_COLUMNS (FILE_ID, CONSTR_NAME, FK_COLID, FK_COLNAME) Values (215, 'vipfl(RNK,MFO)_$_customer(RNK,KF)', 1, 'RNK');
Insert into BARSUPL.UPL_CONS_COLUMNS (FILE_ID, CONSTR_NAME, FK_COLID, FK_COLNAME) Values (215, 'vipfl(RNK,MFO)_$_customer(RNK,KF)', 2, 'MFO');

Insert into BARSUPL.UPL_CONS_COLUMNS (FILE_ID, CONSTR_NAME, FK_COLID, FK_COLNAME) Values (215, 'vipfl(MFO)_$_banks(MFO)', 1, 'MFO');

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (215);

Insert into BARSUPL.UPL_FILEGROUPS_RLN(GROUP_ID, FILE_ID, SQL_ID)
 Values (1, 215, 215);
Insert into BARSUPL.UPL_FILEGROUPS_RLN(GROUP_ID, FILE_ID, SQL_ID)
 Values (2, 215, 1215);
Insert into BARSUPL.UPL_FILEGROUPS_RLN(GROUP_ID, FILE_ID, SQL_ID)
 Values (3, 215, 215);
Insert into BARSUPL.UPL_FILEGROUPS_RLN(GROUP_ID, FILE_ID, SQL_ID)
 Values (4, 215, 1215);

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
