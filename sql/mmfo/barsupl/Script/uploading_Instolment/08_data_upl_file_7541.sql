-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 7541
--define ssql_id  = 7541

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 7541');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (7541))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 7541');
end;
/

-- ***************************************************************************
-- TSK-0001182 UPL - изменение выгрузки Т0 (для кредитов Instalment)
-- TSK-0001495 UPL - изменение выгрузки Т0 (для кредитов Instalment) - номинальная ставка и ставка комиссий
--  COBUINST-14 - Вивантаження даних для СД по продукту Instalment
--  не обрезають региональные суфиксы для договоров Instalment
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (7541);


declare l_clob clob; l_clob1 clob;
begin
  l_clob:= to_clob('select bars.gl.kf    as kf,
       p.prd_tp      as nd_type,
       case when p.prd_tp = 23 then e.ref_agr*100 else e.ref_agr end as nd,
       e.event_type  as event_type,
       min(e.event_date)    keep (dense_rank first order by e.event_date    asc  nulls last)  as event_date,
       max(e.restr_end_dat) keep (dense_rank first order by e.restr_end_dat desc nulls first) as restr_end,
       e.rnk
  from bars.prvn_automatic_event e
       left join bars.prvn_object_type p  on ( p.id = e.object_type)
 where e.reporting_date = trunc(to_date(:param1,''dd/mm/yyyy''), ''MM'') --выгрузка за первое число текущего месяца
   and e.zo=1
 group by bars.gl.kf, p.prd_tp, e.ref_agr, e.event_type, e.rnk');

  l_clob1 := to_clob('declare
  l_report_date    date;  -- звітна дата
begin
  barsupl.bars_upload_usr.tuda;
  l_report_date := trunc(to_date(:param1,''dd/mm/yyyy''),''MM'');
  -- Визначення критеріїв дефолту (з коригуючими)
  BARS.BARS_LOSS_EVENTS.loss_events( l_report_date, 1 );
  commit;
end;');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values (7541, l_clob, l_clob1, NULL, 'Події дефолту (для FineVare)', '1.8');

end;
/

-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (7541);

-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (7541);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (7541);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (7541);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (7541);

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
