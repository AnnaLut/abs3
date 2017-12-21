-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
define sfile_id = 281
define ssql_id  = 281,1281

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
-- ETL-20761  UPL - необходимо убрать ограничения с выгрузки графиков (файл src_shedule)
-- 
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

declare l_clob clob;
begin
  l_clob:= to_clob('with dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1,''dd/mm/yyyy''))+1 dt1,
                    to_date(:param1,''dd/mm/yyyy'') dt2,
                    bars.gl.kf kf  from dual),
  cc_nd as (select /*+ materialize */ u.nd, u.kf
              from BARS.CC_LIM_UPDATE u, dt
             where u.effectdate <= dt.dt2
               and u.kf = dt.kf
             group by u.nd, u.kf),
     ac as (select d.nd, a.acc, a.vid
              from cc_nd d,
                   BARS.ND_ACC n,
                   bars.accounts a,
                   dt
             where n.nd = d.nd
               and a.acc = n.acc
               and a.nls like ''8999%''
               and n.kf = dt.kf
               and a.kf = dt.kf
           )
select 3 type, cc.ND, cc.FDAT, cc.lim2, cc.SUMG, cc.SUMO, cc.OTM, cc.KF, cc.SUMK, ac.vid gpk_type
  from BARS.CC_LIM_UPDATE cc
  left join ac on (cc.nd = ac.nd)
 where cc.idupd in (select max(idupd) idupd
                      from BARS.CC_LIM_UPDATE l, cc_nd, dt
                     where l.nd = cc_nd.nd
                       and l.effectdate <= dt.dt2
                       and l.kf = dt.kf
                     group by l.ND, l.FDAT)
   and cc.chgaction <> ''D''');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (281, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   NULL, 'График Лимитов Кредитования (ГЛК),он же График Погашения Кредита (ГПК)', '4.0');
end;
/

declare l_clob clob;
begin
  l_clob:= to_clob('with dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1,''dd/mm/yyyy''))+1 dt1,
                    to_date(:param1,''dd/mm/yyyy'') dt2,
                    bars.gl.kf kf  from dual),
  cc_nd as (select /*+ materialize */ u.nd, u.kf
              from BARS.CC_LIM_UPDATE u, dt
             where u.effectdate = dt.dt2
               and u.kf = dt.kf
             group by u.nd, u.kf),
     ac as (select d.nd, a.acc, a.vid
              from cc_nd d,
                   BARS.ND_ACC n,
                   bars.accounts a,
                   dt
             where n.nd = d.nd
               and a.acc = n.acc
               and a.nls like ''8999%''
               and n.kf = dt.kf
               and a.kf = dt.kf
           )
select 3 type, cc.ND, cc.FDAT, cc.lim2, cc.SUMG, cc.SUMO, cc.OTM, cc.KF, cc.SUMK, ac.vid gpk_type
  from BARS.CC_LIM_UPDATE cc
  left join ac on (cc.nd = ac.nd)
 where cc.idupd in (select max(idupd) idupd
                      from BARS.CC_LIM_UPDATE l, cc_nd, dt
                     where l.nd = cc_nd.nd
                       and l.effectdate <= dt.dt2
                       and l.kf = dt.kf
                     group by l.ND, l.FDAT)
   and cc.chgaction <> ''D''');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (1281, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   NULL, 'График Лимитов Кредитования (ГЛК),он же График Погашения Кредита (ГПК)', '4.0');
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
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (&&sfile_id);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (281, 'creditshedule(KF)_$_banks(KF)', 2, 402);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (281, 'creditshedule(TYPE, ND, KF)_$_credkz(TYPE, ND, KF)', 3, 161);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (&&sfile_id);
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (281, 'creditshedule(KF)_$_banks(KF)', 1, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (281, 'creditshedule(TYPE, ND, KF)_$_credkz(TYPE, ND, KF)', 1, 'TYPE');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (281, 'creditshedule(TYPE, ND, KF)_$_credkz(TYPE, ND, KF)', 2, 'ND');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (281, 'creditshedule(TYPE, ND, KF)_$_credkz(TYPE, ND, KF)', 3, 'KF');

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
