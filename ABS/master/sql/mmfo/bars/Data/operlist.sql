begin
    tools.hide_hint(
        operlist_adm.add_new_func('����������� ������� �� ������������� ��������',
                                  '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2' || chr(38) || 'tableName=V_INTEREST_TO_ACCRUAL' || chr(38) || 'sPar=[NSIFUNCTION]',
                                   p_frontend => 1,
                                   p_forceupd => 1));

    commit;
end;
/

begin
    tools.hide_hint(
        operlist_adm.add_new_func('������� ������� �� ������������� ��������',
                                  '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2' || chr(38) || 'tableName=V_INTEREST_TO_PAYMENT' || chr(38) || 'sPar=[NSIFUNCTION]',
                                  p_frontend => 1,
                                  p_forceupd => 1));
    commit;
end;
/

begin
    tools.hide_hint(
        operlist_adm.add_new_func('����������� �������� ���',
                                  '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2'||CHR(38)||'tableName=V_OLDBPK_INT_RECKONING'||CHR(38)||'sPar=[PROC=>npi_ui.prepare_oldbpk_interest(:date_to)][PAR=>:date_to(SEM=���� ��,TYPE=D)][EXEC=>BEFORE][NSIFUNCTION][showDialogWindow=>false]',
                                  p_frontend => 1,
                                  p_forceupd => 1));
    commit;
end;
/

begin
    tools.hide_hint(
        operlist_adm.add_new_func('����������� ������� �� �������� ��������� �������',
                                  '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2' || chr(38) || 'tableName=V_CRSOUR_INTEREST_TO_ACCRUAL' || chr(38) || 'sPar=[NSIFUNCTION]',
                                  p_frontend => 1,
                                  p_forceupd => 1));
    commit;
end;
/

begin
    tools.hide_hint(
        operlist_adm.add_new_func('������� ������� �� �������� ��������� �������',
                                  '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2' || chr(38) || 'tableName=V_CRSOUR_INTEREST_TO_PAYMENT' || chr(38) || 'sPar=[NSIFUNCTION]',
                                  p_frontend => 1,
                                  p_forceupd => 1));
    commit;
end;
/

begin
    tools.hide_hint(
        operlist_adm.add_new_func('��������� ��������� �� �������� ��������',
                                  '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1' || chr(38) || 'tableName=V_CURRENT_ACCOUNTS_INTEREST' || chr(38) || 'sPar=[NSIFUNCTION]',
                                  p_frontend => 1,
                                  p_forceupd => 1));
    commit;
end;
/

begin
    tools.hide_hint(
        operlist_adm.add_new_func('Way4. �������� ���(��)',
                                  '/barsroot/Way4Bpk/Way4Bpk',
                                  p_frontend => 1,
                                  p_forceupd => 1));
    commit;
end;
/

