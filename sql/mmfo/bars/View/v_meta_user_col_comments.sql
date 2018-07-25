create or replace view v_meta_user_col_comments as
select "TABLE_NAME","COLUMN_NAME","COMMENTS" from sys.dba_col_comments;

GRANT SELECT ON BARS.v_meta_user_col_comments TO BARS_ACCESS_DEFROLE;