begin
    tools.hide_hint(object_utl.cor_object_state('OBJECT', object_utl.OBJECT_STATE_CREATED, 'Створено'));
    tools.hide_hint(object_utl.cor_object_state('OBJECT', object_utl.OBJECT_STATE_DELETED, 'Видалено'));

    commit;
end;
/