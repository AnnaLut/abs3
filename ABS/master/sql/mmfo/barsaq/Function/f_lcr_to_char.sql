
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/function/f_lcr_to_char.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARSAQ.F_LCR_TO_CHAR (lcr in sys.anydata)
return clob
is
   typenm     varchar2 (61);
   ddllcr     sys.lcr$_ddl_record;
   proclcr    sys.lcr$_procedure_record;
   rowlcr     sys.lcr$_row_record;
   res        number;
   newlist    sys.lcr$_row_list;
   oldlist    sys.lcr$_row_list;
   ddl_text   clob;
   clb        clob;
begin
   clb := '';
   typenm := lcr.gettypename ();
   clb := clb || 'type name: ' || typenm || chr(10);

   if (typenm = 'SYS.LCR$_DDL_RECORD')
   then
      res := lcr.getobject (ddllcr);
      clb := clb || 'source database: '
                            || ddllcr.get_source_database_name
                            || chr(10);
      clb := clb || 'owner: ' || ddllcr.get_object_owner || chr(10);
      clb := clb || 'object: ' || ddllcr.get_object_name || chr(10);
      clb := clb || 'is tag null: ' || ddllcr.is_null_tag || chr(10);
      DBMS_LOB.createtemporary (ddl_text, true);
      ddllcr.get_ddl_text (ddl_text);
      clb := clb || 'ddl: ' || ddl_text || chr(10);
      DBMS_LOB.freetemporary (ddl_text);
   elsif (typenm = 'SYS.LCR$_ROW_RECORD')
   then
      res := lcr.getobject (rowlcr);
      clb := clb || 'source database: '
                            || rowlcr.get_source_database_name
                            || chr(10);
      clb := clb || 'owner: ' || rowlcr.get_object_owner || chr(10);
      clb := clb || 'object: ' || rowlcr.get_object_name || chr(10);
      clb := clb || 'is tag null: ' || rowlcr.is_null_tag || chr(10);
      clb := clb || 'command_type: ' || rowlcr.get_command_type || chr(10);
      clb := clb || 'transaction id: ' || rowlcr.get_transaction_id || chr(10);
      clb := clb || 'scn: ' || rowlcr.get_scn || chr(10);
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
   else
      clb := clb || 'Non-LCR Message with type ' || typenm || chr(10);
   end if;
   return clb;
end f_lcr_to_char;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARSAQ/function/f_lcr_to_char.sql =========*** En
 PROMPT ===================================================================================== 
 