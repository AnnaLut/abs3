begin
    tools.hide_hint(
        operlist_adm.add_new_func('Управління відсотками по поточних рахунках',
                                  '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1' || chr(38) || 'tableName=V_CURRENT_ACCOUNTS_INTEREST' || chr(38) || 'sPar=[NSIFUNCTION]',
                                  p_frontend => 1,
                                  p_forceupd => 1));
    commit;
end;
/
