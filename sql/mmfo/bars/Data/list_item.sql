begin
    list_utl.cor_list_item(interest_utl.LT_RECKONING_GROUPING_MODE, interest_utl.GROUPING_MODE_NO_GROUPING    , 'NO_GROUPING', '��� ���������'      , null);
    list_utl.cor_list_item(interest_utl.LT_RECKONING_GROUPING_MODE, interest_utl.GROUPING_MODE_GROUP_BY_RATES , 'BY_RATES'   , '�� ��������� ������', null);
    list_utl.cor_list_item(interest_utl.LT_RECKONING_GROUPING_MODE, interest_utl.GROUPING_MODE_GROUP_ALL      , 'FULL'       , '����� ���������'    , null);
    commit;
end;
/
begin
    list_utl.cor_list_item('INTEREST_RECKONING_STATE', interest_utl.RECKONING_STATE_RECKONED      , 'RECKONED'         , '�������'                , p_parent_item_id => null);
    list_utl.cor_list_item('INTEREST_RECKONING_STATE', interest_utl.RECKONING_STATE_MODIFIED      , 'MODIFIED'         , '³�����������'          , p_parent_item_id => null);
    list_utl.cor_list_item('INTEREST_RECKONING_STATE', interest_utl.RECKONING_STATE_RECKONING_FAIL, 'RECKONING_FAILED' , '������� ��� ����������' , p_parent_item_id => null);
    list_utl.cor_list_item('INTEREST_RECKONING_STATE', interest_utl.RECKONING_STATE_GROUPED       , 'GROUPED'          , '����������'             , p_parent_item_id => null);
    list_utl.cor_list_item('INTEREST_RECKONING_STATE', interest_utl.RECKONING_STATE_ACCRUED       , 'ACCRUED'          , '����������'             , p_parent_item_id => null);
    list_utl.cor_list_item('INTEREST_RECKONING_STATE', interest_utl.RECKONING_STATE_ACCRUAL_FAILED, 'ACCRUAL_FAILED'   , '������� ��� ����������', p_parent_item_id => null);
    list_utl.cor_list_item('INTEREST_RECKONING_STATE', interest_utl.RECKONING_STATE_ACCR_DISCARDED, 'ACCRUAL_DISCARDED', '����������� ���������'  , p_parent_item_id => null);
    list_utl.cor_list_item('INTEREST_RECKONING_STATE', interest_utl.RECKONING_STATE_PAYED         , 'PAYED'            , '���������'              , p_parent_item_id => null);
    list_utl.cor_list_item('INTEREST_RECKONING_STATE', interest_utl.RECKONING_STATE_PAYMENT_FAILED, 'PAYMENT_FAILED'   , '������� ��� ������'    , p_parent_item_id => null);
    list_utl.cor_list_item('INTEREST_RECKONING_STATE', interest_utl.RECKONING_STATE_PAYM_DISCARDED, 'PAYMENT_DISCARDED', '������� ���������'      , p_parent_item_id => null);
    list_utl.cor_list_item('INTEREST_RECKONING_STATE', interest_utl.RECKONING_STATE_ONLY_INFO     , 'ONLY_INFO'        , '������������� �����'    , p_parent_item_id => null);
    commit;
end;
/
