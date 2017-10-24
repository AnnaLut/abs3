declare
    l_table_id integer;
begin
    l_table_id := bars_metabase.get_tabid('V_INTEREST_CCK');

    update meta_nsifunction t
    set    t.proc_name = 'CDB_MEDIATOR.PAY_ACCRUED_INTEREST'
    where  t.tabid = l_table_id and
           t.funcid = 1;

    update meta_nsifunction t
    set    t.proc_name = 'CDB_MEDIATOR.PAY_SELECTED_INTEREST(:ID)'
    where  t.tabid = l_table_id and
           t.funcid = 2;

    l_table_id := bars_metabase.get_tabid('V_INTEREST_CCK_ND');

    update meta_nsifunction t
    set    t.proc_name = 'CDB_MEDIATOR.PAY_ACCRUED_INTEREST'
    where  t.tabid = l_table_id and
           t.funcid = 1;

    update meta_nsifunction t
    set    t.proc_name = 'CDB_MEDIATOR.PAY_SELECTED_INTEREST(:ID)'
    where  t.tabid = l_table_id and
           t.funcid = 2;

    commit;
end;
/
