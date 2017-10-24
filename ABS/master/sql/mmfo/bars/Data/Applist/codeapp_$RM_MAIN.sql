SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_MAIN.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_MAIN ***
  declare
    l_application_code varchar2(10 char) := '$RM_MAIN';
    l_application_name varchar2(300 char) := '��� ������������ ��� ';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_MAIN ��������� (��� ���������) ��� ��� ������������ ���  ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code, 
                             P_ARM_NAME              => l_application_name, 
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ ������� [ ������� -> ����� ������� ] ********** ');
          --  ��������� ������� ������������ ������� [ ������� -> ����� ������� ]
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ ������� [ ������� -> ����� ������� ]',
                                                  p_funcname => '/barsroot/AccessToAccounts/AccGroups/AccGroups',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ ������� [ ����� ������� -> ����� ������������ ] ********** ');
          --  ��������� ������� ������������ ������� [ ����� ������� -> ����� ������������ ]
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ ������� [ ����� ������� -> ����� ������������ ]',
                                                  p_funcname => '/barsroot/AccessToAccounts/AccessToAccounts/accounts',
                                                  p_rolename => 'ABS_ADMIN' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ ������� [ ����� ������������ -> ����� ������� ] ********** ');
          --  ��������� ������� ������������ ������� [ ����� ������������ -> ����� ������� ]
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ ������� [ ����� ������������ -> ����� ������� ]',
                                                  p_funcname => '/barsroot/AccessToAccounts/AccessToAccountsUsers/Users',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��`���� ��`���� ������������� ********** ');
          --  ��������� ������� ��`���� ��`���� �������������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��`���� ��`���� �������������',
                                                  p_funcname => '/barsroot/Admin/CommunicationObject/Index',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ��������� �������� ********** ');
          --  ��������� ������� �������� ��������� ��������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ��������� ��������',
                                                  p_funcname => '/barsroot/DocView/Docs/DocumentDateFilter?type=0',
                                                  p_rolename => 'WR_DOCLIST_TOBO' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� ������ ��� ��������� �� ����
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������ ��� ��������� �� ����',
                                                              p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=21&date=\d{2}\.\d{2}\.\d{4}',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��������� ��������� �������� �� �����
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������ ��������� ��������� �������� �� �����',
                                                              p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=22&dateb=\d{2}\.\d{2}\.\d{4}&datef=\d{2}\.\d{2}\.\d{4}',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��� ��������� �������� �� �����
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������ ��� ��������� �������� �� �����',
                                                              p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=21&dateb=\d{2}\.\d{2}\.\d{4}&datef=\d{2}\.\d{2}\.\d{4}',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��� ��������� �� �������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������ ��� ��������� �� �������',
                                                              p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=11',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� ������ ���������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '�������� ������ ���������',
                                                              p_funcname => '/barsroot/documentview/default.aspx?ref=\S+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��������� ��������� �������� �� ����
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������ ��������� ��������� �������� �� ����',
                                                              p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=22&date=\d{2}\.\d{2}\.\d{4}',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��������� ��������� �������� �� �������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������ ��������� ��������� �������� �� �������',
                                                              p_funcname => '/barsroot/documentsview/documents.aspx?type=0&par=12',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ��̳� ********** ');
          --  ��������� ������� ����������� ��̳�
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ��̳�',
                                                  p_funcname => '/barsroot/admin/adm/index',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� 8
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '8',
                                                              p_funcname => '/barsroot/admin/adm/editadm\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� 6
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '6',
                                                              p_funcname => '/barsroot/admin/adm/createadm\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������������ ������ ������� �� �������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������������ ������ ������� �� �������',
                                                              p_funcname => '/barsroot/admin/adm/setadmresourceaccessmode\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� 2
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '2',
                                                              p_funcname => '/barsroot/admin/adm/getadmlist\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������� ������������ ********** ');
          --  ��������� ������� ������������� ������������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������� ������������',
                                                  p_funcname => '/barsroot/admin/admu/index',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� �������� ����������� ���
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '�������� ����������� ���',
                                                              p_funcname => '/barsroot/admin/admu/closeuser\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ��������� ������ �������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '��������� ������ �������',
                                                              p_funcname => '/barsroot/admin/admu/getbranchlookups\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� 13
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '13',
                                                              p_funcname => '/barsroot/admin/admu/getbranchlist\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ³���� ����������� ���� �����������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '³���� ����������� ���� �����������',
                                                              p_funcname => '/barsroot/admin/admu/cenceldelegateuserrights\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����������� ���� ����������� ������ �����������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '����������� ���� ����������� ������ �����������',
                                                              p_funcname => '/barsroot/admin/admu/delegateuserrights\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ��������� ������ �����������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '��������� ������ �����������',
                                                              p_funcname => '/barsroot/admin/admu/createuser\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ��������� ����� �� �����������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '��������� ����� �� �����������',
                                                              p_funcname => '/barsroot/admin/admu/getuserdata\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� 10
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '10',
                                                              p_funcname => '/barsroot/admin/admu/edituser\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ��������� ������ ����� ����������� �����
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '��������� ������ ����� ����������� �����',
                                                              p_funcname => '/barsroot/admin/admu/getoraroleslookups\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� 19
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '19',
                                                              p_funcname => '/barsroot/admin/admu/unlockuser\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� 18
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '18',
                                                              p_funcname => '/barsroot/admin/admu/lockuser\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������������ ��������� ������ ���������� ���
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������������ ��������� ������ ���������� ���',
                                                              p_funcname => '/barsroot/admin/admu/changeabsuserpassword\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� 2
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '2',
                                                              p_funcname => '/barsroot/admin/admu/getadmulist\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ���� ������ ����������� �����
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '���� ������ ����������� �����',
                                                              p_funcname => '/barsroot/admin/admu/changeorauserpassword\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� 8
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '8',
                                                              p_funcname => '/barsroot/admin/admu/getuserroles\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ��������� ������ �����
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '��������� ������ �����',
                                                              p_funcname => '/barsroot/admin/admu/getrolelookups\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ���������� ��� ������������ � �� ********** ');
          --  ��������� ������� ����� ���������� ��� ������������ � ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ���������� ��� ������������ � ��',
                                                  p_funcname => '/barsroot/admin/ead_sync_queue.aspx',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ ������� ********** ');
          --  ��������� ������� ������������ �������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ �������',
                                                  p_funcname => '/barsroot/admin/globaloptions.aspx',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ������ ������� ��������/�������� ��� ********** ');
          --  ��������� ������� ����������� ������ ������� ��������/�������� ���
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ������ ������� ��������/�������� ���',
                                                  p_funcname => '/barsroot/admin/listset/index',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� ��� ������� ����
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '��� ������� ����',
                                                              p_funcname => '/barsroot/admin/listset/getlistsetdata\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� ����
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������� ����',
                                                              p_funcname => '/barsroot/admin/listset/getlistfuncsetdata\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� ��������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������� ��������',
                                                              p_funcname => '/barsroot/admin/listset/getoperlisthandbookdata\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� �������� ********** ');
          --  ��������� ������� ����������� ��������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ��������',
                                                  p_funcname => '/barsroot/admin/oper/index',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������� ����� ********** ');
          --  ��������� ������� ������������� �����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������� �����',
                                                  p_funcname => '/barsroot/admin/roles/index',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� ���������� ��� ������������ ���
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '���������� ��� ������������ ���',
                                                              p_funcname => '/barsroot/admin/roles/lockrole\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������������ ������ ������� �� ������� ���
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������������ ������ ������� �� ������� ���',
                                                              p_funcname => '/barsroot/admin/roles/setresourceaccessmode\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ��������� ��� ������������ ���
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '��������� ��� ������������ ���',
                                                              p_funcname => '/barsroot/admin/roles/createrole\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������������� ��� ������������ ���
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������������� ��� ������������ ���',
                                                              p_funcname => '/barsroot/admin/roles/unlockrole\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����������� ��� ������������ ���
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '����������� ��� ������������ ���',
                                                              p_funcname => '/barsroot/admin/roles/editrole\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������� ����� ����������� ������� ********** ');
          --  ��������� ������� ������������� ����� ����������� �������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������� ����� ����������� �������',
                                                  p_funcname => '/barsroot/async/admin/index',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� ������ ********** ');
          --  ��������� ������� ������� ������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� ������',
                                                  p_funcname => '/barsroot/async/tasks/index',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� ������ ��������� ����������� �������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������ ��������� ����������� �������',
                                                              p_funcname => '/barsroot/async/tasks/start\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ������������ ********** ');
          --  ��������� ������� ����������� ������������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ������������',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=6304&mode=RW&force=1&rwflag=2',
                                                  p_rolename => 'CUST001' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ��`�� ********** ');
          --  ��������� ������� ����� ��`��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ��`��',
                                                  p_funcname => '/barsroot/barsweb/welcome.aspx',
                                                  p_rolename => 'BASIC_INFO' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���i�i��������� ����� ��`�� ********** ');
          --  ��������� ������� ���i�i��������� ����� ��`��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���i�i��������� ����� ��`��',
                                                  p_funcname => '/barsroot/board/admin/',
                                                  p_rolename => 'WR_BOARD' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� ��������� ����������� ����� ���������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '��������� ����������� ����� ���������',
                                                              p_funcname => '/barsroot/board/delete/\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������������� ���������� ����� ���������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������������� ���������� ����� ���������',
                                                              p_funcname => '/barsroot/board/admin/\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ��������� ����������� ����� ���������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '��������� ����������� ����� ���������',
                                                              p_funcname => '/barsroot/board/add/\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����������� ����������� ����� ���������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '����������� ����������� ����� ���������',
                                                              p_funcname => '/barsroot/board/edit/\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���� ���� ********** ');
          --  ��������� ������� ���� ����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���� ����',
                                                  p_funcname => '/barsroot/cbirep/rep_list.aspx?codeapp=\S*',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� ���� ����
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '���� ����',
                                                              p_funcname => '/barsroot/cbirep/rep_print.aspx?query_id=\d+\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ���� ����
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '���� ����',
                                                              p_funcname => '/barsroot/cbirep/rep_query.aspx?repid=\d+\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� �������(�� �������) ********** ');
          --  ��������� ������� ��������� �������(�� �������)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� �������(�� �������)',
                                                  p_funcname => '/barsroot/customerlist/custacc.aspx?type=2&t=1',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������� ��������� ���������� ********** ');
          --  ��������� ������� ������������� ��������� ����������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������� ��������� ����������',
                                                  p_funcname => '/barsroot/doc/advertising/index/',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� ������������� ��������� ����������(API)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������������� ��������� ����������(API)',
                                                              p_funcname => '/barsroot/api/doc/advertising\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������������� ��������� ����������(�������)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������������� ��������� ����������(�������)',
                                                              p_funcname => '/barsroot/doc/advertising/index\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������������� ��������� ����������(�������� ��������)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������������� ��������� ����������(�������� ��������)',
                                                              p_funcname => '/barsroot/doc/advertising/image\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������������� ��������� ����������(�������� ���.)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������������� ��������� ����������(�������� ���.)',
                                                              p_funcname => '/barsroot/doc/advertising/detail\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������������� ��������� ����������(������������ ��������)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������������� ��������� ����������(������������ ��������)',
                                                              p_funcname => '/barsroot/doc/advertising/fileupload\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������������� ��������� ����������(�����������)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������������� ��������� ����������(�����������)',
                                                              p_funcname => '/barsroot/doc/advertising/edit\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������������� ��������� ����������(����������� ��������)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������������� ��������� ����������(����������� ��������)',
                                                              p_funcname => '/barsroot/doc/advertising/imageeditor\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ���. �������� - �� ��������� ��������(WEB) ********** ');
          --  ��������� ������� ���������� ���. �������� - �� ��������� ��������(WEB)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ���. �������� - �� ��������� ��������(WEB)',
                                                  p_funcname => '/barsroot/docinput/editprops.aspx?mode=0',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� ���������� ���. �������� �� ���.(WEB)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '���������� ���. �������� �� ���.(WEB)',
                                                              p_funcname => '/barsroot/docinput/editprops.aspx?ref=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ���� ********** ');
          --  ��������� ������� ���������� ����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ����',
                                                  p_funcname => '/barsroot/dwh/report/index?moduleId=$RM_MAIN',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� %% �� ���������(����� ������) ********** ');
          --  ��������� ������� ������� %% �� ���������(����� ������)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� %% �� ���������(����� ������)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&tableName=V_PAY_INTEREST_DEPOS&sPar=[NSIFUNCTION]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ��� ����� ********** ');
          --  ��������� ������� ����������� ��� �����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ��� �����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=[PROC=>p_message_for_release(:R)][PAR=>:R(SEM=����� ������ ������ ��������� �����������,TYPE=N)][EXEC=>BEFORE][MSG=>����������� ��������!]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ �� ����� ********** ');
          --  ��������� ������� ������ �� �����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �� �����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=HOLIDAY&accessCode=7&sPar=[NSIFUNCTION][CONDITIONS=>kv=980]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���� ����������� ��� ********** ');
          --  ��������� ������� ���� ����������� ���
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���� ����������� ���',
                                                  p_funcname => '/barsroot/opencloseday/openclose/',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���� ������������������ ********** ');
          --  ��������� ������� ���� ������������������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���� ������������������',
                                                  p_funcname => '/barsroot/perfom/default.aspx',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� NEW ********** ');
          --  ��������� ������� �������� NEW
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� NEW',
                                                  p_funcname => '/barsroot/referencebook/referencelist/',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� ������ ********** ');
          --  ��������� ������� ������� ������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� ������',
                                                  p_funcname => '/barsroot/requestsProcessing/requestsProcessing',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ �������� ����� ********** ');
          --  ��������� ������� ������ �������� �����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ �������� �����',
                                                  p_funcname => '/barsroot/sberutls/import_spr_mon.aspx',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ VIP ********** ');
          --  ��������� ������� ������ VIP
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ VIP',
                                                  p_funcname => '/barsroot/sberutls/import_vip.aspx',
                                                  p_rolename => 'TECH005' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������������ DBF-������� ********** ');
          --  ��������� ������� ������������ DBF-�������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������������ DBF-�������',
                                                  p_funcname => '/barsroot/sberutls/load_dbf.aspx',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ���� ��� ********** ');
          --  ��������� ������� ������ ���� ���
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ���� ���',
                                                  p_funcname => '/barsroot/security/audit',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ ��� ������������ ********** ');
          --  ��������� ������� ������ ��� ������������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ��� ������������',
                                                  p_funcname => '/barsroot/security/usersession',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ���������� ��� ����� ********** ');
          --  ��������� ������� ���. ���������� ��� �����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ���������� ��� �����',
                                                  p_funcname => '/barsroot/sep/sepfiles/index?mode=RW',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ���������� ��������� ���  ( �� ) ********** ');
          --  ��������� ������� ���. ���������� ��������� ���  ( �� )
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ���������� ��������� ���  ( �� )',
                                                  p_funcname => '/barsroot/sep/seplockdocs/index',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� ���������� ��������� ��� (��� �������� ���) (���������)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '���������� ��������� ��� (��� �������� ���) (���������)',
                                                              p_funcname => '/barsroot/sep/seplockdocs/getseplockdoc\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ���������� ��������� ��� (��� �������� ���)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '���������� ��������� ��� (��� �������� ���)',
                                                              p_funcname => '/barsroot/sep/seplockdocs/index\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ���������� ��������� ��� (��� �������� ���)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '���������� ��������� ��� (��� �������� ���)',
                                                              p_funcname => '/barsroot/sep/seplockdocs/index?DefinedCode=1',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_MAIN) - ��� ������������ ���   ');
    l := l_function_ids.first;
    while (l is not null and l_function_ids(l)  is not null) loop
        resource_utl.set_resource_access_mode(l_arm_resource_type_id, l_application_id, l_func_resource_type_id, l_function_ids(l), 1);
        l := l_function_ids.next(l);
    end loop;
     
     
    DBMS_OUTPUT.PUT_LINE(' B���� ������� ������� ���������� ������������ - ����������� ����������� �� ');
    for i in (select a.id
              from   adm_resource_activity a
              where  a.grantee_type_id = l_arm_resource_type_id and
                     a.resource_type_id = l_func_resource_type_id and
                     a.grantee_id = l_application_id and
                     a.resource_id in (select column_value from table(l_function_ids))  and
                     a.access_mode_id = 1 and
                     a.resolution_time is null) loop
        resource_utl.approve_resource_access(i.id, '����������� ������������ ���� �� ������� ��� ����');
    end loop;
     DBMS_OUTPUT.PUT_LINE(' Commit;  ');
   commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_MAIN.sql =========**
PROMPT ===================================================================================== 
