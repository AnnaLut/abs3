PROMPT ===================================================================================== 
PROMPT *** Run *** ==== Scripts /Sql/Bars/Data/DEAL_INTEREST_RATE_KIND.sql ===== *** Run ***
PROMPT ===================================================================================== 

declare
    l_id  number;
begin  
    
    l_id  := smb_deposit_utl.get_deal_interest_rate_kind_id(
                p_deal_interest_rate_kind_code => smb_deposit_utl.GENERAL_KIND_CODE);
    if l_id is null then
       l_id := smb_deposit_utl.create_deal_interest_rate_kind( 
                              p_deal_interest_rate_type_code  => smb_deposit_utl.GENERAL_TYPE
                             ,p_kind_code                     => smb_deposit_utl.GENERAL_KIND_CODE   
                             ,p_kind_name                     => 'Базова ставка по депозиту ММСБ'
                             ,p_applying_condition            => null
                              );
    end if;             
    l_id  := smb_deposit_utl.get_deal_interest_rate_kind_id(
                p_deal_interest_rate_kind_code => smb_deposit_utl.BONUS_KIND_CODE);
    if l_id is null then
       l_id := smb_deposit_utl.create_deal_interest_rate_kind( 
                              p_deal_interest_rate_type_code  => smb_deposit_utl.BONUS_TYPE
                             ,p_kind_code                     => smb_deposit_utl.BONUS_KIND_CODE   
                             ,p_kind_name                     => 'Акційна ставка по депозиту ММСБ'
                             ,p_applying_condition            => null
                              );
    end if;
    l_id  := smb_deposit_utl.get_deal_interest_rate_kind_id(
                p_deal_interest_rate_kind_code => smb_deposit_utl.PROLONGATION_KIND_CODE);
    if l_id is null then
       l_id := smb_deposit_utl.create_deal_interest_rate_kind( 
                              p_deal_interest_rate_type_code  => smb_deposit_utl.PROLONGATION_TYPE
                             ,p_kind_code                     => smb_deposit_utl.PROLONGATION_KIND_CODE   
                             ,p_kind_name                     => 'Пролонгація по депозиту ММСБ'
                             ,p_applying_condition            => null
                              );
    end if;
    l_id  := smb_deposit_utl.get_deal_interest_rate_kind_id(
                p_deal_interest_rate_kind_code => smb_deposit_utl.PENALTY_RATE_KIND_CODE);
    if l_id is null then
       l_id := smb_deposit_utl.create_deal_interest_rate_kind( 
                              p_deal_interest_rate_type_code  => smb_deposit_utl.PENALTY_RATE_TYPE
                             ,p_kind_code                     => smb_deposit_utl.PENALTY_RATE_KIND_CODE   
                             ,p_kind_name                     => 'Шкала % ставок при достроковому поверненню траншів'
                             ,p_applying_condition            => null
                              );
    end if;
    l_id  := smb_deposit_utl.get_deal_interest_rate_kind_id(
                p_deal_interest_rate_kind_code => smb_deposit_utl.CAPITALIZATION_KIND_CODE);
    if l_id is null then
       l_id := smb_deposit_utl.create_deal_interest_rate_kind( 
                              p_deal_interest_rate_type_code  => smb_deposit_utl.CAPITALIZATION_TYPE
                             ,p_kind_code                     => smb_deposit_utl.CAPITALIZATION_KIND_CODE   
                             ,p_kind_name                     => 'Капіталізація по депозиту ММСБ'
                             ,p_applying_condition            => null
                              );
    end if;
    l_id  := smb_deposit_utl.get_deal_interest_rate_kind_id(
                p_deal_interest_rate_kind_code => smb_deposit_utl.PAYMENT_KIND_CODE);
    if l_id is null then
       l_id := smb_deposit_utl.create_deal_interest_rate_kind( 
                              p_deal_interest_rate_type_code  => smb_deposit_utl.PAYMENT_TYPE
                             ,p_kind_code                     => smb_deposit_utl.PAYMENT_KIND_CODE
                             ,p_kind_name                     => 'Виплата по депозиту ММСБ'
                             ,p_applying_condition            => null
                              );
    end if;          
    l_id  := smb_deposit_utl.get_deal_interest_rate_kind_id(
                p_deal_interest_rate_kind_code => smb_deposit_utl.REPLENISHMENT_KIND_CODE);
    if l_id is null then
       l_id := smb_deposit_utl.create_deal_interest_rate_kind( 
                              p_deal_interest_rate_type_code  => smb_deposit_utl.REPLENISHMENT_TYPE
                             ,p_kind_code                     => smb_deposit_utl.REPLENISHMENT_KIND_CODE   
                             ,p_kind_name                     => '% ставка (+/-) при поповненні депозиту ММСБ'
                             ,p_applying_condition            => null
                              );
    end if;
    l_id  := smb_deposit_utl.get_deal_interest_rate_kind_id(
                p_deal_interest_rate_kind_code => smb_deposit_utl.AMOUNT_SETTING_KIND_CODE);
    if l_id is null then
       l_id := smb_deposit_utl.create_deal_interest_rate_kind( 
                              p_deal_interest_rate_type_code  => smb_deposit_utl.AMOUNT_SETTING_TYPE
                             ,p_kind_code                     => smb_deposit_utl.AMOUNT_SETTING_KIND_CODE   
                             ,p_kind_name                     => 'Суми траншів депозиту ММСБ'
                             ,p_applying_condition            => null
                              );
    end if;

    l_id  := smb_deposit_utl.get_deal_interest_rate_kind_id(
                p_deal_interest_rate_kind_code => smb_deposit_utl.REPLENISHMENT_TRN_KIND_CODE);
    if l_id is null then
       l_id := smb_deposit_utl.create_deal_interest_rate_kind( 
                              p_deal_interest_rate_type_code  => smb_deposit_utl.REPLENISHMENT_TRANCHE_TYPE
                             ,p_kind_code                     => smb_deposit_utl.REPLENISHMENT_TRN_KIND_CODE   
                             ,p_kind_name                     => 'Строки поповнення траншів депозиту ММСБ'
                             ,p_applying_condition            => null
                              );
    end if;
    -- для депозитов по требованию
    l_id  := smb_deposit_utl.get_deal_interest_rate_kind_id(
                p_deal_interest_rate_kind_code => smb_deposit_utl.ON_DEMAND_GENERAL_KIND_CODE);
    if l_id is null then
       l_id := smb_deposit_utl.create_deal_interest_rate_kind( 
                              p_deal_interest_rate_type_code  => smb_deposit_utl.ON_DEMAND_GENERAL_TYPE
                             ,p_kind_code                     => smb_deposit_utl.ON_DEMAND_GENERAL_KIND_CODE   
                             ,p_kind_name                     => 'Базова ставка по вклади на вимогу ММСБ'
                             ,p_applying_condition            => null
                              );
    end if;             
    -- для депозитов по требованию метод начисления
    l_id  := smb_deposit_utl.get_deal_interest_rate_kind_id(
                p_deal_interest_rate_kind_code => smb_deposit_utl.ON_DEMAND_CALC_TYPE_KIND_CODE);
    if l_id is null then
       l_id := smb_deposit_utl.create_deal_interest_rate_kind( 
                              p_deal_interest_rate_type_code  => smb_deposit_utl.DEPOSIT_ON_DEMAND_CALC_TYPE
                             ,p_kind_code                     => smb_deposit_utl.ON_DEMAND_CALC_TYPE_KIND_CODE   
                             ,p_kind_name                     => 'Метод нарахування % для вкладів на вимогу ММСБ'
                             ,p_applying_condition            => null
                              );
    end if;             
    l_id  := smb_deposit_utl.get_deal_interest_rate_kind_id(
                p_deal_interest_rate_kind_code => smb_deposit_utl.PROLONGATION_BONUS_KIND_CODE);
    if l_id is null then
       l_id := smb_deposit_utl.create_deal_interest_rate_kind( 
                              p_deal_interest_rate_type_code  => smb_deposit_utl.PROLONGATION_BONUS_TYPE
                             ,p_kind_code                     => smb_deposit_utl.PROLONGATION_BONUS_KIND_CODE   
                             ,p_kind_name                     => 'Бонусна % ставка при пролонгації по депозиту ММСБ'
                             ,p_applying_condition            => null
                              );
    end if;             
    l_id  := smb_deposit_utl.get_deal_interest_rate_kind_id(
                p_deal_interest_rate_kind_code => smb_deposit_utl.RATE_FOR_BLK_TRANCHE_KIND_CODE);
    if l_id is null then
       l_id := smb_deposit_utl.create_deal_interest_rate_kind( 
                              p_deal_interest_rate_type_code  => smb_deposit_utl.RATE_FOR_BLOCKED_TRANCHE_TYPE
                             ,p_kind_code                     => smb_deposit_utl.RATE_FOR_BLK_TRANCHE_KIND_CODE   
                             ,p_kind_name                     => '% ставки для заблокованих траншів срок дії яких закінчився по депозиту ММСБ'
                             ,p_applying_condition            => null
                              );
    end if;             
    commit; 
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ==== Scripts /Sql/Bars/Data/DEAL_INTEREST_RATE_KIND.sql ===== *** End ***
PROMPT ===================================================================================== 
