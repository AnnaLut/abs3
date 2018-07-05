-- ***************************************************************************
set verify off
--set define on 

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for UPL_TAG_LISTS');
end;
/

-- ======================================================================================
-- ETL-25414   UPL - добавить в выгрузку TAG='DATN' для документов (operW)
-- COBUMMFO-8528   Просимо сформувати багфікс для доопрацювання щоденного вивантаження для сховища для передачі додаткового параметру документу DATN.
-- ======================================================================================

delete
  from barsupl.upl_tag_lists 
 where trim(tag_table) in ('OP_FIELD')
   and trim(tag)       in ('DATN');

insert into barsupl.upl_tag_lists (TAG_TABLE,TAG,ISUSE, REF_ID) values('OP_FIELD', 'DATN',  1, 0);


