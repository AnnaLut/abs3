begin
    list_utl.cor_list('DEAL_BALANCE_GROUP', '���������� ���� ������� ����� ������� ���');

    list_utl.cor_list_item('DEAL_BALANCE_GROUP', 1, 'FUNDS', '��������', null);
    list_utl.cor_list_item('DEAL_BALANCE_GROUP', 2, 'CUSTOMER_FUNDS', '����� �볺��� �����', 1);
    list_utl.cor_list_item('DEAL_BALANCE_GROUP', 3, 'FUNDS_FOR_COMPANIES', '����� ���''���� ��������������', 2);
    list_utl.cor_list_item('DEAL_BALANCE_GROUP', 4, 'CURRENT_ACCOUNTS_FOR_COMPANIES', '����� 260. ����� �� ������ ���''���� ��������������', 3);
    list_utl.cor_list_item('DEAL_BALANCE_GROUP', 5, 'DEPOSIT_FOR_COMPANIES', '����� 261. ������� ����� ���''���� ��������������', 3);
    list_utl.cor_list_item('DEAL_BALANCE_GROUP', 6, 'FUNDS_FOR_NONBANK_FIN_INST', '����� 265. ����� ������������ ���������� �������', 2);
    list_utl.cor_list_item('DEAL_BALANCE_GROUP', 7, 'CURR_ACC_FOR_NONBANK_FIN_INST', '����� �� ������ ������������ ���������� �������', 6);
    list_utl.cor_list_item('DEAL_BALANCE_GROUP', 8, 'DEPOSIT_FOR_NONBANK_FIN_INST', '������� ������ (��������) ������������ ���������� �������', 6);

    commit;
end;
/
declare
    l_attribute_id integer;
begin
    l_attribute_id := attribute_utl.get_attribute_id('DEAL_BALANCE_GROUP');
    if (l_attribute_id is null) then
        l_attribute_id := attribute_utl.create_dynamic_attribute('DEAL_BALANCE_GROUP',
                                                                 '����� ���� � ���� ������� ���',
                                                                 'DEAL',
                                                                 attribute_utl.VALUE_TYPE_LIST,
                                                                 p_list_type_code => 'DEAL_BALANCE_GROUP',
                                                                 p_small_value_flag => 'N',
                                                                 p_value_by_date_flag => 'N',
                                                                 p_multi_values_flag => 'N',
                                                                 p_save_history_flag => 'Y');
    end if;

    commit;
end;
/
