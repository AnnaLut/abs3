prompt Налаштовуємо атрибут "СЕП. Редагування бізнес правил (BP_RRP)"

declare
    l_attribute_id integer;
begin
    l_attribute_id := attribute_utl.get_attribute_id('SEP_BP_RRP');
    if (l_attribute_id is null) then
        l_attribute_id := attribute_utl.create_calculated_attribute(p_attribute_code => 'SEP_BP_RRP',
                                                                    p_attribute_name => 'СЕП. Редагування бізнес правил (BP_RRP)',
                                                                    p_object_type_code => 'CUSTOMER',
                                                                    p_value_type_id => attribute_utl.VALUE_TYPE_STRING,
                                                                    p_small_value_flag => 'N',
                                                                    p_value_by_date_flag => 'N',
                                                                    p_multi_values_flag => 'N',
                                                                    p_get_value_function => ' ');
                                                                   
    end if;

    commit;
end;
/