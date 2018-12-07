-- ***************************************************************************
set verify off
--set define on
-- sfile_id ������������� ����� ��������
-- ssql_id �������������� �������� ��� ����� �������� (������ ����� �������, ��� ��������)
--define sfile_id = 7542
--define ssql_id  = 7542

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 7542');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (7542))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 7542');
end;
/
-- ***************************************************************************
-- TSK-0001182 UPL - ��������� �������� �0 (��� �������� Instalment)
-- TSK-0001495 UPL - ��������� �������� �0 (��� �������� Instalment) - ����������� ������ � ������ ��������
--  COBUINST-14 - ������������ ����� ��� �� �� �������� Instalment
--  �� ��������� ������������ ������� ��� ��������� Instalment
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (7542);

declare l_clob clob; l_clob1 clob;
begin
  l_clob:= to_clob('SELECT BARS.gl.kf as KF,
       p.PRD_TP   as ND_TYPE,
       case when p.PRD_TP = 23 then e.REF_AGR*100 else e.REF_AGR end as ND,
       e.EVENT_DATE,
       e.DAYS,
       e.DAYS_CORR
  FROM BARS.PRVN_LOSS_DELAY_DAYS e
  LEFT
  JOIN BARS.PRVN_OBJECT_TYPE p
    ON ( p.ID = e.OBJECT_TYPE)
 WHERE e.REPORTING_DATE = trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
   and e.zo=1');

   l_clob1:= to_clob('begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values (7542, l_clob, l_clob1, NULL, 'ʳ������ ��� ��������� �� ������ (��� FineVare)', '1.4');

end;
/

-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (7542);

-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (7542);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (7542);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (7542);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (7542);

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
