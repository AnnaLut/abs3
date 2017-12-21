-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
define sfile_id = 536
define ssql_id  = 536

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
-- ETL-20823 -UPL - выгрузить из АБС в ХД параметры договора/счёта для IFRS9: BUSINESS_MODEL, IFRS_CATEGORY, SPPI, Ринкова ставка (INTRT), Референс реструкт.договору (ND_REST) с соответствующими справочниками
-- добавляются теги в справочник выгружаемых в Т0
-- BUS_MOD,SPPI,IFRS,INTRT,ND_REST - для договорров
-- BUS_MOD,SPPI,IFRS - для ЦБ
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

declare l_clob clob;
begin
l_clob:= to_clob('with ACNTR013 as ( select a.ACC
                    from BARS.ACCOUNTS a
                   where (a.NBS in (''9129'', ''3510'', ''3519'')
                      or a.NBS like ''355%'' or a.tip = ''XOZ'' or a.tip = ''W4X'')
                     and a.DAOS < trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
                     and ( a.DAZS is Null or a.DAZS > to_date(:param1,''dd/mm/yyyy'') )
                 ),
     ACNTOB22 as ( select a.KF, a.ACC, a.OB22
                     from BARS.ACCOUNTS a
                    where (a.nbs in (''3600'',''9129'', ''3519'')
                       or a.NBS like ''355%'' or a.tip = ''XOZ'' or a.tip = ''W4X'')
                      and a.DAOS < trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
                 ),
     ACCW     as ( select u.kf, u.acc, p.param_id as PAR_ID, u.value as PAR_VAL
                     from BARS.ACCOUNTSW_UPDATE u
                     join barsupl.t0_upload_params p on (u.tag = p.param_name and p.object_id = 3)
                    where u.idupd in ( select MAX(u1.idupd)
                                         from BARS.ACCOUNTSW_UPDATE u1
                                         join BARS.ACCOUNTS a on (    u1.acc = a.acc
                                                                  and a.DAOS < trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
                                                                  and (a.DAZS is Null or a.DAZS >= trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')) )
                                        where u1.effectdate between trunc(to_date(:param1,''dd/mm/yyyy''),''MM'') and to_date(:param1,''dd/mm/yyyy'')
                                          and u1.tag in (''BUS_MOD'', ''SPPI'', ''IFRS'', ''INTRT'', ''ND_REST'')
                                        group by u1.acc, u1.tag )
                  )
select KF, ACC, 13 as PAR_ID, R013 as PAR_VAL
  from ( select KF, ACC, R013
           from BARS.SPECPARAM_UPDATE
          where IDUPD in ( select max(IDUPD)
                            from BARS.SPECPARAM_UPDATE p1
                            join ACNTR013 a
                              on ( a.ACC = p1.ACC )
                           where p1.EFFECTDATE <= to_date(:param1,''dd/mm/yyyy'')
                           group by p1.ACC )
          minus
         select KF, ACC, R013
           from BARS.SPECPARAM_UPDATE
          where IDUPD in ( select max(p0.IDUPD)
                            from BARS.SPECPARAM_UPDATE p0
                            join ACNTR013 a
                              on ( a.ACC = p0.ACC )
                           where p0.EFFECTDATE < trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
                           group by p0.ACC )
       )
 union all
select KF, ACC, 10 as PAR_ID, OB22 as PAR_VAL
  from ( select KF, ACC, OB22
           from BARS.ACCOUNTS_UPDATE
          where IDUPD in ( select max(a1.IDUPD)
                             from BARS.ACCOUNTS_UPDATE a1
                             join ACNTOB22 a
                               on ( a.ACC = a1.ACC )
                            where a1.EFFECTDATE <= to_date(:param1,''dd/mm/yyyy'')
                            group by a1.ACC )
          minus
         select KF, ACC, OB22
           from BARS.ACCOUNTS_UPDATE
          where IDUPD in ( select max(a0.IDUPD)
                             from BARS.ACCOUNTS_UPDATE a0
                             join ACNTOB22 a
                               on ( a.ACC = a0.ACC )
                            where a0.EFFECTDATE < trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
                            group by a0.ACC )
       )
 union all
select KF, ACC,
       case
         when ID =  0 then 11
         when ID = -2 then 12
         else null
       end as PAR_ID,
       to_char(IR,''FM99999900D009999999999'') as PAR_VAL
  from BARS.INT_RATN_ARC
 where IDUPD in ( select max(ir.IDUPD)
                    from BARS.INT_RATN_ARC ir
                   where ir.EFFECTDATE between trunc(to_date(:param1,''dd/mm/yyyy''),''MM'') and to_date(:param1,''dd/mm/yyyy'')
                     and ir.BDAT < trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
                     and ir.ID in ( 0, -2 )
                   group by ir.ACC, ir.ID )
   and IR is Not Null
 union all
select kf, acc, PAR_ID, PAR_VAL
  from ACCW');

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (536, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
    NULL, 'Змінені параметри рахунків (для FineVare)', '1.7');
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
