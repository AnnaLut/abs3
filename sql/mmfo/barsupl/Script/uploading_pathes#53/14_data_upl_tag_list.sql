
update barsupl.upl_tag_lists set tag = trim(tag) where tag_table = 'CUST_FIELD' and tag != trim(tag);

COMMIT;
