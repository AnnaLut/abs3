declare
l_tabid       meta_tables.tabid%type;
l_tabname      meta_tables.tabname%type;
begin
l_tabname     := 'CUSTOMER_EXTERN';
l_tabid := bars_metabase.get_tabid(l_tabname);
bars_metabase.update_column(l_tabid, 14, 'CUSTTYPE', 'N', '������~(1-��, 2-��,3-����)', 2, 22, 14, 1, 0, 0, 0, '', '', 1, 0, '', 0, 0, 0, '', '', 0);
end;
/ 


commit;
/