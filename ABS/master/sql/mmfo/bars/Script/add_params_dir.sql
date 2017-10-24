begin   

branch_attribute_utl.create_attribute('OWINDIR', 'WAY4. Шлях до каталогу вхідних файлів(WEB)', 'C');
branch_attribute_utl.create_attribute('OWOUTDIR', 'WAY4. Шлях до каталогу вихідних файлів(WEB)', 'C');
branch_attribute_utl.create_attribute('OWARCDIR', 'WAY4. Шлях до каталогу арх. вхідних файлів(WEB)', 'C');

branch_attribute_utl.create_attribute('USEPAREXEC', 'Включення парарельної обробки', 'N');
branch_attribute_utl.create_attribute('NUMPARLEVEL', 'Кількість потоків для паралельної обробки', 'N');
branch_attribute_utl.create_attribute('NUMPARGROUP', 'Кількість груп для паралельної обробки', 'N');

/*
branch_attribute_utl.set_attribute_value(
'/',
'USEPAREXEC',
'1');  

branch_attribute_utl.set_attribute_value(
'/',
'NUMPARLEVEL',
'8');  

branch_attribute_utl.set_attribute_value(
'/',
'NUMPARGROUP',
'50');  



branch_attribute_utl.set_attribute_value(
'/300465/',
'OWINDIR',
'D:\way_test\300465\In');    --локальная ссылка для обмена файлами 
branch_attribute_utl.set_attribute_value(
'/300465/',
'OWOUTDIR',
'D:\way_test\300465\Out');   --локальная ссылка для обмена файлами 
branch_attribute_utl.set_attribute_value(
'/300465/',
'OWARCDIR',
'D:\way_test\300465\Arc'); --локальная ссылка для обмена файлами 
branch_attribute_utl.set_attribute_value(
'/322669/',
'OWINDIR',
'D:\way_test\322669\In');    --локальная ссылка для обмена файлами 
branch_attribute_utl.set_attribute_value(
'/322669/',
'OWOUTDIR',
'D:\way_test\322669\Out');   --локальная ссылка для обмена файлами 
branch_attribute_utl.set_attribute_value(
'/322669/',
'OWARCDIR',
'D:\way_test\322669\Arc'); --локальная ссылка для обмена файлами 
branch_attribute_utl.set_attribute_value(
'/324805/',
'OWINDIR',
'D:\way_test\324805\In');    --локальная ссылка для обмена файлами 
branch_attribute_utl.set_attribute_value(
'/324805/',
'OWOUTDIR',
'D:\way_test\324805\Out');   --локальная ссылка для обмена файлами 
branch_attribute_utl.set_attribute_value(
'/324805/',
'OWARCDIR',
'D:\way_test\324805\Arc'); --локальная ссылка для обмена файлами 
        
*/
end;
/
commit;
/