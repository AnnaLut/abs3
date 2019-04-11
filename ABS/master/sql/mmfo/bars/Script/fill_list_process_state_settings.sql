begin
    list_utl.cor_list(process_utl.GC_PROCESS_STATE, 'Стан обробки процесу');
    list_utl.cor_list_item(process_utl.GC_PROCESS_STATE, process_utl.GC_PROCESS_STATE_UNDEF, 'UNDEFINED', 'Не визначений');
    list_utl.cor_list_item(process_utl.GC_PROCESS_STATE, process_utl.GC_PROCESS_STATE_CREATE, 'CREATED', 'Створений');
    list_utl.cor_list_item(process_utl.GC_PROCESS_STATE, process_utl.GC_PROCESS_STATE_RUN, 'RUNNING', 'Виконується');
    list_utl.cor_list_item(process_utl.GC_PROCESS_STATE, process_utl.GC_PROCESS_STATE_FAILURE, 'FAILED', 'Виконання перервано через помилку');
    list_utl.cor_list_item(process_utl.GC_PROCESS_STATE, process_utl.GC_PROCESS_STATE_DISCARD, 'DISCARDED', 'Відхилений');
    list_utl.cor_list_item(process_utl.GC_PROCESS_STATE, process_utl.GC_PROCESS_STATE_SUCCESS, 'DONE', 'Виконаний');
    commit;
end;
/
