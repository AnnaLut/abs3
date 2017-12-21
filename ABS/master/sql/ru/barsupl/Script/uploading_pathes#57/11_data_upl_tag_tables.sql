-- ***************************************************************************
set verify off

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for UPL_TAG_TABLES');
end;
/

-- ======================================================================================
-- ETL-20823 -UPL - выгрузить из АБС в ХД параметры договора/счёта для IFRS9: BUSINESS_MODEL, IFRS_CATEGORY, SPPI, Ринкова ставка (INTRT), Референс реструкт.договору (ND_REST) с соответствующими справочниками
-- выгружать только теги без справочников
-- ======================================================================================

delete 
  from barsupl.upl_tag_tables 
 where tag_table in ('CP_TAGS');

Insert into barsupl.upl_tag_tables (tag_table, descript) Values ('CP_TAGS', 'Додаткові реквізити угод ЦП');

