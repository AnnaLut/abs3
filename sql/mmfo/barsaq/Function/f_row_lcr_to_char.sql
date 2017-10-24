
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/function/f_row_lcr_to_char.sql =========**
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARSAQ.F_ROW_LCR_TO_CHAR (rowlcr in sys.lcr$_row_record) return clob
is
   res        number;
   newlist    sys.lcr$_row_list;
   oldlist    sys.lcr$_row_list;
   clb        clob;
begin
  clb := '';
  clb := clb || 'source database: '
                        || rowlcr.get_source_database_name
                        || chr(10);
  clb := clb || 'owner: ' || rowlcr.get_object_owner || chr(10);
  clb := clb || 'object: ' || rowlcr.get_object_name || chr(10);
  clb := clb || 'is tag null: ' || rowlcr.is_null_tag || chr(10);
  clb := clb || 'command_type: ' || rowlcr.get_command_type || chr(10);
  clb := clb || 'transaction id: ' || rowlcr.get_transaction_id || chr(10);
  clb := clb || 'scn: ' || rowlcr.get_scn || chr(10);
  clb := clb || 'commit scn: ' || rowlcr.get_commit_scn || chr(10);
  --clb := clb || 'commit scn: ' || rowlcr.get_commit_scn || chr(10);
  oldlist := rowlcr.get_values ('OLD');

  for i in 1 .. oldlist.count
  loop
     if oldlist (i) is not null
     then
        clb := clb || 'old(' || i || '): '
                              || oldlist (i).column_name
                              || chr(10);
        clb := clb || f_any_to_char(oldlist (i).data);
     end if;
  end loop;

  newlist := rowlcr.get_values ('NEW');

  for i in 1 .. newlist.count
  loop
     if newlist (i) is not null
     then
        clb := clb || 'new(' || i || '): '
                              || newlist (i).column_name
                              || chr(10);
        clb := clb || f_any_to_char(newlist (i).data);
     end if;
  end loop;
  return clb;
end f_row_lcr_to_char;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARSAQ/function/f_row_lcr_to_char.sql =========**
 PROMPT ===================================================================================== 
 