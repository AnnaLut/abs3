set define off
prompt Создание функций COBUVEKSEL
declare
l_func_id_main number;
l_func_id_scan number;
l_func_id_save_scan number;
l_func_id_extract number;

l_func_id_getbills number;
l_func_id_sendToRegion number;
l_func_id_receiverWithBills number;
l_func_id_extracts number;
l_func_id_getbillsfromca number;

l_func_id_opers number;

l_func_id_debt number;

l_func_id_ext_arch number;

l_func_id_file_arch number;
l_func_id_report_settings number;
begin
    l_func_id_main := operlist_adm.add_new_func(p_name => 'Робота з судовими рішеннями', p_funcname => '/barsroot/bills/bills/receivers', p_frontend => 1, p_runnable => 1);
    l_func_id_scan := operlist_adm.add_new_func(p_name => 'Сканування документів', p_funcname => '/barsroot/bills/scan_docs.aspx?exp_id=\S*', p_frontend => 1, p_runnable => 3, p_parent_function_id => l_func_id_main);
    l_func_id_save_scan := operlist_adm.add_new_func(p_name => 'Збереження відсканованих документів', p_funcname => '/barsroot/bills/textboxscanner_upload.aspx?sid=image_bill_data&rnd=\S*', p_frontend => 1, p_runnable => 3, p_parent_function_id => l_func_id_main);
    l_func_id_extract := operlist_adm.add_new_func(p_name => 'Формування витягу ', p_funcname => '/barsroot/bills/bills/careceivers', p_frontend => 1, p_runnable => 1);
    
    l_func_id_getbills := operlist_adm.add_new_func(p_name => 'Отримання векселів від ДКСУ', p_funcname => '/barsroot/bills/bills/getbills', p_frontend => 1, p_runnable => 1);
    l_func_id_sendToRegion := operlist_adm.add_new_func(p_name => 'Передача векселів на регіони', p_funcname => '/barsroot/bills/bills/sendtoregion', p_frontend => 1, p_runnable => 1);
    l_func_id_receiverWithBills := operlist_adm.add_new_func(p_name => 'Видача векселів стягувачу', p_funcname => '/barsroot/bills/bills/receiverswithbills', p_frontend => 1, p_runnable => 1);
    l_func_id_extracts := operlist_adm.add_new_func(p_name => 'Реєстр витягів', p_funcname => '/barsroot/bills/bills/extracts', p_frontend => 1, p_runnable => 1);
    l_func_id_getbillsfromca := operlist_adm.add_new_func(p_name => 'Отримання векселів від ЦА', p_funcname => '/barsroot/bills/bills/getbillsfromca', p_frontend => 1, p_runnable => 1);
    
    l_func_id_opers := operlist_adm.add_new_func(p_name => 'Перегляд проводок по векселям', p_funcname => '/barsroot/bills/bills/opers', p_frontend => 1, p_runnable => 1);
    l_func_id_debt := operlist_adm.add_new_func(p_name => 'Розрахунки сум реструктуризованої заборгованості', p_funcname => '/barsroot/bills/bills/AmountOfRestrDebt', p_frontend => 1, p_runnable => 1);
    
    l_func_id_ext_arch := operlist_adm.add_new_func(p_name => 'Архів реєстру витягів', p_funcname => '/barsroot/bills/bills/extractsdetail', p_frontend => 1, p_runnable => 1);
    
    l_func_id_file_arch := operlist_adm.add_new_func(p_name => 'Звітність', p_funcname => '/barsroot/bills/bills/filestorage', p_frontend => 1, p_runnable => 1);
    
    l_func_id_report_settings := operlist_adm.add_new_func(p_name => 'Налаштування звітів', p_funcname => '/barsroot/bills/report/settings', p_frontend => 1, p_runnable => 1);
end;
/
commit;
/
set define on