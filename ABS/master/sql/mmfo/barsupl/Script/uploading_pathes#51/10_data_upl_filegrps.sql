-- ======================================================================================
-- Module : UPL
-- Date   : 16.03.2017
-- ======================================================================================
-- Групи вивантаження файлів даних для DWH
-- ======================================================================================


begin
delete from BARSUPL.UPL_FILEGROUPS_RLN 
    where file_id in ( 116, 182 );

--cusvals  политики отключенгы БАРСом, сам накладываю фильтр по KF (только для ММФО)
  if (BARS.F_OURMFO_G = '300465' or BARS.F_OURMFO_G = '324805')  then
      Insert into BARSUPL.UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (1, 116, 3116); 
      Insert into BARSUPL.UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (2, 116, 4116);
      Insert into BARSUPL.UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (3, 116, 3116);
      Insert into BARSUPL.UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (4, 116, 4116);
  else
      Insert into BARSUPL.UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (1, 116, 116);
      Insert into BARSUPL.UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (2, 116, 1116);
      Insert into BARSUPL.UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (3, 116, 116);
      Insert into BARSUPL.UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (4, 116, 1116);
  end if;
end;
/


--
-- STAFF_AD (staffad) / 182 (ETL-18165 - UPL - создаем справочник, 
-- ( в staff убираем KF и додобавляем  поле "Учетная запись в AD")
--
    Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (5, 182, 182);

--
-- група 99 на тестове вивантаження
--
begin
  delete from BARSUPL.UPL_FILEGROUPS_RLN where group_id = 99;

    Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 113, 6113);  -- ETL-17774 
    Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 241, 6241);  -- ETL-17774 

    -- 99-а група - ETL-17786 - створено вивантаження для звіряння коригуючих проводок 
    --      за період 01/11/2016 - 08/02/2017, запити 99104, 99196
    --  исключено из выгрузки до следующих распоряжений А.Кошлака
    --Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (99, 104, 99104);
    --Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (99, 196, 99196);

    Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (99, 121, 121); --ETL-18397 customer
    Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (99, 123, 123); --ETL-18397 person

  if (BARS.F_OURMFO_G = '300465' or BARS.F_OURMFO_G = '324805')  then
      Insert into BARSUPL.UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (99, 116, 5116);
  else
      Insert into BARSUPL.UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (99, 116, 2116);
  end if;

end;
/

COMMIT;

