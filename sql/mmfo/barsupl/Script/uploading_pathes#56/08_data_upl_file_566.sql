-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую)
define sfile_id = 566
define ssql_id  = 566

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
-- COBUSUPMMFO-212 Барс ММФО, відсутня міграція функціоналу з Барс Міленіум Вигрузка протоколу формування файлу #A7».
-- исправлено наименование констрейнта a7upl(*)_$_accounts(*) на a7upl(*)_$_staff(*)
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

Insert into BARSUPL.UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (566, 
'WITH
 VER as(
 SELECT max(lst.VERSION_ID) maxver
   FROM bars.NBUR_REF_FILES ref JOIN 
        bars.NBUR_LST_FILES lst
            ON (lst.FILE_ID = ref.ID)
   WHERE lst.report_date = to_date(:param1, ''dd/mm/yyyy'')
   and ref.FILE_CODE = ''#A7'' 
   AND lst.FILE_STATUS IN (''FINISHED'', ''BLOCKED'')
 )
    SELECT v.BRANCH TOBO,
       v.ACC_NUM AS NLS,
       v.KV AS KV,
       v.REPORT_DATE DATF,
       v.ACC_ID ACC,
       v.SEG_01 DK,
       v.SEG_02 NBS,
       v.SEG_08 KV1,
       v.SEG_04 S181,
       v.SEG_03 R013,
       v.SEG_05 S240,
       v.SEG_06 K030,
       v.SEG_07 R012,
       v.FIELD_VALUE ZNAP,
       v.CUST_ID RNK,
       v.CUST_CODE OKPO,
       v.CUST_NAME NMK,
       v.MATURITY_DATE MDATE,
       acc.isp ISP,
       v.ND ND,
       v.AGRM_NUM CC_ID,
       v.BEG_DT SDATE,
       v.END_DT WDATE,
       v.REF AS REF,
       v.DESCRIPTION COMM,
       v.KF
  FROM ver ver,
       bars.V_NBUR_#A7_DTL v
       LEFT JOIN bars.accounts acc ON (acc.acc = v.acc_id)
  where report_date = to_date(:param1, ''dd/mm/yyyy'') 
        and v.VERSION_ID = ver.maxver',
  'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;'
, NULL, 'Дані про структуру активів та пасивів за строками', '1.1');

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (&&sfile_id);

Insert into BARSUPL.UPL_FILES  (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values   (566, 566, 'A7_upl', 'a7_upl', 0, '09', NULL, '10', 0, 'Дані про структуру активів та пасивів за строками', 566, 'null', 'WHOLE', 'GL', 1, NULL, 1, 'a7', 0, 1);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (&&sfile_id);

Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 1, 'TOBO', 'Відділення', 'CHAR', 30, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 2, 'NLS', 'Номер рахунку', 'VARCHAR2', 20, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 3, 'KV', 'Валюта', 'NUMBER', 3, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 4, 'DATF', 'Робоча дата', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 5, 'ACC', 'ACC', 'NUMBER', 38, 0, NULL, 'Y', 'Y', NULL, NULL, '0', 1, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 6, 'DK', '1-Дт 2-Кт (код)', 'CHAR', 1, NULL, NULL, 'Y', 'Y', NULL, NULL, 'N/A', 3, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 7, 'NBS', 'Бал. рах. (код)', 'CHAR', 4, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 8, 'KV1', 'Код валюти (код)', 'CHAR', 3, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 9, 'S181', '1-короткостр. 2-довгостр. (код)', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 10, 'R013', 'Параметр R013 (код)', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 11, 'S240', 'Код сроку до погашення (код)', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 12, 'K030', 'Резидент нiсть (код)', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 13, 'R012', 'Вид рахунку (код)', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 14, 'ZNAP', 'Значення показника', 'VARCHAR2', 256, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 15, 'RNK', 'Реєстр. номер контрагента', 'NUMBER', 38, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 16, 'OKPO', 'ІНН контрагента', 'VARCHAR2', 14, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 17, 'NMK', 'ПІБ (назва) контрагента', 'VARCHAR2', 70, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 18, 'MDATE', 'Дата погашення', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 19, 'ISP', 'Код відп. виконавця', 'NUMBER', 38, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 20, 'ND', 'Номер кред. договору', 'NUMBER', 38, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 21, 'CC_ID', 'Ід. договору', 'VARCHAR2', 50, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 22, 'SDATE', 'Дата заключення договору', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 23, 'WDATE', 'Дата завершення договору', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 24, 'REF', 'Номер документу', 'NUMBER', 38, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 25, 'COMM', 'Коментар', 'VARCHAR2', 250, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 26, 'KF', 'Код фiлiалу (МФО)', 'VARCHAR2', 6, NULL, NULL, 'Y', 'N', NULL, NULL, 'N/A', 2, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (&&sfile_id);

Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (566, 'a7upl(DATF)_$_bankdates(FDAT)', 1, 342);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (566, 'a7upl(TOBO)_$_branch(BRANCH)', 1, 103);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (566, 'a7upl(KV)_$_tabval(KV)', 1, 296);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (566, 'a7upl(ACC,KF)_$_accounts(ACC,KF)', 1, 102);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (566, 'a7upl(NBS)_$_klr020(R020)', 1, 107);
-- Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (566, 'a7upl(KV1)_$_tabval(KV)', 1, 296);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (566, 'a7upl(S240)_$_kls240(S240)', 1, 396);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (566, 'a7upl(RNK,KF)_$_custmer(RNK,KF)', 1, 121);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (566, 'a7upl(ISP,KF)_$_staff(ISP,KF)', 1, 181);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (566, 'a7upl(ISP)_$_staffad(ISP)', 1, 182);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (&&sfile_id);

Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (566, 'a7upl(DATF)_$_bankdates(FDAT)', 1, 'DATF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (566, 'a7upl(TOBO)_$_branch(BRANCH)', 1, 'TOBO');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (566, 'a7upl(KV)_$_tabval(KV)', 1, 'KV');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (566, 'a7upl(ACC,KF)_$_accounts(ACC,KF)', 1, 'ACC');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (566, 'a7upl(ACC,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (566, 'a7upl(NBS)_$_klr020(R020)', 1, 'NBS');
--Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (566, 'a7upl(KV1)_$_tabval(KV)', 1, 'KV1');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (566, 'a7upl(S240)_$_kls240(S240)', 1, 'S240');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (566, 'a7upl(RNK,KF)_$_custmer(RNK,KF)', 1, 'RNK');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (566, 'a7upl(RNK,KF)_$_custmer(RNK,KF)', 2, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (566, 'a7upl(ISP,KF)_$_staff(ISP,KF)', 1, 'ISP');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (566, 'a7upl(ISP,KF)_$_staff(ISP,KF)', 2, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (566, 'a7upl(ISP)_$_staffad(ISP)', 1, 'ISP');

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
