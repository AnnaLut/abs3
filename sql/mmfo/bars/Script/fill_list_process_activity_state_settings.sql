begin
    list_utl.cor_list(process_utl.LT_ACTIVITY_STATE, '���� ������� ��������� �������');
    list_utl.cor_list_item(process_utl.LT_ACTIVITY_STATE, process_utl.ACT_STATE_CREATED, 'CREATED', '��������');
    list_utl.cor_list_item(process_utl.LT_ACTIVITY_STATE, process_utl.ACT_STATE_OMITED , 'OMITED', '���������');
    list_utl.cor_list_item(process_utl.LT_ACTIVITY_STATE, process_utl.ACT_STATE_FAILED , 'FAILED', '��������� ��������� ����� �������');
    list_utl.cor_list_item(process_utl.LT_ACTIVITY_STATE, process_utl.ACT_STATE_REMOVED, 'REMOVED', '³�������');
    list_utl.cor_list_item(process_utl.LT_ACTIVITY_STATE, process_utl.ACT_STATE_DONE   , 'DONE', '��������');

    commit;
end;
/
