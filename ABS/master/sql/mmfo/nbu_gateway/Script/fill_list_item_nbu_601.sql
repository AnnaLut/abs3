begin
    bars.list_utl.cor_list(nbu_data_service.LT_REPORT_INSTANCE_STAGE, '���䳿 ������� ��� ����� 601 (���)');

    bars.list_utl.cor_list_item(nbu_data_service.LT_REPORT_INSTANCE_STAGE, nbu_data_service.REP_STAGE_NEW           , 'NEW'           , '���������'                 , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_data_service.LT_REPORT_INSTANCE_STAGE, nbu_data_service.REP_STAGE_RECEIVING_DATA, 'RECEIVING_DATA', '��������� ����� �� ����' , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_data_service.LT_REPORT_INSTANCE_STAGE, nbu_data_service.REP_STAGE_CONSOLIDATION , 'CONSOLIDATION' , '����������� �����'        , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_data_service.LT_REPORT_INSTANCE_STAGE, nbu_data_service.REP_STAGE_TRANSFERING   , 'TRANSFERING'   , '�������� ����� �� ���'     , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_data_service.LT_REPORT_INSTANCE_STAGE, nbu_data_service.REP_STAGE_FINISHED      , 'FINISHED'      , '���������'                 , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_data_service.LT_REPORT_INSTANCE_STAGE, nbu_data_service.REP_STAGE_DISCARDED     , 'DISCARDED'     , '³�������'                 , p_parent_item_id => null);

    bars.list_utl.cor_list(nbu_core_service.LT_CORE_REQUEST_STATE, '���� ������� ������ �� �� �� ������');

    bars.list_utl.cor_list_item(nbu_core_service.LT_CORE_REQUEST_STATE, nbu_core_service.REQ_STATE_NEW                , 'NEW'                , '�������������'                 , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_core_service.LT_CORE_REQUEST_STATE, nbu_core_service.REQ_STATE_WAITING_FOR_DATA   , 'WAITING_FOR_DATA'   , '����� �� ��������� ����� � ��' , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_core_service.LT_CORE_REQUEST_STATE, nbu_core_service.REQ_STATE_GATHERING_DATA     , 'GATHERING_DATA'     , 'ϳ�������� ����� � ��'          , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_core_service.LT_CORE_REQUEST_STATE, nbu_core_service.REQ_STATE_GATHERING_DATA_FAIL, 'GATHERING_DATA_FAIL', '������� ��������� ����� � ��'  , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_core_service.LT_CORE_REQUEST_STATE, nbu_core_service.REQ_STATE_TRANSFERING_DATA   , 'TRANSFERING_DATA'   , '�������� ����� �� ��'           , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_core_service.LT_CORE_REQUEST_STATE, nbu_core_service.REQ_STATE_TRANSFER_DATA_FAIL , 'TRANSFER_DATA_FAIL' , '������� �������� ����� �� ��'   , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_core_service.LT_CORE_REQUEST_STATE, nbu_core_service.REQ_STATE_DATA_DELIVERED     , 'DATA_DELIVERED'     , '��� ������� � ��'             , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_core_service.LT_CORE_REQUEST_STATE, nbu_core_service.REQ_STATE_FAILED             , 'FAILED'             , '������� ������� ��������� �����', p_parent_item_id => null);

    bars.list_utl.cor_list(nbu_service_utl.LT_SESSION_STATE, '���� �������� ����� �� ���');

    bars.list_utl.cor_list_item(nbu_service_utl.LT_SESSION_STATE, nbu_service_utl.SESSION_STATE_NEW             , 'NEW'            , '����'                                         , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_service_utl.LT_SESSION_STATE, nbu_service_utl.SESSION_STATE_TO_SIGN         , 'TO_SIGN'        , '����� �� �����'                             , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_service_utl.LT_SESSION_STATE, nbu_service_utl.SESSION_STATE_SIGNED          , 'SIGNED'         , 'ϳ�������'                                    , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_service_utl.LT_SESSION_STATE, nbu_service_utl.SESSION_STATE_RESPONDED       , 'RESPONDED'      , '�������� ������� �� ���'                   , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_service_utl.LT_SESSION_STATE, nbu_service_utl.SESSION_STATE_SEND_FAILED     , 'SEND_FAILED'    , '������� ��������'                            , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_service_utl.LT_SESSION_STATE, nbu_service_utl.SESSION_STATE_NBU_SIGN_VERIF  , 'NBU_SIGN_VERIF' , 'ϳ���� ��� ���������'                        , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_service_utl.LT_SESSION_STATE, nbu_service_utl.SESSION_STATE_NBU_SIGN_FAILED , 'NBU_SIGN_FAILED', '������� �������� ������ ���'                , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_service_utl.LT_SESSION_STATE, nbu_service_utl.SESSION_STATE_DECLINED_BY_NBU , 'DECLINED_BY_NBU', '³������� ���'                                , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_service_utl.LT_SESSION_STATE, nbu_service_utl.SESSION_STATE_PROCESSED       , 'PROCESSED'      , '��������� ������'                            , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_service_utl.LT_SESSION_STATE, nbu_service_utl.SESSION_STATE_PROCESSING_FAIL , 'PROCESSING_FAIL', '������� ������� ������'                    , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_service_utl.LT_SESSION_STATE, nbu_service_utl.SESSION_STATE_EXPIRED         , 'EXPIRED'        , '��� ��� ��������'                         , p_parent_item_id => null);
    bars.list_utl.cor_list_item(nbu_service_utl.LT_SESSION_STATE, nbu_service_utl.SESSION_STATE_PENDING         , 'PENDING'        , '����� �� ��������� ������� ���������� ���', p_parent_item_id => null);

    commit;
end;
/
