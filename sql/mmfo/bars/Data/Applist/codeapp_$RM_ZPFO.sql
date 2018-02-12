declare 
l_function_id number;
l_application_id number;
begin 
 user_menu_utl.cor_arm(      p_arm_code              => '$RM_ZPFO', 
                             p_arm_name              => 'АРМ Зарплатні проекти(фронт-офіс)', 
                             p_application_type_id   => 1);
                             
 l_application_id := user_menu_utl.get_arm_id('$RM_ZPFO');  
                             
 l_function_id:= abs_utils.add_func(         p_name     => 'Портфель Зарплатних проектів (фронт-офіс)',
                             p_funcname => '/barsroot/SalaryBag/SalaryBag/Index?formType=0',
                             p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                             p_frontend => 1
                        );
                        
                                                  
 resource_utl.set_resource_access_mode(3, l_application_id, 7, l_function_id, 1);
 
 
 l_function_id:= abs_utils.add_func(         p_name     => 'Архів угод ЗП',
                             p_funcname => '/barsroot/SalaryBag/SalaryBag/Index?formType=2',
                             p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                             p_frontend => 1
                        );
                                                  
 resource_utl.set_resource_access_mode(3, l_application_id, 7, l_function_id, 1);
 
 l_function_id:= abs_utils.add_func(
                                                  p_name     => 'Довідники NEW',
                                                  p_funcname => '/barsroot/referencebook/referencelist/',
                                                  p_rolename => '' ,    
                                                  p_frontend => 1
                                                  );
 resource_utl.set_resource_access_mode(3, l_application_id, 7, l_function_id, 1);
 
  l_function_id:= abs_utils.add_func(
                                                  p_name     => 'Обробка ЗП відомостей(Фронт-офіс)',
                                                  p_funcname => '/barsroot/SalaryBag/SalaryBag/SalaryProcessing?formType=0',
                                                  p_rolename => '' ,    
                                                  p_frontend => 1
                                                  );
 resource_utl.set_resource_access_mode(3, l_application_id, 7, l_function_id, 1);
 
  
     insert into REFERENCES (  TABID,  TYPE)
    select tabid, 20
    from meta_tables m 
    where tabname='V_ZP_TARIF' and not exists
    ( select 1 from REFERENCES where tabid =m.tabid);
    insert into  REFAPP (  TABID, CODEAPP,  ACODE,  APPROVE )
    select tabid, '$RM_ZPFO','RW',1
    from meta_tables m 
    where tabname='V_ZP_TARIF' and not exists
    ( select 1 from REFAPP where codeapp ='$RM_ZPFO' and tabid =m.tabid);
    
    
    insert into REFERENCES (  TABID,  TYPE)
    select tabid, 20
    from meta_tables m 
    where tabname='V_ZP_DEALS_FS' and not exists
    ( select 1 from REFERENCES where tabid =m.tabid);
    
    insert into  REFAPP (  TABID, CODEAPP,  ACODE,  APPROVE )
    select tabid, '$RM_ZPFO','RW',1
    from meta_tables m 
    where tabname='V_ZP_DEALS_FS' and not exists
    ( select 1 from REFAPP where codeapp ='$RM_ZPFO' and tabid =m.tabid);
    
end;
/
commit;
/