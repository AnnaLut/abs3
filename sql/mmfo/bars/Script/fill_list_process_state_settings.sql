begin
    list_utl.cor_list(process_utl.GC_PROCESS_STATE, '���� ������� �������');
    list_utl.cor_list_item(process_utl.GC_PROCESS_STATE, process_utl.GC_PROCESS_STATE_UNDEF, 'UNDEFINED', '�� ����������');
    list_utl.cor_list_item(process_utl.GC_PROCESS_STATE, process_utl.GC_PROCESS_STATE_CREATE, 'CREATED', '���������');
    list_utl.cor_list_item(process_utl.GC_PROCESS_STATE, process_utl.GC_PROCESS_STATE_RUN, 'RUNNING', '����������');
    list_utl.cor_list_item(process_utl.GC_PROCESS_STATE, process_utl.GC_PROCESS_STATE_FAILURE, 'FAILED', '��������� ��������� ����� �������');
    list_utl.cor_list_item(process_utl.GC_PROCESS_STATE, process_utl.GC_PROCESS_STATE_DISCARD, 'DISCARDED', '³��������');
    list_utl.cor_list_item(process_utl.GC_PROCESS_STATE, process_utl.GC_PROCESS_STATE_SUCCESS, 'DONE', '���������');
    commit;
end;
/
