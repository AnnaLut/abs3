PROMPT ================================================================================
PROMPT *** Run *** = Scripts /Sql/Bars/Data/REGISTER_TYPE_ON_DEMAND.sql = *** Run *** =
PROMPT ================================================================================

declare
   l_register_type_id   number; 
begin
    l_register_type_id := register_utl.read_register_type(p_register_code => register_utl.SMB_DOD_PRINCIPAL_AMOUNT_CODE).id;
    if l_register_type_id is null then 
       l_register_type_id := register_utl.create_register_type(
                     p_object_type_code => smb_deposit_utl.ON_DEMAND_OBJECT_TYPE_CODE
                    ,p_register_code    => register_utl.SMB_DOD_PRINCIPAL_AMOUNT_CODE
                    ,p_register_name    => 'Основная сумма для депозитов по требованию'
                    ) ;
    end if;
    l_register_type_id := register_utl.read_register_type(p_register_code => register_utl.SMB_DOD_INTEREST_AMOUNT_CODE).id;
    if l_register_type_id is null then 
       l_register_type_id := register_utl.create_register_type(
                     p_object_type_code => smb_deposit_utl.ON_DEMAND_OBJECT_TYPE_CODE
                    ,p_register_code    => register_utl.SMB_DOD_INTEREST_AMOUNT_CODE
                    ,p_register_name    => 'Рассчитанные проценты для депозитов по требованию'
                    ) ;
    end if;
    l_register_type_id := register_utl.read_register_type(p_register_code => register_utl.SMB_DOD_INTEREST_PAID_CODE).id;
    if l_register_type_id is null then 
       l_register_type_id := register_utl.create_register_type(
                     p_object_type_code => smb_deposit_utl.ON_DEMAND_OBJECT_TYPE_CODE
                    ,p_register_code    => register_utl.SMB_DOD_INTEREST_PAID_CODE
                    ,p_register_name    => 'Выплаченные проценты для депозитов по требованию'
                    ) ;
    end if;
    l_register_type_id := register_utl.read_register_type(p_register_code => register_utl.SMB_DOD_PENALTY_AMOUNT_CODE).id;
    if l_register_type_id is null then 
       l_register_type_id := register_utl.create_register_type(
                     p_object_type_code => smb_deposit_utl.ON_DEMAND_OBJECT_TYPE_CODE
                    ,p_register_code    => register_utl.SMB_DOD_PENALTY_AMOUNT_CODE
                    ,p_register_name    => 'Начисленный штрафа для депозитов по требованию'
                    ) ;
    end if;
    commit;
end;
/

PROMPT ================================================================================
PROMPT *** End *** = Scripts /Sql/Bars/Data/REGISTER_TYPE_ON_DEMAND.sql = *** End *** =
PROMPT ================================================================================