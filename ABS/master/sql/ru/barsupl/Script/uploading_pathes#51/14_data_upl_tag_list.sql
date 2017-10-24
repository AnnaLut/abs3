-- ===================================================================================
-- Module : UPL
-- Date   : 25.04.2017
-- ===================================================================================
-- 
-- ===================================================================================

-- ETL-18396
--  EWATN (������������� �������� (EWA));
--  EWAML (Email ���-��, �� �����. ���(EWA));
--  EWEXT (����. �����. ���. �������� (EWA));
--  EWCOM (����� �� �������� �����������).

delete from barsupl.upl_tag_lists where tag_table in ('OP_FIELD') and tag in ('EWATN', 'EWAML','EWEXT','EWCOM');

Insert into BARSUPL.UPL_TAG_LISTS (tag_table, tag, isuse) Values ('OP_FIELD', 'EWATN', 1);
Insert into BARSUPL.UPL_TAG_LISTS (tag_table, tag, isuse) Values ('OP_FIELD', 'EWAML', 1);
Insert into BARSUPL.UPL_TAG_LISTS (tag_table, tag, isuse) Values ('OP_FIELD', 'EWEXT', 1);
Insert into BARSUPL.UPL_TAG_LISTS (tag_table, tag, isuse) Values ('OP_FIELD', 'EWCOM', 1);

commit;
