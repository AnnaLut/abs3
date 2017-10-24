-- ======================================================================================
-- Author : BAA
-- Date   : 19.05.2017
-- ===================================== <Comments> =====================================
-- ��������� WEB �������:
--  "����������� �������, �� ��������������"
--  "������������ XSD ���� ����� ������� ���"
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET DEFINE       OFF

declare
  l_func_id     operlist.codeoper%type;
  l_armcode     applist.codeapp%type;
begin
  
  -- �������� �������:
  l_func_id := OPERLIST_ADM.ADD_NEW_FUNC
               ( p_name               => '����������� �������, �� ��������������'
               , p_funcname           => '/barsroot/SyncTablesEditor/SyncTablesEditor/index'
               , p_usearc             => 0    -- ������������ �� ������ ������� � ������ � �������� ������
               , p_frontend           => 1    -- 1 - web ���������, 0 - desctop
               , p_forceupd           => 1    -- ������������� ����������. 1 - ���� ���������� (�� p_funcname)
               , p_runnable           => 1    -- 
               , p_parent_function_id => null --
               );
  
  l_armcode := '$RM_MAIN';
    
  if ( user_menu_utl.read_arm(l_armcode).frontend = 1 )
  then -- ���������� ������� � ARM
    OPERLIST_ADM.ADD_FUNC_TO_ARM
    ( p_codeoper => l_func_id
    , p_codeapp  => l_armcode
    , p_approve  => true 
    );
  end if;
  
  l_armcode := '$RM_DEVR';
  
  if ( user_menu_utl.read_arm(l_armcode).frontend = 1 )
  then -- ���������� ������� � ARM
    OPERLIST_ADM.ADD_FUNC_TO_ARM
    ( p_codeoper => l_func_id
    , p_codeapp  => l_armcode
    , p_approve  => true 
    );
  end if;
  
end;
/

commit;

declare
  l_func_id     operlist.codeoper%type;
  l_armcode     applist.codeapp%type;
begin
  
  -- �������� �������:
  l_func_id := OPERLIST_ADM.ADD_NEW_FUNC
               ( p_name               => '������������ XSD ���� ����� ������� ���'
               , p_funcname           => '/barsroot/DownloadXsdScheme/DownloadXsdScheme/index'
               , p_usearc             => 0
               , p_frontend           => 1
               , p_forceupd           => 1
               , p_runnable           => 1
               , p_parent_function_id => null
               );
  
  l_armcode := '$RM_MAIN';
  
  if ( user_menu_utl.read_arm(l_armcode).frontend = 1 )
  then -- ���������� ������� � ARM
    OPERLIST_ADM.ADD_FUNC_TO_ARM
    ( p_codeoper => l_func_id
    , p_codeapp  => l_armcode
    , p_approve  => true 
    );
  end if;
  
  l_armcode := '$RM_NBUR';
  
  if ( user_menu_utl.read_arm(l_armcode).frontend = 1 )
  then -- ���������� ������� � ARM
    OPERLIST_ADM.ADD_FUNC_TO_ARM
    ( p_codeoper => l_func_id
    , p_codeapp  => l_armcode
    , p_approve  => true 
    );
  end if;
  
end;
/

commit;
