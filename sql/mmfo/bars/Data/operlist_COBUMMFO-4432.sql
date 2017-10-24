-- ======================================================================================
-- Author : BAA
-- Date   : 21.07.2017
-- ===================================== <Comments> =====================================
-- Створення функції "Управління доступом до минулої банківської дати" 
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET DEFINE       OFF

declare
  l_func_id    operlist.codeoper%type;
begin
  
  l_func_id := OPERLIST_ADM.ADD_NEW_FUNC
               ( p_name     => 'Управління доступом до минулої банківської дати'
               , p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_FDAT_KF&accessCode=2'
               , p_frontend => 1
               , p_runnable => 1
               );
  
  -- додати ф-ю в АРМ
  OPERLIST_ADM.ADD_FUNC_TO_ARM
  ( p_codeoper => l_func_id
  , p_codeapp  => '$RM_BUHG'
  , p_approve  => true
  );
  
  dbms_output.put_line( 'Функцiю #'||l_func_id||' додано в "АРМ Головний Бухгалтер"' );
  
end;
/

commit;
