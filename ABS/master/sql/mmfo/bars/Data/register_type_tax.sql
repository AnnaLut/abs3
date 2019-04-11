PROMPT ==========================================================================
PROMPT *** Run *** = Scripts /Sql/Bars/Data/REGISTER_TYPE_TAX.sql = *** Run *** =
PROMPT ==========================================================================

declare
   l_register_type_id   number; 
begin
    l_register_type_id := register_utl.read_register_type(p_register_code => register_utl.SMB_MILITARY_TAX_CODE).id;
    if l_register_type_id is null then 
       l_register_type_id := register_utl.create_register_type(
                     p_object_type_code => smb_deposit_utl.TRANCHE_OBJECT_TYPE_CODE
                    ,p_register_code    => register_utl.SMB_MILITARY_TAX_CODE
                    ,p_register_name    => 'Військовий збір з ФО строкові транші'
                    ) ;
    end if;
    l_register_type_id := register_utl.read_register_type(p_register_code => register_utl.SMB_INCOME_TAX_CODE).id;
    if l_register_type_id is null then 
       l_register_type_id := register_utl.create_register_type(
                     p_object_type_code => smb_deposit_utl.TRANCHE_OBJECT_TYPE_CODE
                    ,p_register_code    => register_utl.SMB_INCOME_TAX_CODE
                    ,p_register_name    => 'Податок на прибуток з ФО строкові транші'
                    ) ;
    end if;
    commit;

    l_register_type_id := register_utl.read_register_type(p_register_code => register_utl.SMB_DOD_MILITARY_TAX_CODE).id;
    if l_register_type_id is null then 
       l_register_type_id := register_utl.create_register_type(
                     p_object_type_code => smb_deposit_utl.ON_DEMAND_OBJECT_TYPE_CODE
                    ,p_register_code    => register_utl.SMB_DOD_MILITARY_TAX_CODE
                    ,p_register_name    => 'Військовий збір з ФО вклади на вимогу'
                    ) ;
    end if;
    l_register_type_id := register_utl.read_register_type(p_register_code => register_utl.SMB_DOD_INCOME_TAX_CODE).id;
    if l_register_type_id is null then 
       l_register_type_id := register_utl.create_register_type(
                     p_object_type_code => smb_deposit_utl.ON_DEMAND_OBJECT_TYPE_CODE
                    ,p_register_code    => register_utl.SMB_DOD_INCOME_TAX_CODE
                    ,p_register_name    => 'Податок на прибуток з ФО вклади на вимогу'
                    ) ;
    end if;
    commit;
end;
/

PROMPT ==========================================================================
PROMPT *** End *** = Scripts /Sql/Bars/Data/REGISTER_TYPE_TAX.sql = *** End *** =
PROMPT ==========================================================================