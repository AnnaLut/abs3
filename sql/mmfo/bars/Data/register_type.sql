PROMPT =============================================================================
PROMPT *** Run *** ==== Scripts /Sql/Bars/Data/REGISTER_TYPE.sql ===== *** Run *** =
PROMPT =============================================================================

declare
   l_register_type_id   number; 
begin
    l_register_type_id := register_utl.read_register_type(p_register_code => register_utl.SMB_PRINCIPAL_AMOUNT_CODE).id;
    if l_register_type_id is null then 
       l_register_type_id := register_utl.create_register_type(
                     p_object_type_code => smb_deposit_utl.TRANCHE_OBJECT_TYPE_CODE
                    ,p_register_code    => register_utl.SMB_PRINCIPAL_AMOUNT_CODE
                    ,p_register_name    => 'Основная сумма'
                    ) ;
    end if;
    l_register_type_id := register_utl.read_register_type(p_register_code => register_utl.SMB_INTEREST_AMOUNT_CODE).id;
    if l_register_type_id is null then 
       l_register_type_id := register_utl.create_register_type(
                     p_object_type_code => smb_deposit_utl.TRANCHE_OBJECT_TYPE_CODE
                    ,p_register_code    => register_utl.SMB_INTEREST_AMOUNT_CODE
                    ,p_register_name    => 'Рассчитанные проценты'
                    ) ;
    end if;
    l_register_type_id := register_utl.read_register_type(p_register_code => register_utl.SMB_INTEREST_PAID_CODE).id;
    if l_register_type_id is null then 
       l_register_type_id := register_utl.create_register_type(
                     p_object_type_code => smb_deposit_utl.TRANCHE_OBJECT_TYPE_CODE
                    ,p_register_code    => register_utl.SMB_INTEREST_PAID_CODE
                    ,p_register_name    => 'Выплаченные проценты (по траншам)'
                    ) ;
    end if;
    l_register_type_id := register_utl.read_register_type(p_register_code => register_utl.SMB_PENALTY_AMOUNT_CODE).id;
    if l_register_type_id is null then 
       l_register_type_id := register_utl.create_register_type(
                     p_object_type_code => smb_deposit_utl.TRANCHE_OBJECT_TYPE_CODE
                    ,p_register_code    => register_utl.SMB_PENALTY_AMOUNT_CODE
                    ,p_register_name    => 'Начисленный штраф (по траншам)'
                    ) ;
    end if;
    l_register_type_id := register_utl.read_register_type(p_register_code => register_utl.SMB_BLOCKED_AMOUNT_CODE).id;
    if l_register_type_id is null then 
       l_register_type_id := register_utl.create_register_type(
                     p_object_type_code => smb_deposit_utl.TRANCHE_OBJECT_TYPE_CODE
                    ,p_register_code    => register_utl.SMB_BLOCKED_AMOUNT_CODE
                    ,p_register_name    => 'Заблокированная сумма'
                    ) ;
    end if;
    commit;
end;
/

PROMPT =============================================================================
PROMPT *** End *** ==== Scripts /Sql/Bars/Data/REGISTER_TYPE.sql ===== *** End *** =
PROMPT =============================================================================
