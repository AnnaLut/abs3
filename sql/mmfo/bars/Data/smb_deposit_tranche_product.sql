PROMPT ====================================================================================
PROMPT *** Run *** = Scripts /Sql/Bars/Data/SMB_DEPOSIT_TRANCHE_PRODUCT.sql = *** Run *** =
PROMPT ====================================================================================

declare
    l_product_id          number;
    l_object_type_id      number;
    l_segment_of_business number;
begin
    l_object_type_id := object_utl.read_object_type(
                                        p_object_type_code => smb_deposit_utl.TRANCHE_OBJECT_TYPE_CODE
                                       ,p_raise_ndf        => false).id;

    l_product_id  := product_utl.read_product(
                               p_product_type_id => l_object_type_id
                              ,p_product_code    => smb_deposit_utl.TRANCHE_PRODUCT_CODE
                              ,p_raise_ndf       => false).id;
    select max(id)
      into l_segment_of_business  
      from segment_of_business 
     where segment_code = smb_deposit_utl.SEGMENT_OF_BUSINESS_CODE;
      
    if (l_product_id is null) then
        l_product_id := product_utl.create_product(
                                        p_deal_type_id           => l_object_type_id
                                       ,p_product_code           => smb_deposit_utl.TRANCHE_PRODUCT_CODE
                                       ,p_product_name           => 'Строкові транші по депозитам ММСБ'
                                       ,p_segment_of_business_id => l_segment_of_business);
       commit;
    end if;
end;
/

PROMPT ====================================================================================
PROMPT *** End *** = Scripts /Sql/Bars/Data/SMB_DEPOSIT_TRANCHE_PRODUCT.sql = *** End *** =
PROMPT ====================================================================================