begin
    list_utl.cor_list(interest_utl.LT_RECKONING_LINE_TYPE, '��� ���������� �������');

    list_utl.cor_list_item('INTEREST_RECKONING_STATE', interest_utl.RECKONING_STATE_RECALCULATION , 'RECALCULATION', '����������� �������', p_parent_item_id => null);
    list_utl.cor_list_item(interest_utl.LT_RECKONING_LINE_TYPE, interest_utl.RECKONING_TYPE_ORDINARY_INT, 'ORDINARY_INTEREST', '���������� ����������� �������'   , null);
    list_utl.cor_list_item(interest_utl.LT_RECKONING_LINE_TYPE, interest_utl.RECKONING_TYPE_CORRECTION  , 'RECALCULATION'    , '����������� �������'              , null);

    commit;
end;
/
