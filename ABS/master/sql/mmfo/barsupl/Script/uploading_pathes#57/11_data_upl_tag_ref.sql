-- ***************************************************************************
set verify off

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for UPL_TAG_REF');
end;
/

-- ======================================================================================
-- ETL-20823 -UPL - выгрузить из АБС в ХД параметры договора/счёта для IFRS9: BUSINESS_MODEL, IFRS_CATEGORY, SPPI, Ринкова ставка (INTRT), Референс реструкт.договору (ND_REST) с соответствующими справочниками
-- новая таблица "Справочники к значениям тегов"
-- ======================================================================================

delete 
  from barsupl.upl_tag_ref 
 where ref_id in (0, 1, 2, 3);

Insert into barsupl.upl_tag_ref (ref_id, file_id, description) Values (0, null, 'Без справочника');
Insert into barsupl.upl_tag_ref (ref_id, file_id, description) Values (1, 177, 'Бізнес-модель (BUS_MOD)');
Insert into barsupl.upl_tag_ref (ref_id, file_id, description) Values (2, 178, 'Критерій SPPI (SPPI)');
Insert into barsupl.upl_tag_ref (ref_id, file_id, description) Values (3, 179, 'Класифікація МСФЗ (IFRS)');
--Insert into barsupl.upl_tag_ref (ref_id, description) Values (4, 'Ринкова ставка (INTRT)');
--Insert into barsupl.upl_tag_ref (ref_id, description) Values (5, 'Посилання на референс реструкт.договору (ND_REST)');

