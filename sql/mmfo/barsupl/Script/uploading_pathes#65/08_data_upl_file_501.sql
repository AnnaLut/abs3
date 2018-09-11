-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 501
--define ssql_id  = 501,1501,6501

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 501');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (501))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 501,1501,6501');
end;
/
-- ***************************************************************************
-- оптимизация CC_TRANS
-- 
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (501,1501,6501);

declare l_clob clob;
begin
l_clob:= to_clob('with dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2, bars.gl.kf kf from dual ),
    cc as ( select /*+ materialize parallell (12) */ cc.*  /* для полной */
               from dt, BARS.CC_TRANS_UPDATE cc
               join ( select MAX(idupd) idupd
                        from BARS.CC_TRANS_UPDATE, dt
                       where EFFECTDATE <= dt.dt2
                       group by NPP
                    ) cci on (cc.idupd = cci.idupd)
              where ( cc.effectdate < dt.dt2 and cc.chgaction <> ''D'' )
                 or cc.effectdate = dt.dt2
            ),
     n  as ( select /*+ materialize parallell (12) */ cc.*, n.nd
               from cc
               join ( select n.nd, n.acc, n.idupd
                        from BARS.ND_ACC_UPDATE n
                       where chgaction <> ''D''
                    ) n on ( n.ACC = cc.ACC )
               join ( select MAX(u.idupd) idupd
                        from bars.nd_acc_update u, dt, cc
                       where u.effectdate <= dt.dt2
                         and u.ACC = cc.ACC
                       group by u.nd, u.acc
                    ) ni on (n.idupd = ni.idupd)
            )
select 7 TYPE,
       n.NPP,
       n.REF,
       n.ACC,
       n.FDAT,
       n.SV,
       n.SZ,
       n.D_PLAN,
       n.D_FAKT,
       n.REFP,
       dt.kf,
       n.nd,
       c.rnk,
       c.branch,
       0 svq,
       0 szq,
       decode(c.vidd, 26, 19, 10, 10, 110, 10, 3) as parent_type,
       n.chgaction
  from dt, n
  join BARS.CC_DEAL_UPDATE c
       on ( c.ND = n.ND )
  join ( select MAX(u.idupd) idupd
           from bars.cc_deal_update u, dt, n
          where u.effectdate <= dt.dt2
            and u.ND = n.ND 
          group by u.nd
       ) ci on (c.idupd = ci.idupd)');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (501, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Транши выдачи кредита', '2.9');

end;
/

declare l_clob clob;
begin
l_clob:= to_clob('with dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2, bars.gl.kf kf from dual ),
     cc as ( select /*+ materialize parallell (12) */ cc.* /* для дельты */
               from dt, BARS.CC_TRANS_UPDATE cc
               join ( select MAX(idupd) idupd
                        from BARS.CC_TRANS_UPDATE, dt
                       where EFFECTDATE = dt.dt2
                       group by NPP
                    ) cci on (cc.idupd = cci.idupd)
            ),
     n  as ( select /*+ materialize parallell (12) */ cc.*, n.nd
               from cc
               join ( select n.nd, n.acc, n.idupd
                        from BARS.ND_ACC_UPDATE n
                       where chgaction <> ''D''
                    ) n on ( n.ACC = cc.ACC )
               join ( select MAX(u.idupd) idupd
                        from bars.nd_acc_update u, dt, cc
                       where u.effectdate <= dt.dt2
                         and u.ACC = cc.ACC
                       group by u.nd, u.acc
                    ) ni on (n.idupd = ni.idupd)
            )
select 7 TYPE,
       n.NPP,
       n.REF,
       n.ACC,
       n.FDAT,
       n.SV,
       n.SZ,
       n.D_PLAN,
       n.D_FAKT,
       n.REFP,
       dt.kf,
       n.nd,
       c.rnk,
       c.branch,
       0 svq,
       0 szq,
       decode(c.vidd, 26, 19, 10, 10, 110, 10, 3) as parent_type,
       n.chgaction
  from dt, n
  join BARS.CC_DEAL_UPDATE c
       on ( c.ND = n.ND )
  join ( select MAX(u.idupd) idupd
           from bars.cc_deal_update u, dt, n
          where u.effectdate <= dt.dt2
            and u.ND = n.ND 
          group by u.nd
       ) ci on (c.idupd = ci.idupd)');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (1501, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Транши выдачи кредита', '2.9');

end;
/

-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (501);

-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (501);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (501);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (501);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (501);

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
