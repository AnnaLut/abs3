SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_WDOC.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_WDOC ***
  declare
    l_application_code varchar2(10 char) := '$RM_WDOC';
    l_application_name varchar2(300 char) := '��� ������������ (�����)';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_WDOC ��������� (��� ���������) ��� ��� ������������ (�����) ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code, 
                             P_ARM_NAME              => l_application_name, 
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ .dbf ����� (�����������)  ********** ');
          --  ��������� ������� ������ .dbf ����� (�����������) 
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ .dbf ����� (�����������) ',
                                                  p_funcname => '/barsroot/ImportDbf',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� ������ .dbf ����� (�����������)  (������� ������� �������)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������ .dbf ����� (�����������)  (������� ������� �������)',
                                                              p_funcname => '/barsroot/importdbf\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ .dbf ����� (�����������)  (����� ������)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������ .dbf ����� (�����������)  (����� ������)',
                                                              p_funcname => '/barsroot/sberutls/importproc.aspx\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �i������� ���� ********** ');
          --  ��������� ������� �i������� ����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�i������� ����',
                                                  p_funcname => '/barsroot/admin/cash_open.aspx',
                                                  p_rolename => 'OPER000' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� �� ��� ********** ');
          --  ��������� ������� ����������� �� ���
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� �� ���',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_alt_bpk',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���� �������� �� ������� ���� ********** ');
          --  ��������� ������� ���� �������� �� ������� ����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���� �������� �� ������� ����',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_dep_odb1',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� ³��� ����� ���������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '³��� ����� ���������',
                                                              p_funcname => '/barsroot/docinput/docinput.aspx\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ������������� ��������� ********** ');
          --  ��������� ������� �������� ������������� ���������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ������������� ���������',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_docum_inf',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ���� ������ ����������� 2012 ********** ');
          --  ��������� ������� ���������� ���� ������ ����������� 2012
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ���� ������ ����������� 2012',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_ret_2012',
                                                  p_rolename => 'PYOD001' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� � 2625/22 ����� ���� ********** ');
          --  ��������� ������� ������� � 2625/22 ����� ����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� � 2625/22 ����� ����',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_ussr2_pay_bpk',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ���� ������ �� ��������� NEW ********** ');
          --  ��������� ������� ���������� ���� ������ �� ��������� NEW
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ���� ������ �� ��������� NEW',
                                                  p_funcname => '/barsroot/barsweb/dynform.aspx?form=frm_v_ret_pox',
                                                  p_rolename => 'PYOD001' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� <<��������������/������ ��������  �� ��������>> ********** ');
          --  ��������� ������� <<��������������/������ ��������  �� ��������>>
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<<��������������/������ ��������  �� ��������>>',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2481&mode=ro&force=1',
                                                  p_rolename => 'PYOD001' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� <<��:���i�i� �� �������>> ********** ');
          --  ��������� ������� <<��:���i�i� �� �������>>
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<<��:���i�i� �� �������>>',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2482&mode=ro&force=1',
                                                  p_rolename => 'PYOD001' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� <<������-������ �� �� ������������� �����>> ********** ');
          --  ��������� ������� <<������-������ �� �� ������������� �����>>
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<<������-������ �� �� ������������� �����>>',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2483&mode=ro&force=1',
                                                  p_rolename => 'PYOD001' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� ��,���,���,���,����� + ��+����� ********** ');
          --  ��������� ������� ������� ��,���,���,���,����� + ��+�����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� ��,���,���,���,����� + ��+�����',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2484&mode=ro&force=1',
                                                  p_rolename => 'PYOD001' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� <<������>> ********** ');
          --  ��������� ������� <<������>>
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<<������>>',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2485&mode=ro&force=1',
                                                  p_rolename => 'PYOD001' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� <<���������i�>> ********** ');
          --  ��������� ������� <<���������i�>>
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<<���������i�>>',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2686&mode=RO&force=1',
                                                  p_rolename => 'PYOD001' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� <<�������i>> ********** ');
          --  ��������� ������� <<�������i>>
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<<�������i>>',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2787&mode=RO&force=1',
                                                  p_rolename => 'PYOD001' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ������� ���i���� ����� ���� ********** ');
          --  ��������� ������� ��������� ������� ���i���� ����� ����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ������� ���i���� ����� ����',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=2814&mode=ro&force=1',
                                                  p_rolename => 'RCC_DEAL' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� ��������� ������� �������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '��������� ������� �������',
                                                              p_funcname => '/barsroot/credit/repayment.aspx?ccid=\S+&dat1=\d+',
                                                              p_rolename => 'WR_CREDIT' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� <<��:���i�i� �� �������>> ********** ');
          --  ��������� ������� <<��:���i�i� �� �������>>
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<<��:���i�i� �� �������>>',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=3787&mode=ro&force=1',
                                                  p_rolename => 'PYOD001' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����i� �����i-���i�������� ���������i���� �������i� 9760 ********** ');
          --  ��������� ������� ����i� �����i-���i�������� ���������i���� �������i� 9760
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����i� �����i-���i�������� ���������i���� �������i� 9760',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=4095&mode=RO&force=1',
                                                  p_rolename => 'PYOD001' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���i� �i������� �� �� ********** ');
          --  ��������� ������� ���i� �i������� �� ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���i� �i������� �� ��',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=4161&mode=RO&force=1',
                                                  p_rolename => 'PYOD001' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� <<��:����� �� ������� �� ���������� ������� >> ********** ');
          --  ��������� ������� <<��:����� �� ������� �� ���������� ������� >>
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<<��:����� �� ������� �� ���������� ������� >>',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabid=7338&mode=RO&force=1',
                                                  p_rolename => 'PYOD001' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ��������� ��� �������(���������� ���) ********** ');
          --  ��������� ������� ���������� ��������� ��� �������(���������� ���)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ��������� ��� �������(���������� ���)',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabname=CC_VP_DOSR&mode=RO&force=1',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� ���������� ��������� ��� �������/���������� ���
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '���������� ��������� ��� �������/���������� ���',
                                                              p_funcname => '/barsroot/credit/repayment_dostr.aspx?ccid=\S*',
                                                              p_rolename => 'START1' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� "������������� �������"(web) ********** ');
          --  ��������� ������� "������������� �������"(web)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '"������������� �������"(web)',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabname=V1_BRO&mode=RO&force=1',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �����i��i ������i� � �� ********** ');
          --  ��������� ������� �����i��i ������i� � ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�����i��i ������i� � ��',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabname=V_CP_RETEIL&mode=RO&force=1',
                                                  p_rolename => 'PYOD001' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� <<������ ������������� ����� ��� ���.������>> ********** ');
          --  ��������� ������� <<������ ������������� ����� ��� ���.������>>
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<<������ ������������� ����� ��� ���.������>>',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabname=V_METALS_KP_IM&mode=RO&force=1',
                                                  p_rolename => 'PYOD001' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� <<������ ��� �������>> ********** ');
          --  ��������� ������� <<������ ��� �������>>
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<<������ ��� �������>>',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabname=V_MON3&mode=ro&force=1',
                                                  p_rolename => 'PYOD001' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� <<������,������� ��� �� ����. ��� ��������.������>> ********** ');
          --  ��������� ������� <<������,������� ��� �� ����. ��� ��������.������>>
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '<<������,������� ��� �� ����. ��� ��������.������>>',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabname=V_MON4&mode=ro&force=1',
                                                  p_rolename => 'PYOD001' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ���� ������ �� ��������� ********** ');
          --  ��������� ������� ���������� ���� ������ �� ���������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ���� ������ �� ���������',
                                                  p_funcname => '/barsroot/barsweb/references/refbook.aspx?tabname=V_RET_POX&mode=RW&force=1',
                                                  p_rolename => 'PYOD001' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³������� "����" �������� ********** ');
          --  ��������� ������� ³������� "����" ��������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³������� "����" ��������',
                                                  p_funcname => '/barsroot/checkinner/default.aspx?type=0',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� ³������� "����" ��������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '³������� "����" ��������',
                                                              p_funcname => '/barsroot/checkinner/documents.aspx?type=0&grpid=\w+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ����� ������� BarsWeb.CheckInner
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '����� ������� BarsWeb.CheckInner',
                                                              p_funcname => '/barsroot/checkinner/service.asmx',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ³������� �������� �������� ********** ');
          --  ��������� ������� ³������� �������� ��������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '³������� �������� ��������',
                                                  p_funcname => '/barsroot/checkinner/default.aspx?type=2',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� ����� ������� BarsWeb.CheckInner
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '����� ������� BarsWeb.CheckInner',
                                                              p_funcname => '/barsroot/checkinner/service.asmx',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ³������� �������� ��������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '³������� �������� ��������',
                                                              p_funcname => '/barsroot/checkinner/documents.aspx?type=2&grpid=\w+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���� ��������� �� �������� �������� ********** ');
          --  ��������� ������� ���� ��������� �� �������� ��������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���� ��������� �� �������� ��������',
                                                  p_funcname => '/barsroot/corp2/export_docs.aspx',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������� ������� ������� � �.�. 2620 ********** ');
          --  ��������� ������� ��������� ������� ������� � �.�. 2620
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������� ������� ������� � �.�. 2620',
                                                  p_funcname => '/barsroot/credit/repayment.aspx',
                                                  p_rolename => 'WR_CREDIT' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� �������� ������ ���������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '�������� ������ ���������',
                                                              p_funcname => '/barsroot/documentview/default.aspx?ref=\S+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ³��� ����� ���������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '³��� ����� ���������',
                                                              p_funcname => '/barsroot/docinput/docinput.aspx\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ������� �� �������(�� ������ ��������) ********** ');
          --  ��������� ������� �������� ������� �� �������(�� ������ ��������)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ������� �� �������(�� ������ ��������)',
                                                  p_funcname => '/barsroot/customerlist/custacc.aspx?type=1',
                                                  p_rolename => 'WR_USER_ACCOUNTS_LIST' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� ����� ������� CustomerList
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '����� ������� CustomerList',
                                                              p_funcname => '/barsroot/customerlist/custservice.asmx',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��� ��������� �������/�����������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������ ��� ��������� �������/�����������',
                                                              p_funcname => '/barsroot/customerlist/custhistory.aspx?mode=\d{1}&rnk=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������ �������',
                                                              p_funcname => '/barsroot/customerlist/showhistory.aspx?acc=\d+&type=\d{1}',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��� ��������� �������\�����������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������ ��� ��������� �������\�����������',
                                                              p_funcname => '/barsroot/customerlist/custhistory.aspx?mode=\d{1}&rnk=\d+&type=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �������� �������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '�������� �������� �������',
                                                              p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=0',
                                                              p_rolename => 'WR_VIEWACC' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ������� �������� ********** ');
          --  ��������� ������� �������� ������� ��������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ������� ��������',
                                                  p_funcname => '/barsroot/customerlist/custacc.aspx?type=2',
                                                  p_rolename => 'WR_TOBO_ACCOUNTS_LIST' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� ����� ������� CustomerList
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '����� ������� CustomerList',
                                                              p_funcname => '/barsroot/customerlist/custservice.asmx',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��� ��������� �������/�����������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������ ��� ��������� �������/�����������',
                                                              p_funcname => '/barsroot/customerlist/custhistory.aspx?mode=\d{1}&rnk=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������� �� �������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������� �� �������',
                                                              p_funcname => '/barsroot/customerlist/turn4day.aspx',
                                                              p_rolename => 'START1' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ �������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������ �������',
                                                              p_funcname => '/barsroot/customerlist/showhistory.aspx?acc=\d+&type=\d{1}',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ϳ������ �� �������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'ϳ������ �� �������',
                                                              p_funcname => '/barsroot/customerlist/total_currency.aspx',
                                                              p_rolename => 'START1' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��� ��������� �������\�����������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������ ��� ��������� �������\�����������',
                                                              p_funcname => '/barsroot/customerlist/custhistory.aspx?mode=\d{1}&rnk=\d+&type=\d+',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� �������� �������� �������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '�������� �������� �������',
                                                              p_funcname => '/barsroot/viewaccounts/accountform.aspx?type=\d+&acc=\d+&rnk=\d*&accessmode=0',
                                                              p_rolename => 'WR_VIEWACC' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� � ���������� ********** ');
          --  ��������� ������� �������� � ����������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� � ����������',
                                                  p_funcname => '/barsroot/docinput/depository.aspx',
                                                  p_rolename => 'WR_DOC_INPUT' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� �� ������.���.(����) ********** ');
          --  ��������� ������� ����������� �� ������.���.(����)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� �� ������.���.(����)',
                                                  p_funcname => '/barsroot/docinput/doc_alt.aspx',
                                                  p_rolename => 'PYOD001' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ���. �������� �� ������� (WEB) ********** ');
          --  ��������� ������� ���������� ���. �������� �� ������� (WEB)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ���. �������� �� ������� (WEB)',
                                                  p_funcname => '/barsroot/docinput/editprops.aspx?mode=2',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ��������� ********** ');
          --  ��������� ������� �������� ���������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ���������',
                                                  p_funcname => '/barsroot/docinput/ttsinput.aspx',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� ³��� ����� ���������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '³��� ����� ���������',
                                                              p_funcname => '/barsroot/docinput/docinput.aspx\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������� ���������� ������������ ********** ');
          --  ��������� ������� �������� ���������� ������������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������� ���������� ������������',
                                                  p_funcname => '/barsroot/documentsview/default.aspx?type=1',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� ������ ��������� ��������� �����������  �� �����
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������ ��������� ��������� �����������  �� �����',
                                                              p_funcname => '/barsroot/documentsview/documents.aspx?type=1&par=22&dateb=\d{2}\.\d{2}\.\d{4}&datef=\d{2}\.\d{2}\.\d{4}',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��� ��������� ����������� �� ����
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������ ��� ��������� ����������� �� ����',
                                                              p_funcname => '/barsroot/documentsview/documents.aspx?type=1&par=21&date=\d{2}\.\d{2}\.\d{4}',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��������� ��������� ����������� �� �������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������ ��������� ��������� ����������� �� �������',
                                                              p_funcname => '/barsroot/documentsview/documents.aspx?type=1&par=12',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��������� ��������� ����������� �� ����
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������ ��������� ��������� ����������� �� ����',
                                                              p_funcname => '/barsroot/documentsview/documents.aspx?type=1&par=22&date=\d{2}\.\d{2}\.\d{4}',
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

      --  ��������� ������� ������� ������ ��� ��������� ����������� �� �������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������ ��� ��������� ����������� �� �������',
                                                              p_funcname => '/barsroot/documentsview/documents.aspx?type=1&par=11',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ������ ��� ��������� �����������  �� �����
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '������ ��� ��������� �����������  �� �����',
                                                              p_funcname => '/barsroot/documentsview/documents.aspx?type=1&par=21&dateb=\d{2}\.\d{2}\.\d{4}&datef=\d{2}\.\d{2}\.\d{4}',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. ³��� ��������� [�Ѳ ���������] ********** ');
          --  ��������� ������� ��. ³��� ��������� [�Ѳ ���������]
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. ³��� ��������� [�Ѳ ���������]',
                                                  p_funcname => '/barsroot/finmon/doc.aspx',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� ��. Գ���� ��������� �� ��������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '��. Գ���� ��������� �� ��������',
                                                              p_funcname => '/barsroot/finmon/docstatusfilter.aspx?rnd=\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ��. ������� ���������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '��. ������� ���������',
                                                              p_funcname => '/barsroot/finmon/ref_terorist.aspx?otm=\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ��. �������� � ���� ���������(������)
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '��. �������� � ���� ���������(������)',
                                                              p_funcname => '/barsroot/finmon/docfilter.aspx?rnd=\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ��. ���������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '��. ���������',
                                                              p_funcname => '/barsroot/finmon/docparams.aspx?ref=\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ��. ������� �������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '��. ������� �������',
                                                              p_funcname => '/barsroot/finmon/docstatus.aspx?ref=\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. ³��� ��������� [��ί ���������] ********** ');
          --  ��������� ������� ��. ³��� ��������� [��ί ���������]
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. ³��� ��������� [��ί ���������]',
                                                  p_funcname => '/barsroot/finmon/doc.aspx?filter=user',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���. ����������� ������ ********** ');
          --  ��������� ������� ���. ����������� ������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���. ����������� ������',
                                                  p_funcname => '/barsroot/qdocs/default.aspx',
                                                  p_rolename => 'WR_QDOCS' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� ĳ���� ������� "���. ����������� ������"
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'ĳ���� ������� "���. ����������� ������"',
                                                              p_funcname => '/barsroot/qdocs/qdialog.aspx\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� ³��� ����� ��������� c ���������� qdoc
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => '³��� ����� ��������� c ���������� qdoc',
                                                              p_funcname => '/barsroot/docinput/docinput.aspx?qdoc=\S*',
                                                              p_rolename => '' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

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
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I����� 4: ����� ������ֲ� ********** ');
          --  ��������� ������� I����� 4: ����� ������ֲ�
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I����� 4: ����� ������ֲ�',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=ik',
                                                  p_rolename => 'WR_XMLIMP' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� I����� : ����i� ��������i�
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'I����� : ����i� ��������i�',
                                                              p_funcname => '/barsroot/sberutls/importproc.aspx?tp=1',
                                                              p_rolename => 'WR_XMLIMP' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I����� 2: ���������I ������I ********** ');
          --  ��������� ������� I����� 2: ���������I ������I
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I����� 2: ���������I ������I',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=kp',
                                                  p_rolename => 'WR_XMLIMP' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� I����� : ����i� ��������i�
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'I����� : ����i� ��������i�',
                                                              p_funcname => '/barsroot/sberutls/importproc.aspx?tp=1',
                                                              p_rolename => 'WR_XMLIMP' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I����� 1: �������I �����I (��������) ********** ');
          --  ��������� ������� I����� 1: �������I �����I (��������)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I����� 1: �������I �����I (��������)',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=lz',
                                                  p_rolename => 'WR_XMLIMP' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� I����� : ����i� ��������i�
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'I����� : ����i� ��������i�',
                                                              p_funcname => '/barsroot/sberutls/importproc.aspx?tp=1',
                                                              p_rolename => 'WR_XMLIMP' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I����� 3.3: I��i ���������� (tt=PKR,sk=88) ********** ');
          --  ��������� ������� I����� 3.3: I��i ���������� (tt=PKR,sk=88)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I����� 3.3: I��i ���������� (tt=PKR,sk=88)',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=zp&config=imp_3_3',
                                                  p_rolename => 'WR_XMLIMP' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ 4.2: ������ ����� ���������� ********** ');
          --  ��������� ������� ������ 4.2: ������ ����� ����������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ 4.2: ������ ����� ����������',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=zp&config=imp_4_2',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I����� : ����i� ��������i� ********** ');
          --  ��������� ������� I����� : ����i� ��������i�
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I����� : ����i� ��������i�',
                                                  p_funcname => '/barsroot/sberutls/importproc.aspx?tp=1',
                                                  p_rolename => 'WR_XMLIMP' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

      --  ��������� ������� ������� I����� : ����������� i������������ ���������
                     l_function_deps  :=   abs_utils.add_func(
                                                              p_name     => 'I����� : ����������� i������������ ���������',
                                                              p_funcname => '/barsroot/sberutls/importproced.aspx',
                                                              p_rolename => 'WR_XMLIMP' ,    
                                                              p_frontend => l_application_type_id
                                                              );
                     abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ "��������"-XML ********** ');
          --  ��������� ������� ������ "��������"-XML
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ "��������"-XML',
                                                  p_funcname => '/barsroot/sberutls/importsalary.aspx',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ������ ����� DBF-����(BARS) ����������� ********** ');
          --  ��������� ������� ������ "��������"-XML
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ ����� DBF-����(BARS) �����������',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=ukrrail',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );

     

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_WDOC) - ��� ������������ (�����)  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_WDOC.sql =========**
PROMPT ===================================================================================== 
