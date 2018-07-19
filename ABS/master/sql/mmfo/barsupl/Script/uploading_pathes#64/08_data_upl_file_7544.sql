-- ***************************************************************************
set verify off
--set define on
-- sfile_id ������������� ����� ��������
-- ssql_id �������������� �������� ��� ����� �������� (������ ����� �������, ��� ��������)
--define sfile_id = 7544
--define ssql_id  = 7544

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 7544');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (7544))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 7544');
end;
/
-- ***************************************************************************
-- ETL-24964  UPL - ��������� ����� ������� ���������� �������� �0 �� PRVN_DEALS(543, 7543) � PRVN_FLOW(544, 7544)
--
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (7544);

declare l_clob1 clob; l_clob2 clob;
begin
l_clob1:= to_clob('select 3 as ND_TYPE, 13 as PRVN_TP, bars.gl.kf as KF,
       p.ID,   p.ND,   p.FDAT, p.SS,
       p.SPD,  p.SN,   p.SK,   p.LIM1,
       p.LIM2, p.DAT1, p.DAT2, p.SPN,
       p.SNO,  p.SP,   p.SN1,  p.SN2,
       p.MDAT
  from BARS.PRVN_FLOW_DETAILS   p
 where p.MDAT = trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
   and Not ( p.SS  = 0 and p.SPD = 0 and p.SN = 0 and p.SK  = 0 and
             p.SPN = 0 and p.SNO = 0 and p.SP = 0 and p.SN1 = 0 and p.SN2 = 0 )');

l_clob2:= to_clob('declare
  l_report_date    date;  -- ����� ����
begin
  barsupl.bars_upload_usr.tuda;
  l_report_date := trunc(to_date(:param1,''dd/mm/yyyy''),''MM'');
  -- ����������� ��.������: ������
  BARS.PRVN_FLOW.SET_ADJ_SHD( l_report_date, 1 );
  commit;
end;');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values (7544, l_clob1, l_clob2, NULL, '������� �������� ������ ������� �� (��� FineVare)', '1.7');
end;
/

-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (7544);

-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (7544);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (7544);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (7544);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (7544);

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
