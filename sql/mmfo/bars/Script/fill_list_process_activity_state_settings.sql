begin
    list_utl.cor_list(process_utl.LT_ACTIVITY_STATE, 'Стан обробки активності процесу');
    list_utl.cor_list_item(process_utl.LT_ACTIVITY_STATE, process_utl.ACT_STATE_CREATED, 'CREATED', 'Створена');
    list_utl.cor_list_item(process_utl.LT_ACTIVITY_STATE, process_utl.ACT_STATE_OMITED , 'OMITED', 'Пропущена');
    list_utl.cor_list_item(process_utl.LT_ACTIVITY_STATE, process_utl.ACT_STATE_FAILED , 'FAILED', 'Виконання перервано через помилку');
    list_utl.cor_list_item(process_utl.LT_ACTIVITY_STATE, process_utl.ACT_STATE_REMOVED, 'REMOVED', 'Відхилена');
    list_utl.cor_list_item(process_utl.LT_ACTIVITY_STATE, process_utl.ACT_STATE_DONE   , 'DONE', 'Виконана');

    commit;
end;
/
