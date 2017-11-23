begin
    execute immediate 'insert into pfu_session_type (ID, SESSION_TYPE_CODE, SESSION_TYPE_NAME, WS_ACTION_CODE, PFU_METHOD_CODE, PROCESS_RESPONSE_PROCEDURE, PROCESS_FAILURE_PROCEDURE)
values (25, ''POST_REPLACEMENT_ACCOUNT'', ''Отправка сообщения о изменении реквизитов'', null, ''post_replacement_account'', null, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into pfu_session_type (ID, SESSION_TYPE_CODE, SESSION_TYPE_NAME, WS_ACTION_CODE, PFU_METHOD_CODE, PROCESS_RESPONSE_PROCEDURE, PROCESS_FAILURE_PROCEDURE)
values (26, ''GET_REPLACEMENT_ACCOUNT'', ''Получение квитанции'', null, ''get_replacement_account'', null, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into pfu_session_type (ID, SESSION_TYPE_CODE, SESSION_TYPE_NAME, WS_ACTION_CODE, PFU_METHOD_CODE, PROCESS_RESPONSE_PROCEDURE, PROCESS_FAILURE_PROCEDURE)
values (27, ''POST_NOTICE_DRAWING_BANK_ANSW'', ''Отправка сообщения о не движении по счету.'', null, ''post_notice_drawing_bank'', null, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


commit;