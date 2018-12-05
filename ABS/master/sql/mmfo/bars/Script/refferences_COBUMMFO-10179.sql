declare 
   l_tabid    meta_tables.tabid%type;
   l_tabname  meta_tables.tabname%type := 'REZ_PAR' ;
   l_type     references.type%type := 8;
   l_codearm  varchar2(10) := '$RM_RISK';

begin
   l_tabid := bars_metabase.get_tabid (l_tabname);
   -- ���������� ������� � �����������
   bars_metabase.addTableToRef (l_tabid, l_type);
   -- �������� ���������� � ���
   umu.add_reference2arm(l_tabid, l_codearm, 2, 1);
   commit;
end;
/

