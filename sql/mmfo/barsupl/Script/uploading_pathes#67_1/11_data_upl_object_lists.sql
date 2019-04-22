-- ***************************************************************************
set verify off

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for UPL_OBJECT_LISTS');
end;
/

-- ======================================================================================
-- Депозиты ММСБ
-- TSK-0001183 ANL - анализ выгрузки депозитных линий ММСБ
-- TSK-0003096 UPL - зробити вивантаження договорів депозитиних ліній (траншів), поточних рахунків та їх параметрів із нового модуля депозитів ММСБ
-- ======================================================================================

delete 
  from barsupl.upl_object_lists 
 where trim(type_code) in ('SMB_DEPOSIT_TRANCHE', 'SMB_DEPOSIT_ON_DEMAND');


-- параметры траншевых депозитов
insert into barsupl.upl_object_lists (TYPE_ID, TYPE_CODE, TYPE_NAME, IS_ACTIVE) values(24, 'SMB_DEPOSIT_TRANCHE', 'Депозитні транші ММСБ', 'Y');
insert into barsupl.upl_object_lists (TYPE_ID, TYPE_CODE, TYPE_NAME, IS_ACTIVE) values(25, 'SMB_DEPOSIT_ON_DEMAND', 'Вклади на вимогу ММСБ', 'Y');
