prompt -- creating ERR$_cc_lim_copy
declare
  i integer;
begin
  select count(1)
    into i
    from user_tables a
   where upper(a.TABLE_NAME) = upper('ERR$_cc_lim_copy');
  if i = 0 then
    begin
      DBMS_ERRLOG.create_error_log(dml_table_name   => 'cc_lim_copy',
                                   skip_unsupported => TRUE);
    END;
  end if;
end;
/
