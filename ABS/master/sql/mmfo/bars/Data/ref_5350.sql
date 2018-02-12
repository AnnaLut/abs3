declare
 l_tabid_old   meta_tables.tabid%type;
 l_tabid_new   meta_tables.tabid%type;

begin
   begin
      select tabid into l_tabid_old from meta_tables where tabname = 'SREZERV_OB22';
      select tabid into l_tabid_new from meta_tables where tabname = 'V_SREZERV_OB22';
      update references set tabid = l_tabid_new where tabid = l_tabid_old;
      update refapp     set tabid = l_tabid_new where tabid = l_tabid_old;
   EXCEPTION WHEN NO_DATA_FOUND THEN null;
   end;
   commit;
end;
/
