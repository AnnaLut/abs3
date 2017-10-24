-- ===================================================================================
-- Module : UPL
-- Date   : 13.05.2017
-- ===================================================================================
-- 
-- ===================================================================================

-- UPL - ETL-18614 - добавить в выгрузку файла cusvals значения тега 'NDBO'

delete from barsupl.upl_tag_lists where tag_table in ('CUST_FIELD') and trim(tag) in ('NDBO');
Insert into BARSUPL.UPL_TAG_LISTS (tag_table, tag, isuse) Values ('CUST_FIELD', 'NDBO ', 1);


commit;
