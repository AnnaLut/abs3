SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_3771.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  3771 ***
  declare
    l_application_code varchar2(10 char) := '3771';
    l_application_name varchar2(300 char) := 'АРМ Відшкодування комісійної винагороди банку';
    l_application_type_id integer := user_menu_utl.APPLICATION_TYPE_WEB;
    l_function_ids number_list := number_list();
    l_function_codeoper     OPERLIST.CODEOPER%type;
    l_function_deps         OPERLIST.CODEOPER%type;
    l_application_id integer;
    l_role_resource_type_id integer := resource_utl.get_resource_type_id(user_role_utl.RESOURCE_TYPE_ROLE);
    l_arm_resource_type_id  integer := resource_utl.get_resource_type_id(user_menu_utl.get_arm_resource_type_code(l_application_type_id));
    l_func_resource_type_id integer := resource_utl.get_resource_type_id(user_menu_utl.get_func_resource_type_code(l_application_type_id));
    l integer := 0;
    d integer := 0;
begin
     DBMS_OUTPUT.PUT_LINE(' 3771 створюємо (або оновлюємо) АРМ Відшкодування комісійної винагороди банку');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code, 
                             P_ARM_NAME              => l_application_name, 
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 

     DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Акти на відшкодування комісійної винагороди банку ********** ');
          --  Створюємо функцію Акти на відшкодування комісійної винагороди банку
     l := l +1;
     l_function_ids.extend(l);      
     l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Акти на відшкодування комісійної винагороди банку',
                                                  p_funcname => '/barsroot/accpreport/accpreport/index',
                                                  p_rolename => null,    
                                                  p_frontend => l_application_type_id
                                                  );
      
      DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Довідники NEW ********** ');
          --  Створюємо функцію Довідники NEW
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Довідники NEW',
                                                  p_funcname => '/barsroot/referencebook/referencelist/',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
      DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Друк звітів ********** ');
          --  Створюємо функцію Друк звітів
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Друк звітів',
                                                  p_funcname => '/barsroot/cbirep/rep_list.aspx?codeapp=\S*',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу (3771) - АРМ Відшкодування комісійної винагороди банку  ');
    l := l_function_ids.first;
    while (l is not null and l_function_ids(l)  is not null) loop
        resource_utl.set_resource_access_mode(l_arm_resource_type_id, l_application_id, l_func_resource_type_id, l_function_ids(l), 1);
        l := l_function_ids.next(l);
    end loop;
     
     
    DBMS_OUTPUT.PUT_LINE(' Bидані функції можливо потребують підтвердження - автоматично підтверджуємо їх ');
    for i in (select a.id
              from   adm_resource_activity a
              where  a.grantee_type_id = l_arm_resource_type_id and
                     a.resource_type_id = l_func_resource_type_id and
                     a.grantee_id = l_application_id and
                     a.resource_id in (select column_value from table(l_function_ids))  and
                     a.access_mode_id = 1 and
                     a.resolution_time is null) loop
        resource_utl.approve_resource_access(i.id, 'Автоматичне підтвердження прав на функції для АРМу');
    end loop;
     DBMS_OUTPUT.PUT_LINE(' Commit;  ');
   commit;
end;
/

prompt -- 2. Добавление справочников

declare
  l_id   meta_tables.tabid%type;
  l_name meta_tables.tabname%type := 'ACCP_ORGS';
begin
  begin
     select tabid into l_id from meta_tables where tabname = l_name;
  exception when no_data_found then l_id := null;
  end;

  if l_id is not null then
     begin
      INSERT INTO REFERENCES ( TABID,  TYPE, DLGNAME, ROLE2EDIT ) 
      VALUES (                 l_id, 12, '',    'START1'); 
      EXCEPTION WHEN DUP_VAL_ON_INDEX THEN 
         DBMS_OUTPUT.PUT_LINE('- Такой справочник уже есть ' || l_name);
     end;
  end if;

  if l_id is not null then
     begin
        insert into refapp (codeapp, tabid, acode, approve)
        values ('3771', l_id, 'RW', 1);
     exception when dup_val_on_index then null;
     end;
  end if;
end;
/

declare
  l_id   meta_tables.tabid%type;
  l_name meta_tables.tabname%type := 'ACCP_ACCOUNTS';
begin
  begin
     select tabid into l_id from meta_tables where tabname = l_name;
  exception when no_data_found then l_id := null;
  end;

  if l_id is not null then
     begin
      INSERT INTO REFERENCES ( TABID,  TYPE, DLGNAME, ROLE2EDIT ) 
      VALUES (                 l_id, 12, '',    'START1'); 
      EXCEPTION WHEN DUP_VAL_ON_INDEX THEN 
         DBMS_OUTPUT.PUT_LINE('- Такой справочник уже есть  '||l_name);
     end;
  end if;

  if l_id is not null then
     begin
        insert into refapp (codeapp, tabid, acode, approve)
        values ('3771', l_id, 'RW', 1);
     exception when dup_val_on_index then null;
     end;
  end if;
end;
/

declare
  l_id   meta_tables.tabid%type;
  l_name meta_tables.tabname%type := 'TARIF';
begin
  begin
     select tabid into l_id from meta_tables where tabname = l_name;
  exception when no_data_found then l_id := null;
  end;
  if l_id is not null then
     begin
        insert into refapp (codeapp, tabid, acode, approve)
        values ('3771', l_id, 'RW', 1);
     exception when dup_val_on_index then null;
     end;
  end if;
end;
/


/*
prompt -- 3. Добавление отчетов
*/

commit;

begin
  for k in ( select id from applist_staff where codeapp = '3771')
  loop 
     bars_useradm.change_user_privs(k.id);
  end loop;
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_3771.sql =========**
PROMPT ===================================================================================== 
