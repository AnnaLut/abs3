begin   

branch_attribute_utl.create_attribute('EWAEMAIL', 'Логин користувача EWA', 'C');
branch_attribute_utl.create_attribute('EWAHASH', 'Хеш пароля', 'C');
branch_attribute_utl.create_attribute('EWAID', 'Код технічного користувача', 'C');
branch_attribute_utl.create_attribute('EWAURL', 'Адреса сервісів ПЗ EWA', 'C');

branch_attribute_utl.set_attribute_value(
        '/',
        'EWAEMAIL',
        'bars@unity-bars.com');   
        branch_attribute_utl.set_attribute_value(
        '/',
        'EWAHASH',
        '3f2774623a1e0aec808df1ba3000fdc679c6693b');   
        branch_attribute_utl.set_attribute_value(
        '/',
        'EWAID',
        '43'); 
         branch_attribute_utl.set_attribute_value(
        '/',
        'EWAURL',
        'https://oschadbank.ewa.ua/ewa/api/v2/');   
end;
/
commit;
/