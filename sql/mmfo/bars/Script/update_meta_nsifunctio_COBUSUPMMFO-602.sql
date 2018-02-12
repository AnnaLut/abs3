declare
l_tabid       meta_tables.tabid%type;
l_tabname      meta_tables.tabname%type;
begin

begin
l_tabname     := 'V_CCK_RF'; --1011627
l_tabid := bars_metabase.get_tabid(l_tabname);
update meta_nsifunction m
set M.WEB_FORM_NAME = '/barsroot/customerlist/custacc.aspx'||chr(63)||'type=3'||chr(38)||'nd=:ND'||chr(38)||'rnk=:RNK'
where M.TABID = l_tabid
and M.FUNCID = 10;
end;

begin
l_tabname     := 'V_CCK_RU'; --1011623
l_tabid := bars_metabase.get_tabid(l_tabname);
update meta_nsifunction m
set M.WEB_FORM_NAME = '/barsroot/customerlist/custacc.aspx'||chr(63)||'type=2'||chr(38)||'nd=:ND'||chr(38)||'rnk=:RNK'
where M.TABID = l_tabid
and M.FUNCID = 11;
end;

end;
/
commit;
/