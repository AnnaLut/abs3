-- ***************************************************************************
set verify off

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for UPL_TAG_LISTS');
end;
/

-- ======================================================================================
-- ETL-25158 UPL - изменить выгрузку файла ccvals(147) - добавить параметр "POCI"
-- BARS_UPL-64.0
-- ======================================================================================

delete 
  from barsupl.upl_tag_lists 
 where tag_table in ('CC_TAGS')
   and tag in ('POCI');

--Кредити ФО, ЮО * "POCI" - Додаткові параметри КД/Основні/POCI
insert into barsupl.upl_tag_lists (TAG_TABLE,TAG,ISUSE, REF_ID) values('CC_TAGS', 'POCI', 1, 0);


-- ======================================================================================
-- ETL-25414   UPL - добавить в выгрузку TAG='DATN' для документов (operW) (from uploading_pathes#63_2)
-- COBUMMFO-8528   Просимо сформувати багфікс для доопрацювання щоденного вивантаження для сховища для передачі додаткового параметру документу DATN.
-- ======================================================================================

delete
  from barsupl.upl_tag_lists 
 where trim(tag_table) in ('OP_FIELD')
   and trim(tag)       in ('DATN');

insert into barsupl.upl_tag_lists (TAG_TABLE,TAG,ISUSE, REF_ID) values('OP_FIELD', 'DATN',  1, 0);