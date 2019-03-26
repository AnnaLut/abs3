-- ***************************************************************************
set verify off
--set define on
-- sfile_id ������������� ����� ��������
-- ssql_id �������������� �������� ��� ����� �������� (������ ����� �������, ��� ��������)
--define sfile_id = 570
--define ssql_id  = 570,1570

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 570');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (570))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 570,1570');
end;
/
-- ***************************************************************************
-- ETL-24968 UPL - ���� ������������ ����� FIN_CALC
-- 
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (570,1570);

Insert into BARSUPL.UPL_SQL(SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
Values (570, 'with dt as ( select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
select bars.gl.kf as KF, to_char(to_number(coalesce(c.okpo, fc.okpo)),''fm99999999999999'') OKPO, f.DAT dat, max(f.FDAT) fdat, max(f.DATD) datd
from dt, BARS.FIN_CALCULATIONS f
left join bars.customer c on ( f.rnk = c.rnk )
left join bars.FIN_cust fc on ( -f.rnk = to_number(fc.okpo) )
where (c.rnk is not null or fc.okpo is not null)
group by bars.gl.kf, to_char(to_number(coalesce(c.okpo, fc.okpo)),''fm99999999999999''), f.DAT', 
'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', 
NULL, '������� ��������� ����� ������ ������� "���������� ��������"', '2.0');
Insert into BARSUPL.UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
Values (1570, 'with dt as ( select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
select bars.gl.kf as KF, to_char(to_number(coalesce(c.okpo, fc.okpo)),''fm99999999999999'') OKPO, f.DAT dat, max(f.FDAT) fdat, max(f.DATD) datd
from dt, BARS.FIN_CALCULATIONS f
left join bars.customer c on ( f.rnk = c.rnk and f.rnk > 0 )
left join bars.FIN_cust fc on ( -f.rnk = to_number(fc.okpo) and f.rnk<0 )
where f.FDAT >= dt.dt1
and (c.rnk is not null or fc.okpo is not null)
group by bars.gl.kf, to_char(to_number(coalesce(c.okpo, fc.okpo)),''fm99999999999999''), f.DAT', 
'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', 
NULL, '������� ��������� ����� ������ ������� "���������� ��������" (������)', '2.0');



-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (570);

-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (570);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (570);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (570);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (570);

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