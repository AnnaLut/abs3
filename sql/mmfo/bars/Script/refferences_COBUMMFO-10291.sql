declare 
   l_tabid    meta_tables.tabid%type;
   l_tabname  meta_tables.tabname%type := 'FIN_RNK_OKPO' ;
   l_type     references.type%type := 8;
   l_codearm  varchar2(10) := '$RM_RISK';

begin
   l_tabid := bars_metabase.get_tabid (l_tabname);
   -- добавление таблицы в справочники
   bars_metabase.addTableToRef (l_tabid, l_type);
   -- добавить справочник в АРМ
   umu.add_reference2arm(l_tabid, l_codearm, 2, 1);
   commit;
end;
/

