begin   

branch_attribute_utl.create_attribute('STATSIGN_PROVIDER', 'Провайдер для наложения подписи на статотчетность(SIFER/IIT)', 'C');

branch_attribute_utl.set_attribute_value(
        '/',
        'STATSIGN_PROVIDER',
        'SIFER');      -- OR IIT
end;
/
commit;
/