declare
    l_attribute_id integer;
begin

    l_attribute_id := attribute_utl.get_attribute_id(nota.ATTR_CODE_DOCUMENT_TYPE);
    if (l_attribute_id is null) then
        l_attribute_id := attribute_utl.create_parameter(nota.ATTR_CODE_DOCUMENT_TYPE,
                                                         'NOTARY_DOCUMENT_TYPE',
                                                         'NOTARY',
                                                         attribute_utl.VALUE_TYPE_NUMBER,
                                                         p_value_table_name => 'NOTARY',
                                                         p_key_column_name => 'ID',
                                                         p_value_column_name => 'DOCUMENT_TYPE', 
                                                         p_multi_values_flag => 'N',
                                                         p_save_history_flag => 'Y');
    end if;

    l_attribute_id := attribute_utl.get_attribute_id(nota.ATTR_CODE_IDCARD_DOCUMENT_NUM);
    if (l_attribute_id is null) then
        l_attribute_id := attribute_utl.create_parameter(nota.ATTR_CODE_IDCARD_DOCUMENT_NUM,
                                                         'NOTARY_IDCARD_DOCUMENT_NUMBER',
                                                         'NOTARY',
                                                         attribute_utl.VALUE_TYPE_NUMBER,
                                                         p_value_table_name => 'NOTARY',
                                                         p_key_column_name => 'ID',
                                                         p_value_column_name => 'IDCARD_DOCUMENT_NUMBER',
                                                         p_save_history_flag => 'Y');
    end if;

    l_attribute_id := attribute_utl.get_attribute_id(nota.ATTR_CODE_IDCARD_NOTATION_NUM);
    if (l_attribute_id is null) then
        l_attribute_id := attribute_utl.create_parameter(nota.ATTR_CODE_IDCARD_NOTATION_NUM,
                                                         'NOTARY_IDCARD_NOTATION_NUMBER',
                                                         'NOTARY',
                                                         attribute_utl.VALUE_TYPE_STRING,
                                                         p_value_table_name => 'NOTARY',
                                                         p_key_column_name => 'ID',
                                                         p_value_column_name => 'IDCARD_NOTATION_NUMBER',
                                                         p_save_history_flag => 'Y');
    end if;

    l_attribute_id := attribute_utl.get_attribute_id(nota.ATTR_CODE_PASSPORT_EXPIRY);
    if (l_attribute_id is null) then
        l_attribute_id := attribute_utl.create_parameter(nota.ATTR_CODE_PASSPORT_EXPIRY,
                                                         'NOTARY_PASSPORT_EXPIRY',
                                                         'NOTARY',
                                                         attribute_utl.VALUE_TYPE_DATE,
                                                         p_value_table_name => 'NOTARY',
                                                         p_key_column_name => 'ID',
                                                         p_value_column_name => 'PASSPORT_EXPIRY',
                                                         p_save_history_flag => 'Y');
    end if;
    
    commit;
end;
/
