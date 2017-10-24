prompt Налаштовуємо атрибут "Номер мобільного телефону клієнта"

declare
    l_attribute_id integer;
begin
    l_attribute_id := attribute_utl.get_attribute_id('CUSTOMER_MOBILE_PHONE');
    if (l_attribute_id is null) then
        l_attribute_id := attribute_utl.create_calculated_attribute(p_attribute_code => 'CUSTOMER_MOBILE_PHONE',
                                                                    p_attribute_name => 'Номер мобільного телефону клієнта',
                                                                    p_object_type_code => 'CUSTOMER',
                                                                    p_value_type_id => attribute_utl.VALUE_TYPE_STRING,
                                                                    p_small_value_flag => 'N',
                                                                    p_value_by_date_flag => 'N',
                                                                    p_multi_values_flag => 'N',
                                                                    p_get_value_function => 'customer_utl.get_customer_mobile_phone');
    end if;

    commit;
end;
/

prompt Створюємо тип ресурсу «Атрибути клієнтів»

begin
    resource_utl.cor_resource_type(p_resource_type_code => 'CUSTOMER_ATTRIBUTE',
                                   p_resource_type_name => 'Атрибути клієнта',
                                   p_table_name => '(select k.id, k.attribute_code, k.attribute_name from attribute_kind k where k.object_type_id = (select o.id from object_type o where o.type_code = ''CUSTOMER''))',
                                   p_resource_id_column_name => 'ID',
                                   p_resource_code_column_name => 'ATTRIBUTE_CODE',
                                   p_resource_name_column_name => 'ATTRIBUTE_NAME');

    merge into adm_resource_type_relation a
    using (select resource_utl.get_resource_type_id('STAFF_ROLE') grantee_type_id,
                  resource_utl.get_resource_type_id('CUSTOMER_ATTRIBUTE') resource_type_id
           from   dual) s
    on (a.grantee_type_id = s.grantee_type_id and
        a.resource_type_id = s.resource_type_id)
    when matched then update
         set a.must_be_approved = 'N',
             a.access_mode_list_id = list_utl.get_list_id('COMMON_RESOURCE_ACCESS_MODE'),
             a.no_access_item_id = 0,
             a.on_change_event_handler = '',
             a.on_resolve_event_handler = ''
    when not matched then insert
         values (s.grantee_type_id, s.resource_type_id, 'N', list_utl.get_list_id('COMMON_RESOURCE_ACCESS_MODE'), 0, '', '');

    commit;
end;
/
