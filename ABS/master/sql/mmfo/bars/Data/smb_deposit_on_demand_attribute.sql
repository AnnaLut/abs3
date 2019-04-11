PROMPT ========================================================================================
PROMPT *** Run *** = Scripts /Sql/Bars/Data/SMB_DEPOSIT_ON_DEMAND_ATTRIBUTE.sql = *** Run *** =
PROMPT ========================================================================================

declare
    l_attribute_id         number;
begin
    l_attribute_id := attribute_utl.get_attribute_id(smb_deposit_utl.ATTR_SMB_DEPOSIT_ON_DEMAND_IR);
    if (l_attribute_id is null) then
        l_attribute_id := attribute_utl.create_dynamic_attribute(
                            p_attribute_code           => smb_deposit_utl.ATTR_SMB_DEPOSIT_ON_DEMAND_IR
                           ,p_attribute_name           => 'Процентна ставка по депозитнам на вимогу ММСБ'
                           ,p_object_type_code         => smb_deposit_utl.ON_DEMAND_OBJECT_TYPE_CODE
                           ,p_value_type_id            => attribute_utl.VALUE_TYPE_NUMBER
                           ,p_value_by_date_flag       => 'Y'
                           ,p_save_history_flag        => 'Y');
    else
        attribute_utl.set_value(l_attribute_id, attribute_utl.ATTR_CODE_SAVE_HISTORY_FLAG, 'Y');
    end if;
    l_attribute_id := attribute_utl.get_attribute_id(smb_deposit_utl.ATTR_SMB_DPT_ON_DEMAND_CALC);
    if (l_attribute_id is null) then
        l_attribute_id := attribute_utl.create_dynamic_attribute(
                            p_attribute_code           => smb_deposit_utl.ATTR_SMB_DPT_ON_DEMAND_CALC
                           ,p_attribute_name           => 'Тип нарахування % по депозитнам на вимогу ММСБ'
                           ,p_object_type_code         => smb_deposit_utl.ON_DEMAND_OBJECT_TYPE_CODE
                           ,p_value_type_id            => attribute_utl.VALUE_TYPE_NUMBER
                           ,p_value_by_date_flag       => 'Y'
                           ,p_save_history_flag        => 'Y');
    else
        attribute_utl.set_value(l_attribute_id, attribute_utl.ATTR_CODE_SAVE_HISTORY_FLAG, 'Y');
    end if;
    commit;    
end;
/

PROMPT ========================================================================================
PROMPT *** End *** = Scripts /Sql/Bars/Data/SMB_DEPOSIT_ON_DEMAND_ATTRIBUTE.sql = *** End *** =
PROMPT ========================================================================================