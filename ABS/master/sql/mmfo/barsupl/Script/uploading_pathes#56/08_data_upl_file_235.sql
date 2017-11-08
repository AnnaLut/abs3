-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую)
define sfile_id = 235
define ssql_id  = 235

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
-- ETL-20516  UPL - отрезать хвост SKRYND.N_SK (uploading_pathes#56)
-- SKRYNKA_ND
-- Добавлен предикат по KF
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

Insert into BARSUPL.UPL_SQL   (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (235, 'with kf as (select /*+ materialize */
                   coalesce( bars_upload.get_param(''KF''),
                            (select kf from barsupl.upl_regions where CODE_CHR = bars_upload.get_param(''REGION_PRFX''))
                           ) kf
              from dual)
select 18 type_id, n.ND, n.N_SK, n.SOS, n.FIO, n.DOKUM, n.ISSUED, n.ADRES, n.DAT_BEGIN, n.DAT_END, n.TEL, n.DOVER, n.NMK,
       n.DOV_DAT1, n.DOV_DAT2, n.DOV_PASP, n.MFOK, n.NLSK, n.CUSTTYPE, n.O_SK, n.ISP_DOV, n.NDOV, n.NLS, n.NDOC,
       n.DOCDATE, n.SDOC, n.TARIFF, n.FIO2, n.ISSUED2, n.ADRES2, n.PASP2, n.OKPO1, n.OKPO2, n.S_ARENDA, n.S_NDS,
       n.SD, n.KEYCOUNT, n.PRSKIDKA, n.PENY, n.DATR2, n.MR2, n.MR, n.DATR, n.ADDND, n.AMORT_DATE, n.BRANCH,
       n.KF, n.DAT_CLOSE, n.DEAL_CREATED, n.IMPORTED, n.RNK
  from bars.skrynka_nd n, kf
 where n.kf = kf.kf', 'begin execute immediate ''begin barsupl.bars_upload_usr.suda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
  'begin barsupl.bars_upload_usr.tuda(null); end;', 'Угоди оренди депозитних сейфів', '1.1');

-- ***********************
-- UPL_FILES
-- ***********************

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID=235 and COL_NAME= 'N_SK' ;

Insert into UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (235, 2, 'N_SK', 'Номер сейфу', 'NUMBER', 38, 0, NULL, NULL, 'N', NULL, NULL, 0, NULL, 'TRUNC_E2');

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
