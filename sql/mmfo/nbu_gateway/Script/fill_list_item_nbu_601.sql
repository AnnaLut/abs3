begin
    bars.list_utl.cor_list(nbu_data_service.LT_REPORT_INSTANCE_STAGE, 'Стадії обробки для форми 601 (НБУ)');

    bars.list_utl.cor_list_item(nbu_data_service.LT_REPORT_INSTANCE_STAGE, nbu_data_service.REP_STAGE_NEW           , 'NEW'           , 'Створений'                 , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_data_service.LT_REPORT_INSTANCE_STAGE, nbu_data_service.REP_STAGE_RECEIVING_DATA, 'RECEIVING_DATA', 'Отримання даних від філій' , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_data_service.LT_REPORT_INSTANCE_STAGE, nbu_data_service.REP_STAGE_CONSOLIDATION , 'CONSOLIDATION' , 'Консолідація даних'        , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_data_service.LT_REPORT_INSTANCE_STAGE, nbu_data_service.REP_STAGE_TRANSFERING   , 'TRANSFERING'   , 'Передача даних до НБУ'     , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_data_service.LT_REPORT_INSTANCE_STAGE, nbu_data_service.REP_STAGE_FINISHED      , 'FINISHED'      , 'Завершено'                 , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_data_service.LT_REPORT_INSTANCE_STAGE, nbu_data_service.REP_STAGE_DISCARDED     , 'DISCARDED'     , 'Відхилено'                 , p_parent_item_id => null);

    bars.list_utl.cor_list(nbu_core_service.LT_CORE_REQUEST_STATE, 'Стан обробки запитів до РУ за даними');

    bars.list_utl.cor_list_item(nbu_core_service.LT_CORE_REQUEST_STATE, nbu_core_service.REQ_STATE_NEW                , 'NEW'                , 'Зареєстрований'                 , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_core_service.LT_CORE_REQUEST_STATE, nbu_core_service.REQ_STATE_WAITING_FOR_DATA   , 'WAITING_FOR_DATA'   , 'Очікує на отримання даних з РУ' , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_core_service.LT_CORE_REQUEST_STATE, nbu_core_service.REQ_STATE_GATHERING_DATA     , 'GATHERING_DATA'     , 'Підготовка даних в РУ'          , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_core_service.LT_CORE_REQUEST_STATE, nbu_core_service.REQ_STATE_GATHERING_DATA_FAIL, 'GATHERING_DATA_FAIL', 'Помилка підготовки даних в РУ'  , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_core_service.LT_CORE_REQUEST_STATE, nbu_core_service.REQ_STATE_TRANSFERING_DATA   , 'TRANSFERING_DATA'   , 'Передача даних до ЦА'           , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_core_service.LT_CORE_REQUEST_STATE, nbu_core_service.REQ_STATE_TRANSFER_DATA_FAIL , 'TRANSFER_DATA_FAIL' , 'Помилка передачі даних до ЦА'   , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_core_service.LT_CORE_REQUEST_STATE, nbu_core_service.REQ_STATE_DATA_DELIVERED     , 'DATA_DELIVERED'     , 'Дані отримані в ЦА'             , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_core_service.LT_CORE_REQUEST_STATE, nbu_core_service.REQ_STATE_FAILED             , 'FAILED'             , 'Помилка процесу отримання даних', p_parent_item_id => null);

    bars.list_utl.cor_list(nbu_service_utl.LT_SESSION_STATE, 'Стан відправки даних до НБУ');

    bars.list_utl.cor_list_item(nbu_service_utl.LT_SESSION_STATE, nbu_service_utl.SESSION_STATE_NEW             , 'NEW'            , 'Нова'                                         , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_service_utl.LT_SESSION_STATE, nbu_service_utl.SESSION_STATE_TO_SIGN         , 'TO_SIGN'        , 'Очікує на підпис'                             , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_service_utl.LT_SESSION_STATE, nbu_service_utl.SESSION_STATE_SIGNED          , 'SIGNED'         , 'Підписана'                                    , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_service_utl.LT_SESSION_STATE, nbu_service_utl.SESSION_STATE_RESPONDED       , 'RESPONDED'      , 'Отримана відповідь від НБУ'                   , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_service_utl.LT_SESSION_STATE, nbu_service_utl.SESSION_STATE_SEND_FAILED     , 'SEND_FAILED'    , 'Помилка відправки'                            , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_service_utl.LT_SESSION_STATE, nbu_service_utl.SESSION_STATE_NBU_SIGN_VERIF  , 'NBU_SIGN_VERIF' , 'Підпис НБУ перевірено'                        , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_service_utl.LT_SESSION_STATE, nbu_service_utl.SESSION_STATE_NBU_SIGN_FAILED , 'NBU_SIGN_FAILED', 'Помилка перевірки підпису НБУ'                , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_service_utl.LT_SESSION_STATE, nbu_service_utl.SESSION_STATE_DECLINED_BY_NBU , 'DECLINED_BY_NBU', 'Відхилено НБУ'                                , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_service_utl.LT_SESSION_STATE, nbu_service_utl.SESSION_STATE_PROCESSED       , 'PROCESSED'      , 'Оброблено успішно'                            , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_service_utl.LT_SESSION_STATE, nbu_service_utl.SESSION_STATE_PROCESSING_FAIL , 'PROCESSING_FAIL', 'Помилка обробки відповіді'                    , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_service_utl.LT_SESSION_STATE, nbu_service_utl.SESSION_STATE_EXPIRED         , 'EXPIRED'        , 'Дані сесії застаріли'                         , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_service_utl.LT_SESSION_STATE, nbu_service_utl.SESSION_STATE_PENDING         , 'PENDING'        , 'Очікує на результат обробки попередньої сесії', p_parent_item_id => null);

    commit;
end;
/
