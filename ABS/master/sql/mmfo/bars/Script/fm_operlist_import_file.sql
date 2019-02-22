prompt Создание новой функции для загрузки файла ФМ. публ. деятели от pep.org.ua
declare
l_codeoper number;
l_application_code varchar2(10 char) := '$RM_W_FM';
l_application_id integer := user_menu_utl.get_arm_id(l_application_code);
l_application_type_id integer := user_menu_utl.APPLICATION_TYPE_WEB;
l_arm_resource_type_id  integer := resource_utl.get_resource_type_id(user_menu_utl.get_arm_resource_type_code(l_application_type_id));
l_func_resource_type_id integer := resource_utl.get_resource_type_id(user_menu_utl.get_func_resource_type_code(l_application_type_id));
begin
    l_codeoper   :=   abs_utils.add_func(p_name     => 'Імпорт файлів з переліком PEP',
                                         p_funcname => '/barsroot/finmon/finmon/ImportFile?fileType=PEP',
                                         p_rolename => '' ,
                                         p_frontend => user_menu_utl.APPLICATION_TYPE_WEB);
    resource_utl.set_resource_access_mode(l_arm_resource_type_id, l_application_id, l_func_resource_type_id, l_codeoper, 1);
end;
/
prompt Замена строки вызова для функций ФМ Импорт файла %
update operlist
set funcname = '/barsroot/finmon/finmon/ImportFile?fileType=KIS',
    name = 'Імпорт файлів з переліком КІС'
where funcname in ('/barsroot/finmon/finmon/ImportPublicFigures');

update operlist
set funcname = '/barsroot/finmon/finmon/ImportFile?fileType=Terr'
where funcname in ('/barsroot/finmon/finmon/importterrorists');

commit;
