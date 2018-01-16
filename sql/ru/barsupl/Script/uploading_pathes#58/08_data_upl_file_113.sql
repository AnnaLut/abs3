-- ***************************************************************************
set verify off
set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
define sfile_id = 113
define ssql_id  = 113,1113

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
-- ETL-21872  BUG - дубли дублей (много дублей) по фин. дебиторке.
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

declare l_clob clob;
begin
l_clob:= to_clob('with dt  as ( select bars_upload_usr.get_last_work_date(to_date(:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date(:param1, ''dd/mm/yyyy'') dt2 from dual ),
     --все счета ФДЗ по маппингу
     ac1 as ( select unique a.ACC  -- все тела
                from BARS.ACCOUNTS a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_N,1,4) = a.nbs AND SubStr(f.nbs_N,5,2) = a.ob22 )
               --where f.MOD_ABS in ( 0, 1, 4, 5, 6 )
              union
              select unique a.ACC  -- все просрочки, которые не привязаны в PRVN_FIN_DEB
                from dt, BARS.ACCOUNTS a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_P,1,4) = a.nbs AND SubStr(f.nbs_P,5,2) = a.ob22 )
               where ( a.DAZS Is Null or a.DAZS >= dt.dt2 )
                 --and f.MOD_ABS in ( 0, 1, 4, 5, 6 )
                 and f.nbs_P Is NOt Null
                 and a.ACC not In ( select ACC_SP from BARS.PRVN_FIN_DEB where ACC_SP is not null )
              union
              select unique b.ACC_SS
                from BARS.PRVN_FIN_DEB b
                ),
     --счета ФДЗ в архиве с датой выноса в архив (считаем датой закрытия договора), по которым разрушена связь в PRVN_FIN_DEB
     ac2 as ( select b.ACC_SS as acc, max(b.CLS_DT) as CLS_DT --все тела
                from BARS.PRVN_FIN_DEB_ARCH b
               group by b.ACC_SS
              union
              select b.ACC_SP, max(b.CLS_DT) as CLS_DT        -- все просрочки, которые не привязаны в PRVN_FIN_DEB
                from BARS.PRVN_FIN_DEB_ARCH b
               where b.ACC_SP not in ( select ACC_SP from BARS.PRVN_FIN_DEB where ACC_SP is not null)
               group by b.ACC_SP),
     ac0 as ( select /*+ materialise */ acc from ac1 union select acc from ac2),
     --счета из архива, которые не проходят по маппингу (надо прислать с D)
     ac3 as ( select /*+ materialise */ ac2.acc, ac2.CLS_DT from ac2 left join ac1 on (ac2.acc = ac1.acc) where ac1.acc is null )
select 17 as ND_TYPE,
       a.ACC as ND,
       a.KF,
       a.DAOS  as SDATE,
       a.MDATE as WDATE,
       case
         when ac3.CLS_DT Is Not Null and f.ACC_SS Is Null                             then ac3.CLS_DT
         when ( a.DAZS Is Not Null AND f.ACC_SP Is Null )                             then a.DAZS
         when ( a.DAZS Is Not Null AND f.ACC_SP Is Not Null AND p.DAZS Is Not Null )  then greatest(a.DAZS,p.DAZS)
         else Null
       end     as DATE_CLOSE,
       case
         when ac3.CLS_DT Is Not Null and f.ACC_SS Is Null                             then 15
         when ( a.DAZS Is Not Null AND f.ACC_SP Is Null )                             then 15
         when ( a.DAZS Is Not Null AND f.ACC_SP Is Not Null AND p.DAZS Is Not Null )  then 15
         else 10
       end     as SOS,
       a.NlS   as CC_ID,
       a.RNK,
       a.BRANCH
  from dt, BARS.ACCOUNTS_UPDATE a
  left  join BARS.PRVN_FIN_DEB f      on ( f.ACC_SS = a.ACC )
  left  join BARS.ACCOUNTS p          on ( p.ACC = f.ACC_SP )
  left  join ac3                      on ( ac3.ACC = a.ACC )
 where a.IDUPD in ( select max(u.IDUPD)
                      from BARS.ACCOUNTS_UPDATE u, dt, ac0
                     where u.effectdate <= dt.dt2
                       and u.ACC = ac0.acc
                     group by u.ACC )
   and a.DAOS <= dt.dt2');

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (113, l_clob, 'begin
  barsupl.bars_upload_usr.tuda;
  BARS.prvn_flow.ADD_FIN_DEB( to_date(:param1,''dd/mm/yyyy'') );
  commit;
  exception when
      others then
       if sqlcode = -6550
           then null;
           else raise;
       end if;
end;', NULL, 'Фінансова дебіторська заборгованість (full)', '1.6');

end;
/


declare l_clob clob;
begin
l_clob:= to_clob('with dt  as ( select bars_upload_usr.get_last_work_date(to_date(:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date(:param1, ''dd/mm/yyyy'') dt2 from dual ),
     ac  as ( select /*+ materialise */ au.acc, au.nbs, au.ob22, au.DAZS, au.globalbd, au.effectdate, au.daos  from BARS.ACCOUNTS_UPDATE au, dt where au.globalbd >= dt.dt1 and au.effectdate <= dt.dt2 ),
     --измененные счета ФДЗ по маппингу
     ac1 as ( select unique a.ACC
                from ac a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_N,1,4) = a.nbs AND SubStr(f.nbs_N,5,2) = a.ob22 )
               --where f.MOD_ABS in ( 0, 1, 4, 5, 6 )
              union
              select unique a.ACC
                from dt, ac a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_P,1,4) = a.nbs AND SubStr(f.nbs_P,5,2) = a.ob22 )
               where ( a.DAZS Is Null or a.DAZS >= dt.dt2 )
                 --and f.MOD_ABS in ( 0, 1, 4, 5, 6 )
                 and f.nbs_P Is NOt Null
                 and a.ACC not In ( select ACC_SP from BARS.PRVN_FIN_DEB where ACC_SP is not null )
              union
              select unique b.ACC_SS
                from BARS.PRVN_FIN_DEB b, dt
               where b.EFFECTDATE between dt.dt2 and bars.gl.bd
               ),
     --счета ФДЗ в архиве с датой выноса в архив (считаем датой закрытия договора), по которым разрушена связь в PRVN_FIN_DEB
     ac2 as ( select b.ACC_SS as acc, max(b.CLS_DT) as CLS_DT --все тела
                from BARS.PRVN_FIN_DEB_ARCH b, dt
               where b.CLS_DT between dt.dt2 and bars.gl.bd
               group by b.ACC_SS
              union
              select b.ACC_SP, max(b.CLS_DT) as CLS_DT        -- все просрочки, которые не привязаны в PRVN_FIN_DEB
                from BARS.PRVN_FIN_DEB_ARCH b, dt
               where b.CLS_DT between dt.dt2 and bars.gl.bd
                 and b.ACC_SP not in ( select ACC_SP from BARS.PRVN_FIN_DEB where ACC_SP is not null)
               group by b.ACC_SP),
     ac0 as ( select /*+ materialise */ acc from ac1 union select acc from ac2),
     --счета из архива, которые не проходят по маппингу (надо прислать с D)
     ac3 as ( select /*+ materialise */ ac2.acc, ac2.CLS_DT from ac2 left join ac1 on (ac2.acc = ac1.acc) where ac1.acc is null )
select 17 as ND_TYPE,
       a.ACC as ND,
       a.KF,
       a.DAOS  as SDATE,
       a.MDATE as WDATE,
       case
         when ac3.CLS_DT Is Not Null and f.ACC_SS Is Null                             then ac3.CLS_DT
         when ( a.DAZS is Not Null AND f.ACC_SP is Null )                             then a.DAZS
         when ( a.DAZS is Not Null AND f.ACC_SP is Not Null AND p.DAZS is Not Null )  then greatest(a.DAZS,p.DAZS)
         else Null
       end     as DATE_CLOSE,
       case
         when ac3.CLS_DT Is Not Null and f.ACC_SS Is Null                             then 15
         when ( a.DAZS is Not Null AND f.ACC_SP is Null )                             then 15
         when ( a.DAZS is Not Null AND f.ACC_SP is Not Null AND p.DAZS is Not Null )  then 15
         else 10
       end     as SOS,
       a.NlS   as CC_ID,
       a.RNK,
       a.BRANCH
  from dt, BARS.ACCOUNTS_UPDATE a
  left  join BARS.PRVN_FIN_DEB f      on ( f.ACC_SS = a.ACC )
  left  join BARS.ACCOUNTS p          on ( p.ACC = f.ACC_SP )
  left  join ac3                      on ( ac3.ACC = a.ACC )
 where a.IDUPD in ( select max(u.IDUPD)
                      from BARS.ACCOUNTS_UPDATE u, dt, ac0
                     where u.effectdate <= dt.dt2
                       and u.ACC = ac0.acc
                     group by u.ACC )
   and a.DAOS <= dt.dt2');

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (1113, l_clob, 'begin
 barsupl.bars_upload_usr.tuda;
 BARS.prvn_flow.ADD_FIN_DEB( to_date(:param1,''dd/mm/yyyy'') );
 commit;
 exception
  when others then
   if sqlcode = -6550
     then null;
     else raise;
   end if;
end;', NULL, 'Фінансова дебіторська заборгованість (part)', '1.6');

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
