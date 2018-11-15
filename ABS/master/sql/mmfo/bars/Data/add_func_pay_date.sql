set define off
declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_TEHA';
begin   
    -- —оздать обновить функцию
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     'Оплата документів за вимогою',   
                    p_funcname  =>     '/barsroot/Utilities/PayDocs/',                                
                    p_frontend  =>      1 );                      
 
    
    umu.add_func2arm(l_codeoper, l_codearm, 1 ); 
    
    commit;
end;
/