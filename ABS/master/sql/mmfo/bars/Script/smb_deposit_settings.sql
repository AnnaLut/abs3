begin
    object_utl.cor_object_type('CUSTOMER_FUNDS', 'Кошти клієнтів', 'DEAL');
    object_utl.cor_object_type('SMB_DEPOSIT_TRANCHE', 'Депозитні транші ММСБ', 'CUSTOMER_FUNDS');
    object_utl.cor_object_type('SMB_DEPOSIT_ON_DEMAND', 'Вклади на вимогу ММСБ', 'CUSTOMER_FUNDS');

    commit;
end;
/

declare
    l_product_id integer;
    l_object_type_id integer;
begin
    l_object_type_id := object_utl.get_object_type_id('SMB_DEPOSIT_TRANCHE');
    l_product_id := product_utl.read_product(l_object_type_id, 'SMB_DEPOSIT_TRANCHE', p_raise_ndf => false).id;

    if (l_product_id is null) then
        l_product_id := product_utl.create_product(l_object_type_id, 'SMB_DEPOSIT_TRANCHE', 'Строкові транші депозитів ММСБ', null, null, null, null);
    end if;

    l_object_type_id := object_utl.get_object_type_id('SMB_DEPOSIT_ON_DEMAND');
    l_product_id := product_utl.read_product(l_object_type_id, 'SMB_DEPOSIT_ON_DEMAND', p_raise_ndf => false).id;

    if (l_product_id is null) then
        l_product_id := product_utl.create_product(l_object_type_id, 'SMB_DEPOSIT_ON_DEMAND', 'Вклади на вимогу ММСБ', null, null, null, null);
    end if;

    commit;
end;
/
