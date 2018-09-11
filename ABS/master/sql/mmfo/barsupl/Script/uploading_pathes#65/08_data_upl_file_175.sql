-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 175
--define ssql_id  = 175,1175

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 175');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (175))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 175,1175');
end;
/
-- ***************************************************************************
-- ETL-25798  UPL - изменение выгрузки ARRACC2 для ND_TYPE=9
-- По требованию ХД создан новый файл ARRACC6
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (175,1175);

declare l_clob clob;
begin
l_clob:= to_clob('with dt  as ( select bars_upload_usr.get_last_work_date(to_date(:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date(:param1, ''dd/mm/yyyy'') dt2 from dual ),
     kf  as ( select /*+ materialize */
                     coalesce( bars.gl.kf, bars_upload.get_param(''KF''), (select kf from barsupl.upl_regions where CODE_CHR = bars_upload.get_param(''REGION_PRFX''))) kf
              from dual),
     cpd as ( select nd, vla as acc, kf, nd_type, chgaction, COLL
                from ( select REF nd, 9 nd_type, bars.gl.kf kf, chgaction,
                              acc, accd, accp, accr, accs, accr2, ACCEXPN, ACCEXPR, accr3, accunrec, ACCS5, ACCS6
                         from BARS.CP_DEAL_UPDATE
                        where IDUPD in ( select MAX(idupd)
                                           from BARS.CP_DEAL_UPDATE, dt
                                          where EFFECTDATE <= dt.dt2
                                          group by ref )
                          and active <> 0
                      )
              UNPIVOT (VLA FOR COLL IN (acc, accd, accp, accr, accs, accr2, ACCEXPN, ACCEXPR, accr3, accunrec, ACCS5, ACCS6)))
select ND, ACC, KF, ND_TYPE, max(CHGACTION)
  from ( select ND, ACC, KF, ND_TYPE, CHGACTION
          from cpd
         union
         select ND, ACC, KF, ND_TYPE, CHGACTION
           from ( select v.CP_REF as ND, v.CP_ACC as ACC, v.KF, 9 as ND_TYPE, v.CHGACTION,
                         row_number() over (partition by v.cp_ref, v.cp_acc order by idupd desc) rn
                    from bars.CP_ACCOUNTS_UPDATE v, dt, kf
                   where v.EFFECTDATE <= dt.dt2
                     and v.KF = KF.KF
                     and v.CP_ACCTYPE != ''GAR''
                )
           where rn = 1)
 group by ND, ACC, KF, ND_TYPE');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (175, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   NULL, 'Зв''язок рахунків з угодами цінних паперів', '1.0');

end;
/

declare l_clob clob;
begin
l_clob:= to_clob('with dt  as ( select bars_upload_usr.get_last_work_date(to_date(:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date(:param1, ''dd/mm/yyyy'') dt2 from dual ),
     kf  as ( select /*+ materialize */
                     coalesce( bars.gl.kf, bars_upload.get_param(''KF''), (select kf from barsupl.upl_regions where CODE_CHR = bars_upload.get_param(''REGION_PRFX''))) kf
              from dual),
     cpd as ( select nd, vla as acc, kf, nd_type, chgaction, COLL
                from ( select REF nd, 9 nd_type, bars.gl.kf kf, chgaction,
                              acc, accd, accp, accr, accs, accr2, ACCEXPN, ACCEXPR, accr3, accunrec, ACCS5, ACCS6
                         from BARS.CP_DEAL_UPDATE
                        where IDUPD in ( select MAX(idupd)
                                           from BARS.CP_DEAL_UPDATE, dt
                                          where EFFECTDATE between dt.dt1 and dt.dt2
                                          group by ref )
                          and active <> 0
                      )
              UNPIVOT (VLA FOR COLL IN (acc, accd, accp, accr, accs, accr2, ACCEXPN, ACCEXPR, accr3, accunrec, ACCS5, ACCS6)))
select ND, ACC, KF, ND_TYPE, max(CHGACTION)
  from ( select ND, ACC, KF, ND_TYPE, CHGACTION
          from cpd
         union
         select ND, ACC, KF, ND_TYPE, CHGACTION
           from ( select v.CP_REF as ND, v.CP_ACC as ACC, v.KF, 9 as ND_TYPE, v.CHGACTION,
                         row_number() over (partition by v.cp_ref, v.cp_acc order by idupd desc) rn
                    from bars.CP_ACCOUNTS_UPDATE v, dt, kf
                   where v.GLOBALBD   >= dt.dt1
                     and v.EFFECTDATE <= dt.dt2
                     and v.KF = KF.KF
                     and v.CP_ACCTYPE != ''GAR''
                )
           where rn = 1)
 group by ND, ACC, KF, ND_TYPE');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (1175, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   NULL, 'Зв''язок рахунків з угодами цінних паперів (Дельта)', '1.0');

end;
/

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (175);

Insert into BARSUPL.UPL_FILES
   (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, 
    DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, 
    ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, 
    SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values
   (175, 175, 'ARRACC6', 'arracc6', 0, 
    '09', NULL, '10', 0, 'Зв''язок рахунків з угодами цінних паперів', 
    175, 'null', 'DELTA', 'ARR', 1, 
    NULL, 1, 'arraccrln', 1, 1);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (175);

Insert into BARSUPL.UPL_COLUMNS(FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (175, 1, 'ND', 'Номер договора', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, '0', 2, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS(FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (175, 2, 'ACC', 'Внутренний номер счета', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, '0', 4, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS(FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (175, 3, 'KF', 'Код филиала', 'VARCHAR2', 6, NULL, NULL, 'Y', 'N', NULL, NULL, '-', 3, NULL);
Insert into BARSUPL.UPL_COLUMNS(FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (175, 4, 'ND_TYPE', 'Тип договора', 'NUMBER', 2, 0, NULL, 'Y', 'N', NULL, NULL, '0', 1, NULL);
Insert into BARSUPL.UPL_COLUMNS(FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (175, 5, 'CHGACTION', 'Тип изменений', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (175);

Insert into BARSUPL.UPL_CONSTRAINTS (FILE_ID, CONSTR_NAME, PRIORITY, FK_FILEID) Values  (175, 'arracc6(ACC,KF)_$_account(ACC,KF)', 1, 102);
Insert into BARSUPL.UPL_CONSTRAINTS (FILE_ID, CONSTR_NAME, PRIORITY, FK_FILEID) Values  (175, 'arracc6(KF)_$_banks(KF)', 1, 402);
Insert into BARSUPL.UPL_CONSTRAINTS (FILE_ID, CONSTR_NAME, PRIORITY, FK_FILEID) Values  (175, 'arracc6(ND_TYPE,ND,KF)_$_cpdeal(ND_TYPE,REF,KF)', 1, 146);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (175);

Insert into BARSUPL.UPL_CONS_COLUMNS (FILE_ID, CONSTR_NAME, FK_COLID, FK_COLNAME) Values (175, 'arracc6(ACC,KF)_$_account(ACC,KF)', 1, 'ACC');
Insert into BARSUPL.UPL_CONS_COLUMNS (FILE_ID, CONSTR_NAME, FK_COLID, FK_COLNAME) Values (175, 'arracc6(ACC,KF)_$_account(ACC,KF)', 2, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS (FILE_ID, CONSTR_NAME, FK_COLID, FK_COLNAME) Values (175, 'arracc6(KF)_$_banks(KF)', 1, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS (FILE_ID, CONSTR_NAME, FK_COLID, FK_COLNAME) Values (175, 'arracc6(ND_TYPE,ND,KF)_$_cpdeal(ND_TYPE,REF,KF)', 1, 'ND_TYPE');
Insert into BARSUPL.UPL_CONS_COLUMNS (FILE_ID, CONSTR_NAME, FK_COLID, FK_COLNAME) Values (175, 'arracc6(ND_TYPE,ND,KF)_$_cpdeal(ND_TYPE,REF,KF)', 2, 'ND');
Insert into BARSUPL.UPL_CONS_COLUMNS (FILE_ID, CONSTR_NAME, FK_COLID, FK_COLNAME) Values (175, 'arracc6(ND_TYPE,ND,KF)_$_cpdeal(ND_TYPE,REF,KF)', 3, 'KF');

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (175);

Insert into BARSUPL.UPL_FILEGROUPS_RLN(GROUP_ID, FILE_ID, SQL_ID) Values (1, 175,  175);
Insert into BARSUPL.UPL_FILEGROUPS_RLN(GROUP_ID, FILE_ID, SQL_ID) Values (2, 175, 1175);
Insert into BARSUPL.UPL_FILEGROUPS_RLN(GROUP_ID, FILE_ID, SQL_ID) Values (3, 175,  175);
Insert into BARSUPL.UPL_FILEGROUPS_RLN(GROUP_ID, FILE_ID, SQL_ID) Values (4, 175, 1175);

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
