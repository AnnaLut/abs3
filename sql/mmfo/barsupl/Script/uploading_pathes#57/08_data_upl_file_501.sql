-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
define sfile_id = 501
define ssql_id  = 501,1501

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
--ETL-19975 UPL - выделить в выгрузке для DWH договора внешних заимствований
-- CC_TRANS/transh (501) Транши выдачи кредита
-- добавлено условие на определение parent_type в зависимости от vidd (раньше ставился 3)
-- (изменилась привязка с credits на credkz)
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);


Insert into UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (501, 'with dt as ( select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
select 7 TYPE,
       cc.NPP,
       cc.REF,
       cc.ACC,
       cc.FDAT,
       cc.SV,
       cc.SZ,
       cc.D_PLAN,
       cc.D_FAKT,
       cc.REFP,
       bars.gl.kf kf,
       n.nd,
       c.rnk,
       c.branch,
       0 svq,
       0 szq,
       decode(c.vidd, 26, 19, 10, 10, 110, 10, 3) as parent_type,
       cc.CHGACTION
  from BARS.CC_TRANS_update cc,
       ( select n.nd, n.acc
           from BARS.ND_ACC_UPDATE n
          where idupd in ( select MAX (idupd)
                             from bars.nd_acc_update, dt
                             where effectdate <= dt.dt2
                            group by nd, acc )
            and chgaction <> ''D''
       ) n,
       ( select c.nd, c.branch, c.rnk, c.vidd
           from bars.cc_deal_update c
          where idupd in ( select MAX (idupd)
                             from bars.cc_deal_update, dt
                             where effectdate <= dt.dt2
                            group by nd )
       ) c,
       dt
 where n.acc = cc.acc
   and n.nd = c.nd
   and cc.idupd in ( select MAX(idupd)
                       from BARS.CC_TRANS_UPDATE, dt
                      where effectdate <= dt.dt2
                      group by npp )
   and ( ( cc.effectdate < dt.dt2 and cc.chgaction <> ''D'' )
        or cc.effectdate = dt.dt2 )',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
 NULL, 'Транши выдачи кредита', '2.8');

Insert into UPL_SQL   (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (1501, 'with dt as ( select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
select 7 TYPE,
       cc.NPP,
       cc.REF,
       cc.ACC,
       cc.FDAT,
       cc.SV,
       cc.SZ,
       cc.D_PLAN,
       cc.D_FAKT,
       cc.REFP,
       bars.gl.kf kf,
       n.nd,
       c.rnk,
       c.branch,
       0 svq,
       0 szq,
       decode(c.vidd, 26, 19, 10, 10, 110, 10, 3) as parent_type,
       cc.chgaction
  from BARS.CC_TRANS_UPDATE cc
  join ( select n.nd, n.acc
           from BARS.ND_ACC_UPDATE n
          where idupd in ( select MAX(idupd)
                             from bars.nd_acc_update, dt
                            where effectdate <= dt.dt2
                            group by nd, acc )
            and chgaction <> ''D''
       ) n on ( n.ACC = cc.ACC )
  join ( select c.nd, c.branch, c.rnk, c.vidd
           from BARS.CC_DEAL_UPDATE c
          where idupd in ( select MAX(idupd)
                             from bars.cc_deal_update, dt
                            where effectdate <= dt.dt2
                            group by nd )
       ) c on ( c.ND = n.ND )
 where cc.idupd in ( select MAX(idupd)
                       from BARS.CC_TRANS_UPDATE, dt
                      where EFFECTDATE = dt.dt2
                      group by NPP )',
  'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
  NULL, 'Транши выдачи кредита', '2.8');

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
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (&&sfile_id);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (501, 'transh(ACC,KF)_$_accounts(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (501, 'transh(BRANCH)_$_branch(BRANCH)', 1, 103);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (501, 'transh(FDAT)_$_bankdates(FDAT)', 1, 342);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (501, 'transh(KF,RNK)_$_customer(KF,RNK)', 1, 121);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (501, 'transh(PARENT_TYPE,ND,KF)_$_credkz(TYPE,ND, KF)', 1, 161);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (&&sfile_id);
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (501, 'transh(ACC,KF)_$_accounts(ACC,KF)', 1, 'ACC');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (501, 'transh(ACC,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (501, 'transh(BRANCH)_$_branch(BRANCH)', 1, 'BRANCH');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (501, 'transh(FDAT)_$_bankdates(FDAT)', 1, 'FDAT');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (501, 'transh(KF,RNK)_$_customer(KF,RNK)', 1, 'RNK');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (501, 'transh(KF,RNK)_$_customer(KF,RNK)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (501, 'transh(PARENT_TYPE,ND,KF)_$_credkz(TYPE,ND, KF)', 1, 'PARENT_TYPE');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (501, 'transh(PARENT_TYPE,ND,KF)_$_credkz(TYPE,ND, KF)', 2, 'ND');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (501, 'transh(PARENT_TYPE,ND,KF)_$_credkz(TYPE,ND, KF)', 3, 'KF');

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
