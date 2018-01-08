SET SERVEROUTPUT ON 
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_KREA.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_KREA ***
  declare
    l_application_code varchar2(10 char) := '$RM_KREA';
    l_application_name varchar2(300 char) := '��� ��������������� ������i� ��';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_KREA ��������� (��� ���������) ��� ��� ��������������� ������i� �� ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code, 
                             P_ARM_NAME              => l_application_name, 
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� �������  ����� � ���, �� ���`���� � Գ�.��� ********** ');
          --  ��������� �������  ����� � ���, �� ���`���� � Գ�.���
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => ' ����� � ���, �� ���`���� � Գ�.���',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0&sPar=FIN_DEBM',
                                                  p_rolename => 'START1' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Start/ ����-��������� ������� ����� SS - �� ********** ');
          --  ��������� ������� Start/ ����-��������� ������� ����� SS - ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Start/ ����-��������� ������� ����� SS - ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=> CCK.CC_ASP ( -1,1)][QST=>�������� Start/ ����-��������� ������� ����� SS - ��?][MSG=>��������!]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� F0: ��������� ������� ��������� SG ********** ');
          --  ��������� ������� �� F0: ��������� ������� ��������� SG
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� F0: ��������� ������� ��������� SG',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CCK.CC_ASG (0)][QST=>�������� "�� F0: ��������� ������� ��������� SG"?][MSG=>�������� !]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������-�� �� �����. %% ����� ��� � ���� ����� �� ********** ');
          --  ��������� ������� �������-�� �� �����. %% ����� ��� � ���� ����� ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������-�� �� �����. %% ����� ��� � ���� ����� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CCK_SBER(''2'',''4'',:Param0)][PAR=>:Param0(SEM=�����,TYPE=C,REF=BRANCH)][QST=>������� ������� % ����� ��� � ���� ����� �� ?][MSG=>����������� �������� !]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� #2) �� S38: ������-�� �� �����. ���. ����� ��� � ���� �����. �� ********** ');
          --  ��������� ������� #2) �� S38: ������-�� �� �����. ���. ����� ��� � ���� �����. ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '#2) �� S38: ������-�� �� �����. ���. ����� ��� � ���� �����. ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CCK_SBER(''3'',''4'',:Param0)][PAR=>:Param0(SEM=�����,TYPE=C,REF=BRANCH)][QST=>������� ������� % ����� ��� � ���� ����� �� ?][MSG=>����������� �������� !]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� F05: ���� ����� ������� ISG (3600) ����-� ������-� �� (SPN,SN) ********** ');
          --  ��������� ������� �� F05: ���� ����� ������� ISG (3600) ����-� ������-� �� (SPN,SN)
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� F05: ���� ����� ������� ISG (3600) ����-� ������-� �� (SPN,SN)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CC_ISG(0,''SPN|SN '')][QST=>�� ������ ������� ���� ����� ������� ����-� ������-�?][MSG=>�������� !]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ��������/���쳿 �� ********** ');
          --  ��������� ������� ����������� ��������/���쳿 ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ��������/���쳿 ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CC_RMANY(-11,bankdate,3)][QST=>�������� ����������� �������� ��?][MSG=>������!]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ��������/���쳿 ********** ');
          --  ��������� ������� ����������� ��������/���쳿
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ��������/���쳿',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CC_RMANY(0,bankdate,3)][QST=>�������� ����������� ��������?][MSG=>������!]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S7: ����������� ��������/���쳿 �� ********** ');
          --  ��������� ������� �� S7: ����������� ��������/���쳿 ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S7: ����������� ��������/���쳿 ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CC_RMANY_PET(-1,gl.bd,3)][QST=>�� ������ ���. ���������� �������� ��?][MSG=> �������� !]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S7: ����������� ����/���� ********** ');
          --  ��������� ������� �� S7: ����������� ����/����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S7: ����������� ����/����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CC_RMANY_PET(0,gl.bd,3)][QST=>�� ������ ���. ���������� ��������?][MSG=> ��������!]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S69: ������� �� ������������� ��������� ��� ********** ');
          --  ��������� ������� �� S69: ������� �� ������������� ��������� ���
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S69: ������� �� ������������� ��������� ���',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>PENY_PAY(gl.bd,0)][QST=>������� ��������� ���?][MSG=>��������� ���������!]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� CCK: ���������� ������������� ������������ S080 ��� �� ********** ');
          --  ��������� ������� CCK: ���������� ������������� ������������ S080 ��� ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'CCK: ���������� ������������� ������������ S080 ��� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>P_SET_S080(2,:Param0)][PAR=>:Param0(SEM=����� ��� �������� � ���. ���� ��������  *,TYPE=C)][QST=> ���������� ������������� �������� S080 ��� �� ?][MSG=>������������ �������� !]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� CCK: ���������� ������������� ������������ S080 ��� �� ********** ');
          --  ��������� ������� CCK: ���������� ������������� ������������ S080 ��� ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'CCK: ���������� ������������� ������������ S080 ��� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>P_SET_S080(3,:Param0)][PAR=>:Param0(SEM=����� ��� �������� � ���. ���� ��������  *,TYPE=C)][QST=> ���������� ������������� �������� S080 ��� �� ?][MSG=>������������ �������� !]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� S8: ���� �������� �������� �� ********** ');
          --  ��������� ������� �� S8: ���� �������� �������� ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� S8: ���� �������� �������� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>cc_close(3,bankdate)][QST=>�� ������ �������� ����-�������� �������� ��?][MSG=>�������� �������� !]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ������� �� 9129 �� �� �� ********** ');
          --  ��������� ������� ����������� ������� �� 9129 �� �� ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ������� �� 9129 �� �� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>cck.CC_9129(bankdate,0,2) ][QST=>�������� "����������� ������� �� 9129 �� �� ��"?][MSG=>�������� !]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� ������� �� 9129 �� �� �� ********** ');
          --  ��������� ������� ����������� ������� �� 9129 �� �� ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� ������� �� 9129 �� �� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>cck.CC_9129(bankdate,0,3)][QST=>�������� "����������� ������� �� 9129 �� �� ��?][MSG=>�������� !]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� F3: �����-�� �� ������. ��� ����� � ������� ����� �����. �� �� ********** ');
          --  ��������� ������� �� F3: �����-�� �� ������. ��� ����� � ������� ����� �����. �� ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� F3: �����-�� �� ������. ��� ����� � ������� ����� �����. �� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>cck.cc_wdate(3,gl.bd,0)][QST=>�� ������ ������� �� ���������� �� ������ �볺���?][MSG=>�������� !]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� F6: ���������� ���������� ��� �� ����� ���� ********** ');
          --  ��������� ������� �� F6: ���������� ���������� ��� �� ����� ����
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� F6: ���������� ���������� ��� �� ����� ����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>cck_arc_cc_lim(gl.bd, -1)][QST=>�� ������ �������� ���������� ���������� ���?][MSG=>�������� !]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����������� %% ������� �� ********** ');
          --  ��������� ������� ����������� %% ������� ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������� %% ������� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&tableName=INT_GL&sPar=[PROC=>PUL_DAT(to_char(:P,''dd/mm/yyyy''),null)][PAR=>:P(SEM=����,TYPE=D)][EXEC=>BEFORE][NSIFUNCTION][CONDITIONS=>NBS like ''20%'' AND ID = 0]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �������: "Բ������� ���������" � �� ********** ');
          --  ��������� ������� �������: "Բ������� ���������" � ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�������: "Բ������� ���������" � ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=FIN_DEBT&accessCode=0',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� �� �� �� ������ ********** ');
          --  ��������� ������� ������� �� �� �� ������
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� �� �� �� ������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=PRVN_FLOW_DEALS&accessCode=2&sPar=[NSIFUNCTION][PROC=>PUL_DAT(:A,null)][PAR=>:A(SEM=��i��� ���� dd_mm_yyyy)][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���� �� ������������ �������� �� �� ********** ');
          --  ��������� ������� ���� �� ������������ �������� �� ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���� �� ������������ �������� �� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CCK_REP&accessCode=1&sPar=[PROC=>CCK.CC_REPORTS(:Param0)][PAR=>:Param0(SEM=���� �������,TYPE=N,REF=V_CCK_REP_LIST_YL)][NSIFUNCTION][EXEC=>BEFORE][MSG=>��������!]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��: ����������� ���i����� ���i�i� �� �� ********** ');
          --  ��������� ������� ��: ����������� ���i����� ���i�i� �� ��
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��: ����������� ���i����� ���i�i� �� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_INTEREST_CCK&accessCode=1&sPar=[PROC=>p_interest_cck(null,5,:E)][PAR=>:E(SEM=���� ��,TYPE=D)][showDialogWindow=>false][DESCR=>��: �����.%%][EXEC=>BEFORE][NSIFUNCTION]',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_KREA) - ��� ��������������� ������i� ��  ');
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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_KREA.sql =========**
PROMPT ===================================================================================== 
