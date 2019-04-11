PROMPT ===================================================================================== 
PROMPT *** Run *** ==== Scripts /Sql/Bars/Data/DEAL_INTEREST_RATE_TYPE.sql ===== *** Run ***
PROMPT ===================================================================================== 

declare
  l_id             number;
begin
    l_id             := smb_deposit_utl.get_deal_interest_rate_type_id(
                                   p_deal_interest_rate_type_code => smb_deposit_utl.GENERAL_TYPE);
    if l_id is null then
       l_id := smb_deposit_utl.create_deal_interest_rate_type(
                              p_object_type_code => smb_deposit_utl.TRANCHE_OBJECT_TYPE_CODE
                             ,p_type_code        => smb_deposit_utl.GENERAL_TYPE
                             ,p_type_name        => 'Базові ставки'
                              );     
    end if;                                    
    l_id             := smb_deposit_utl.get_deal_interest_rate_type_id(
                                   p_deal_interest_rate_type_code => smb_deposit_utl.BONUS_TYPE);
    if l_id is null then
       l_id := smb_deposit_utl.create_deal_interest_rate_type(
                              p_object_type_code => smb_deposit_utl.TRANCHE_OBJECT_TYPE_CODE
                             ,p_type_code        => smb_deposit_utl.BONUS_TYPE
                             ,p_type_name        => 'Акційні ставки'
                              );     
    end if;
    l_id             := smb_deposit_utl.get_deal_interest_rate_type_id(
                                   p_deal_interest_rate_type_code => smb_deposit_utl.PAYMENT_TYPE);
    if l_id is null then
       l_id := smb_deposit_utl.create_deal_interest_rate_type(
                              p_object_type_code => smb_deposit_utl.TRANCHE_OBJECT_TYPE_CODE
                             ,p_type_code        => smb_deposit_utl.PAYMENT_TYPE
                             ,p_type_name        => 'Виплата'
                              );     
    end if;
    l_id             := smb_deposit_utl.get_deal_interest_rate_type_id(
                                   p_deal_interest_rate_type_code => smb_deposit_utl.CAPITALIZATION_TYPE);
    if l_id is null then
       l_id := smb_deposit_utl.create_deal_interest_rate_type(
                              p_object_type_code => smb_deposit_utl.TRANCHE_OBJECT_TYPE_CODE
                             ,p_type_code        => smb_deposit_utl.CAPITALIZATION_TYPE
                             ,p_type_name        => 'Капіталізація'
                              );     
    end if;
    l_id             := smb_deposit_utl.get_deal_interest_rate_type_id(
                                   p_deal_interest_rate_type_code => smb_deposit_utl.PROLONGATION_TYPE);
    if l_id is null then
       l_id := smb_deposit_utl.create_deal_interest_rate_type(
                              p_object_type_code => smb_deposit_utl.TRANCHE_OBJECT_TYPE_CODE
                             ,p_type_code        => smb_deposit_utl.PROLONGATION_TYPE
                             ,p_type_name        => 'Пролонгація'
                              );     
    end if;
    l_id             := smb_deposit_utl.get_deal_interest_rate_type_id(
                                   p_deal_interest_rate_type_code => smb_deposit_utl.PENALTY_RATE_TYPE);
    if l_id is null then
       l_id := smb_deposit_utl.create_deal_interest_rate_type(
                              p_object_type_code => smb_deposit_utl.TRANCHE_OBJECT_TYPE_CODE
                             ,p_type_code        => smb_deposit_utl.PENALTY_RATE_TYPE
                             ,p_type_name        => 'Штраф'
                              );
    end if;
    l_id             := smb_deposit_utl.get_deal_interest_rate_type_id(
                                   p_deal_interest_rate_type_code => smb_deposit_utl.REPLENISHMENT_TYPE);
    if l_id is null then
       l_id := smb_deposit_utl.create_deal_interest_rate_type(
                              p_object_type_code => smb_deposit_utl.TRANCHE_OBJECT_TYPE_CODE
                             ,p_type_code        => smb_deposit_utl.REPLENISHMENT_TYPE
                             ,p_type_name        => 'Поповнення'
                              );     
    end if;
    l_id             := smb_deposit_utl.get_deal_interest_rate_type_id(
                                   p_deal_interest_rate_type_code => smb_deposit_utl.AMOUNT_SETTING_TYPE);
    if l_id is null then
       l_id := smb_deposit_utl.create_deal_interest_rate_type(
                              p_object_type_code => smb_deposit_utl.TRANCHE_OBJECT_TYPE_CODE
                             ,p_type_code        => smb_deposit_utl.AMOUNT_SETTING_TYPE
                             ,p_type_name        => 'Суми траншів'
                              );     
    end if;
    l_id             := smb_deposit_utl.get_deal_interest_rate_type_id(
                                   p_deal_interest_rate_type_code => smb_deposit_utl.REPLENISHMENT_TRANCHE_TYPE);
    if l_id is null then
       l_id := smb_deposit_utl.create_deal_interest_rate_type(
                              p_object_type_code => smb_deposit_utl.TRANCHE_OBJECT_TYPE_CODE
                             ,p_type_code        => smb_deposit_utl.REPLENISHMENT_TRANCHE_TYPE
                             ,p_type_name        => 'Строки поповнення траншів'
                              );     
    end if;
    -- для депозитов по требованию
    l_id             := smb_deposit_utl.get_deal_interest_rate_type_id(
                                   p_deal_interest_rate_type_code => smb_deposit_utl.ON_DEMAND_GENERAL_TYPE);
    if l_id is null then
       l_id := smb_deposit_utl.create_deal_interest_rate_type(
                              p_object_type_code => smb_deposit_utl.ON_DEMAND_OBJECT_TYPE_CODE
                             ,p_type_code        => smb_deposit_utl.ON_DEMAND_GENERAL_TYPE
                             ,p_type_name        => 'Базова % ставка Вклади на вимогу'
                              );     
    end if;
    -- для депозитов по требованию метод начисления
    l_id             := smb_deposit_utl.get_deal_interest_rate_type_id(
                                   p_deal_interest_rate_type_code => smb_deposit_utl.DEPOSIT_ON_DEMAND_CALC_TYPE);
    if l_id is null then
       l_id := smb_deposit_utl.create_deal_interest_rate_type(
                              p_object_type_code => smb_deposit_utl.ON_DEMAND_OBJECT_TYPE_CODE
                             ,p_type_code        => smb_deposit_utl.DEPOSIT_ON_DEMAND_CALC_TYPE
                             ,p_type_name        => 'Метод нарахування %'
                              );     
    end if;
    -- транш дополнительная ставка при пролонгации  
    l_id             := smb_deposit_utl.get_deal_interest_rate_type_id(
                                   p_deal_interest_rate_type_code => smb_deposit_utl.PROLONGATION_BONUS_TYPE);
    if l_id is null then
       l_id := smb_deposit_utl.create_deal_interest_rate_type(
                              p_object_type_code => smb_deposit_utl.TRANCHE_OBJECT_TYPE_CODE
                             ,p_type_code        => smb_deposit_utl.PROLONGATION_BONUS_TYPE
                             ,p_type_name        => 'бонусні % ставки при пролонгації'
                              );     
    end if;
    l_id             := smb_deposit_utl.get_deal_interest_rate_type_id(
                                   p_deal_interest_rate_type_code => smb_deposit_utl.RATE_FOR_BLOCKED_TRANCHE_TYPE);
    if l_id is null then
       l_id := smb_deposit_utl.create_deal_interest_rate_type(
                              p_object_type_code => smb_deposit_utl.TRANCHE_OBJECT_TYPE_CODE
                             ,p_type_code        => smb_deposit_utl.RATE_FOR_BLOCKED_TRANCHE_TYPE
                             ,p_type_name        => '% ставки для заблокованих траншів срок дії яких закінчився'
                              );     
    end if;
    commit;  
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ==== Scripts /Sql/Bars/Data/DEAL_INTEREST_RATE_TYPE.sql ===== *** End ***
PROMPT ===================================================================================== 
