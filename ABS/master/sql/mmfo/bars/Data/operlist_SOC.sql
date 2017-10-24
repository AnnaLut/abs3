-- ======================================================================================
-- Author : BAA
-- Date   : 28.07.2017
-- ===================================== <Comments> =====================================
-- Створення WEB функції для COBUMMFO-4080
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET DEFINE       OFF

declare
  l_func_id     bars.operlist.codeoper%type;
  l_armcode     bars.applist.codeapp%type;
begin
  
  -- АРМ Імпорт файлів зарахувань
  l_armcode := '$RM_PENS';
  
  l_func_id := OPERLIST_ADM.ADD_NEW_FUNC
               ( p_name               => 'Імпорт файлів'
               , p_funcname           => '/barsroot/dptsocial/importfiles/importfiles'
               , p_usearc             => 0
               , p_frontend           => 1
               , p_forceupd           => 1
               , p_runnable           => 1
               , p_parent_function_id => null
               );
  
  if ( bars.user_menu_utl.read_arm(l_armcode).frontend = 1 )
  then
    OPERLIST_ADM.ADD_FUNC_TO_ARM
    ( p_codeoper => l_func_id
    , p_codeapp  => l_armcode
    , p_approve  => true
    );
  end if;
  
  l_func_id := OPERLIST_ADM.ADD_NEW_FUNC
               ( p_name               => 'Перегляд імпортованих файлів'
               , p_funcname           => '/barsroot/dptsocial/importfiles/viewimportedfiles'
               , p_usearc             => 0
               , p_frontend           => 1
               , p_forceupd           => 1
               , p_runnable           => 1
               , p_parent_function_id => null
               );
  
  if ( bars.user_menu_utl.read_arm(l_armcode).frontend = 1 )
  then
    OPERLIST_ADM.ADD_FUNC_TO_ARM
    ( p_codeoper => l_func_id
    , p_codeapp  => l_armcode
    , p_approve  => true
    );
  end if;
  
end;
/

commit;
