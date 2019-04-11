PROMPT ===============================================================================
PROMPT *** Run *** = Scripts /Sql/Bars/Data/DEAL_PRODUCT_ATTRIBUTE.sql = *** Run *** =
PROMPT ===============================================================================

declare
    l_attribute_id         number;
begin
    l_attribute_id := attribute_utl.get_attribute_id(product_utl.ATTR_CODE_NAME);
    if (l_attribute_id is null) then
        l_attribute_id := attribute_utl.create_parameter(
                            p_attribute_code           => product_utl.ATTR_CODE_NAME
                           ,p_attribute_name           => 'Найменування продукту'
                           ,p_object_type_code         => smb_deposit_utl.PARENT_OBJECT_TYPE_CODE
                           ,p_value_type_id            => attribute_utl.VALUE_TYPE_STRING
                           ,p_value_table_name         => 'DEAL_PRODUCT'
                           ,p_value_column_name        => 'PRODUCT_NAME'
                           ,p_key_column_name          => 'ID'
                           ,p_value_by_date_flag       => 'Y');
    end if;
    l_attribute_id := attribute_utl.get_attribute_id(product_utl.ATTR_CODE_SEGMENT_OF_BUSINESS);
    if (l_attribute_id is null) then
        l_attribute_id := attribute_utl.create_parameter(
                            p_attribute_code           => product_utl.ATTR_CODE_SEGMENT_OF_BUSINESS
                           ,p_attribute_name           => 'Сегмент'
                           ,p_object_type_code         => smb_deposit_utl.PARENT_OBJECT_TYPE_CODE
                           ,p_value_type_id            => attribute_utl.VALUE_TYPE_NUMBER
                           ,p_value_table_name         => 'DEAL_PRODUCT'
                           ,p_value_column_name        => 'SEGMENT_OF_BUSINESS_ID'
                           ,p_key_column_name          => 'ID'
                           ,p_value_by_date_flag       => 'Y');
    end if;
    l_attribute_id := attribute_utl.get_attribute_id(product_utl.ATTR_CODE_VALID_FROM);
    if (l_attribute_id is null) then
        l_attribute_id := attribute_utl.create_parameter(
                            p_attribute_code           => product_utl.ATTR_CODE_VALID_FROM
                           ,p_attribute_name           => 'Дата початку дії'
                           ,p_object_type_code         => smb_deposit_utl.PARENT_OBJECT_TYPE_CODE
                           ,p_value_type_id            => attribute_utl.VALUE_TYPE_DATE
                           ,p_value_table_name         => 'DEAL_PRODUCT'
                           ,p_value_column_name        => 'VALID_FROM'
                           ,p_key_column_name          => 'ID'
                           ,p_value_by_date_flag       => 'Y');
    end if;
    l_attribute_id := attribute_utl.get_attribute_id(product_utl.ATTR_CODE_VALID_THROUGH);
    if (l_attribute_id is null) then
        l_attribute_id := attribute_utl.create_parameter(
                            p_attribute_code           => product_utl.ATTR_CODE_VALID_THROUGH
                           ,p_attribute_name           => 'Дата закінчення дії'
                           ,p_object_type_code         => smb_deposit_utl.PARENT_OBJECT_TYPE_CODE
                           ,p_value_type_id            => attribute_utl.VALUE_TYPE_DATE
                           ,p_value_table_name         => 'DEAL_PRODUCT'
                           ,p_value_column_name        => 'VALID_THROUGH'
                           ,p_key_column_name          => 'ID'
                           ,p_value_by_date_flag       => 'Y');
    end if;
    l_attribute_id := attribute_utl.get_attribute_id(product_utl.ATTR_CODE_PARENT_PRODUCT);
    if (l_attribute_id is null) then
        l_attribute_id := attribute_utl.create_parameter(
                            p_attribute_code           => product_utl.ATTR_CODE_PARENT_PRODUCT
                           ,p_attribute_name           => 'ID батьківського продукту'
                           ,p_object_type_code         => smb_deposit_utl.PARENT_OBJECT_TYPE_CODE
                           ,p_value_type_id            => attribute_utl.VALUE_TYPE_NUMBER
                           ,p_value_table_name         => 'DEAL_PRODUCT'
                           ,p_value_column_name        => 'PARENT_PRODUCT_ID'
                           ,p_key_column_name          => 'ID'
                           ,p_value_by_date_flag       => 'Y');
    end if;    
        
    commit;    
end;
/

PROMPT ===============================================================================
PROMPT *** End *** = Scripts /Sql/Bars/Data/DEAL_PRODUCT_ATTRIBUTE.sql = *** End *** =
PROMPT ===============================================================================