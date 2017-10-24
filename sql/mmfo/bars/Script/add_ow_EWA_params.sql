begin  

 branch_attribute_utl.create_attribute('OWEWAURL', 'Адреса для виклику API EWA', 'C');
   
 branch_attribute_utl.set_attribute_value(
        '/',
       'OWEWAURL',
        '/barsroot/api/createdealewa');       
end;
/
commit;
/
