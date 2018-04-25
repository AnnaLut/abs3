-- ***************************************************************************
set verify off
--set define on

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for T0_NBS_LIST');
end;
/

-- ======================================================================================
-- ETL-23384 BR - ��������� ����������� T0_NBS_LIST
-- ��� ����� 3600 �������� ��22 "9" �� "09"
-- ======================================================================================

delete 
  from barsupl.T0_NBS_LIST 
 where trim(NBS)  in ('3600')
   and trim(OB22) in ('9', '09');

Insert into BARSUPL.T0_NBS_LIST (nbs, ob22) Values ('3600', '09');
