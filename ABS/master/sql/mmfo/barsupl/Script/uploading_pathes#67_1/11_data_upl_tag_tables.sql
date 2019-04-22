-- ***************************************************************************
set verify off

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for UPL_TAG_TABLES');
end;
/

-- ======================================================================================
-- Депозиты ММСБ
-- TSK-0001183 ANL - анализ выгрузки депозитных линий ММСБ
-- TSK-0003096 UPL - зробити вивантаження договорів депозитиних ліній (траншів), поточних рахунків та їх параметрів із нового модуля депозитів ММСБ
-- ======================================================================================

delete
  from barsupl.upl_tag_tables
 where tag_table in ('SMB_TRANCHE', 'SMB_ON_DEMAND');

Insert into UPL_TAG_TABLES   (tag_table, descript) Values   ('SMB_TRANCHE', 'Депозити ММСБ траншеві');
Insert into UPL_TAG_TABLES   (tag_table, descript) Values   ('SMB_ON_DEMAND', 'Депозити ММСБ на вимогу');
