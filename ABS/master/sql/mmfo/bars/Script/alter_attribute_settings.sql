begin
    object_utl.cor_object_type('OBJECT', 'Базовй тип об''єктів АБС', null);

    attribute_utl.set_value(attribute_utl.get_attribute_id('OBJECT_STATE'), attribute_utl.get_attribute_id('ATTR_VALUE_TABLE_NAME'), 'OBJECT');
    attribute_utl.set_value(attribute_utl.get_attribute_id('OBJECT_STATE'), attribute_utl.get_attribute_id('ATTR_OBJECT_TYPE'), object_utl.get_object_type_id('OBJECT'));

    attribute_utl.set_value(attribute_utl.get_attribute_id(attribute_utl.ATTR_CODE_SET_VALUE_PROCEDURES), attribute_utl.ATTR_CODE_MULTI_VALUES_FLAG, 'N');

    object_utl.cor_object_type('DEAL', 'Угоди', 'OBJECT');

    commit;
end;
/

declare
    l_attribute_id integer;
begin
    l_attribute_id := attribute_utl.get_attribute_id(attribute_utl.ATTR_CODE_ATTR_COLUMN_NAME);

    if (l_attribute_id is null) then
        insert into attribute_kind
        values (s_attribute_kind.nextval,
                attribute_utl.ATTR_CODE_ATTR_COLUMN_NAME,
                'Назва поля, що зберігає ідентифікатор виду атрибуту в таблиці, де зберігаються фіксовані значення атрибутів (використовується тільки для колекцій)',
                attribute_utl.ATTR_TYPE_FIXED,
                object_utl.get_object_type_id('ATTRIBUTE'),
                attribute_utl.VALUE_TYPE_STRING,
                '',
                'ATTRIBUTE_KIND',
                '',
                'ID',
                'ATTRIBUTE_COLUMN_NAME',
                '',
                null,
                'N',
                'N',
                'N',
                'Y',
                null,
                null,
                attribute_utl.ATTR_STATE_ACTIVE);

        commit;
    end if;
end;
/

begin
    attribute_utl.set_value(attribute_utl.get_attribute_id('DKBO_ACC_LIST'), attribute_utl.ATTR_CODE_VALUE_TABLE_NAME, 'DEAL_ACCOUNT');
    attribute_utl.set_value(attribute_utl.get_attribute_id('DKBO_ACC_LIST'), attribute_utl.ATTR_CODE_KEY_COLUMN_NAME, 'DEAL_ID');
    attribute_utl.set_value(attribute_utl.get_attribute_id('DKBO_ACC_LIST'), attribute_utl.ATTR_CODE_ATTR_COLUMN_NAME, 'ACCOUNT_TYPE_ID');
    attribute_utl.set_value(attribute_utl.get_attribute_id('DKBO_ACC_LIST'), attribute_utl.ATTR_CODE_VALUE_COLUMN_NAME, 'ACCOUNT_ID');

    update attribute_kind t
    set    t.attribute_type_id = attribute_utl.ATTR_TYPE_FIXED
    where  t.attribute_code = 'DKBO_ACC_LIST';

    commit;
end;
/
