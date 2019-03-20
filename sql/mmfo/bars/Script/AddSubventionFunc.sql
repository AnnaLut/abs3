declare
    l_function_id number;
begin
    l_function_id   :=   abs_utils.add_func(
                                                  p_name     => 'Обробка пакетів з ЄБК (субсидії)',
                                                  p_funcname => '/barsroot/Subvention/SubMonitoring/index',
                                                  p_rolename => '' ,
                                                  p_frontend => 1
                                                  );
    USER_MENU_UTL.ADD_FUNC2ARM (P_FUNC_ID => l_function_id, 
                                p_arm_code => '$RM_BVBB', -- АРМ Бек-офісу
                                p_approve => 1); 
    dbms_output.put_line('Функцiя №' || l_function_id || ' <Обробка пакетів з ЄБК (субсидії)> - добвлена в АРМ Бек-офісу');
COMMIT;
end;