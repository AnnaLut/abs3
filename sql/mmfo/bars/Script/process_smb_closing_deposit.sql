declare
    l_process_type_id integer;
begin
    l_process_type_id := process_utl.corr_proc_type('SMBD'
                                                    ,'CLOSING_TRANCHE'
                                                    ,'�������� ������� ����'
                                                    ,p_is_active  => 'Y');
    commit;
end;
/
