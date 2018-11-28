-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 441
--define ssql_id  = 441,1441

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 441');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (441))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 441,1441');
end;
/
-- ***************************************************************************
-- TSK-0000906 UPL-Необходимо забрать в миррор в данные по ставке с типом "2" (Пеня/комиссия).
-- 
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (441,1441);

declare l_clob clob;
begin
l_clob:= to_clob('select a.acc, c.id,  to_date(:param1,''dd/mm/yyyy'')  bdat,
       0 isfixed,
       acrn.fprocn(a.acc, c.id,  to_date(:param1,''dd/mm/yyyy'')) nom,
       a.kf, nvl(basey,0) basey
  from bars.accounts a,
       bars.int_accn_update c
 where (a.dazs is null or a.dazs >= to_date(:param1,''dd/mm/yyyy''))
   and c.id in (2,1,0,-2)
   and c.acc = a.acc
   and c.idupd in (select /*+ full(u)*/max(u.idupd)
                   from bars.int_accn_update u
                  where u.effectdate <= to_date(:param1,''dd/mm/yyyy'')
                    and u.id in (2,1,0,-2)
                  group by u.id, u.acc)');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (441, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Відсоткові ставки', '3.4');

end;
/

declare l_clob clob;
begin
l_clob:= to_clob('with dt as ( select /*+ materialize */
                    bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1,
                    to_date (:param1, ''dd/mm/yyyy'') dt2,
                    bars.gl.kf kf from dual )
select kk.acc, kk.id, kk.bdat, 0 isfixed, acrn.fprocn(kk.acc, kk.id,  kk.bdat) rate_nom, kk.kf , nvl(ii.basey,0) basey
  from ( select r.acc, r.id, dt.dt2 bdat, dt.kf
           from ( -- установка % с новой датой действия (bdat)
                  select i.acc, i.id, i.kf
                    from bars.int_ratn i, dt
                   where i.bdat between dt.dt1 and dt.dt2
                   union
                  -- смена существующих условий на строку
                  /*-- вариант с кореляцией
                  select i.acc,i.id
                    from bars.int_ratn_arc i, dt
                   where i.idupd = (select max(idupd)
                                      from bars.int_ratn_arc iu, dt
                                     where iu.acc = i.acc
                                       and iu.id = i.id
                                       and iu.bdat between trunc(i.bdat) and trunc(i.bdat) + 0.99
                                       and global_bdate >=  dt.dt1
                                       and effectdate <= dt.dt2
                                   )
                     --and i.bdat < dt.dt2   -- смотрим смену только для уже существующих ставок */
                   --вариант с аналитикой
                  select i.acc,i.id, i.kf
                    from ( select iu.*, max(iu.idupd) over (partition by iu.acc, iu.id) mx
                             from bars.int_ratn_arc iu, dt
                            where global_bdate >= dt.dt1 and
                                  effectdate   <= dt.dt2
                         ) i
                   where i.idupd = i.mx
                   union
                  select unique r.acc, r.id, r.kf
                    from bars.int_ratn r,
                         (select /* materialize */ br_id from bars.brates b where b.br_type <> 1 /* все br_id с плавающей % ставкой */
                           union
                          select distinct BR_ID                                /* все br_id где изменилось значение простой % ставки */
                            from bars.BR_NORMAL_EDIT_UPDATE u, dt
                           where u.EFFECTDATE <= dt.dt2
                             and u.CHGDATE >= dt.dt2
                           group by u.BR_ID, u.KF
                         ) b
                   where r.br = b.br_id
                ) r
           join bars.accounts a on (r.acc = a.acc and r.kf = a.kf),
                dt
          where a.dazs  is  null
             or a.dazs >= dt.dt2
        ) kk
  join bars.int_accn ii on (kk.acc = ii.acc and kk.id  = ii.id)
 where kk.id in (2,1,0,-2)');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (1441, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Відсоткові ставки', '3.7');

end;
/

-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (441);

-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (441);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (441);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (441);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (441);

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
