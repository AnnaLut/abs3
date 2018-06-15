-- ***************************************************************************
set verify off
--set define on

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for UPL_TAG_LISTS');
end;
/

-- ======================================================================================
-- ETL-24575 UPL - выгрузить доппараметры документов (TAG = MTSC, PASPN) + справ.
-- MTSC - Money transfer system code
-- PASPN - Серія і номер документу
-- ======================================================================================

delete
  from barsupl.upl_tag_lists 
 where trim(tag_table) in ('OP_FIELD')
   and trim(tag)       in ('MTSC', 'PASPN');

insert into barsupl.upl_tag_lists (TAG_TABLE,TAG,ISUSE, REF_ID) values('OP_FIELD', 'MTSC',  1, 0);
insert into barsupl.upl_tag_lists (TAG_TABLE,TAG,ISUSE, REF_ID) values('OP_FIELD', 'PASPN', 1, 0);


