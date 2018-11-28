-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 123
--define ssql_id  = 1123

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 123');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (123))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 1123');
end;
/
-- ***************************************************************************
-- Оптимизация
--   COBUMMFO-9670 Файли щоденного вивантаження Дельта по Києву не вивантажуються з 02.10.2018. По Донецьку та Дніпру також проблема з вивантаженнями за 04.10.
-- ETL-XXX видалив умову ... or (u1.chgdate     >= dt.dt1 and u1.chgdate    <  dt.dt2 + 1 )
-- 
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (1123);

Insert into BARSUPL.UPL_SQL(SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (1123, 'with dt as ( select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
     tabc as ( select /*+ index (cu IDX_CUSTOMERUPD_GLBDT_EFFDT)*/ cu.rnk
                 from bars.customer_update cu, dt
                where global_bdate >= dt.dt1
                  and (effectdate <= dt.dt2 or (effectdate > dt.dt2 and chgaction = 1))
                  and cu.custtype = 3
                group by rnk
             ),
     tabw as (select /*+ index (cwu XAI_CUSTOMERWUPD_EFFDAT)*/ cwu.rnk
                from bars.customerw_update cwu, dt
                where cwu.effectdate >= dt1
                  and cwu.effectdate < dt2+1
                  and cwu.tag in (select tag
                                    from barsupl.upl_tag_lists l
                                   where l.tag_table = ''CUST_FIELD'')
                group by cwu.rnk
             ),
     tabp as ( select /*+ index (cu IDX_PERSONUPD_GLBDT_EFFDT) */ cu.rnk
                 from bars.person_update cu, dt
                where cu.global_bdate >= dt.dt1
                  and (cu.effectdate <= dt.dt2 or (cu.effectdate > dt.dt2 and cu.chgaction = ''I''))
                group by cu.rnk
             ),
        t as (select rnk from tabc union select rnk from tabp union select rnk from tabw)
select u.rnk, u.sex, u.bday, u.passp, u.numdoc, u.ser, u.pdate, u.teld, u.telw, bars.gl.kf, u.organ, u.eddr_id
  from bars.person_update u
 where u.idupd in (select max(cu.idupd)
                     from bars.person_update cu, t, dt
                    where cu.rnk = t.rnk
                      and ( cu.effectdate   <= dt.dt2
                       or ( cu.global_bdate >= dt.dt1 and cu.chgaction = ''I''))
                    group by cu.rnk)', 
'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', 
NULL, 'Клієнти - фізичні особи', '3.8');

-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (123);

-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (123);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (123);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (123);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (123);

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
