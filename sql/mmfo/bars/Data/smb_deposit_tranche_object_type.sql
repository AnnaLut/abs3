PROMPT ========================================================================================
PROMPT *** Run *** = Scripts /Sql/Bars/Data/SMB_DEPOSIT_TRANCHE_OBJECT_TYPE.sql = *** Run *** =
PROMPT ========================================================================================

declare
    l_object_type_id         number;
begin
    l_object_type_id := object_utl.read_object_type(
                                        p_object_type_code => smb_deposit_utl.TRANCHE_OBJECT_TYPE_CODE
                                       ,p_raise_ndf        => false).id;
    if (l_object_type_id is null) then
        object_utl.cor_object_type(
                        p_object_type_code        => smb_deposit_utl.TRANCHE_OBJECT_TYPE_CODE
                       ,p_object_type_name        => 'Äåïîçèòí³ òðàíø³ ÌÌÑÁ'
                       ,p_parent_object_type_code => smb_deposit_utl.PARENT_OBJECT_TYPE_CODE);
       commit;
    end if;
end;
/

PROMPT ========================================================================================
PROMPT *** End *** = Scripts /Sql/Bars/Data/SMB_DEPOSIT_TRANCHE_OBJECT_TYPE.sql = *** End *** =
PROMPT ========================================================================================