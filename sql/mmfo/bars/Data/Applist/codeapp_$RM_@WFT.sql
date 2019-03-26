PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_@WFT.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_@WFT ***
  declare
    l_application_code varchar2(10 char) := '$RM_@WFT';
    l_application_name varchar2(300 char) := '��� SWIFT. ��������� � �������� ��������';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_@WFT ��������� (��� ���������) ��� ��� SWIFT. ��������� � �������� �������� ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code,
                             P_ARM_NAME              => l_application_name,
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- �������� ������������� ���������� ����
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SWIFT. ���������� ������� �� ������� ���. ********** ');
          --  ��������� ������� SWIFT. ���������� ������� �� ������� ���.
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. ���������� ������� �� ������� ���.',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>BARS_SWIFT.SheduleStatementMessages][QST=>�������� ���������� �������?][MSG=>��������!]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �-2) ����-�����������i� ��I��-���i������� �� /262* ********** ');
          --  ��������� ������� �-2) ����-�����������i� ��I��-���i������� �� /262*
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�-2) ����-�����������i� ��I��-���i������� �� /262*',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>LORO.SWIFT_RU(0,:N,:P)][PAR=>:P(SEM=����_50K,REF=TEST_50K),:N(SEM=SWREF_���_�����,TYPE=N)][QST=>�������� �����������i� SWT-103 �� /262* ?][MSG=>��!]',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SWIFT. ����� �������� ********** ');
          --  ��������� ������� SWIFT. ����� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. ����� ��������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=SW_BANKS&accessCode=1',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SWIFT. ���������� ����� ********** ');
          --  ��������� ������� SWIFT. ���������� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. ���������� �����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CORR_ACC&accessCode=0',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SWIFT. ����������� ����������� ��� �������������� ********** ');
          --  ��������� ������� SWIFT. ����������� ����������� ��� ��������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. ����������� ����������� ��� ��������������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_SW_AUTH_MESSAGES&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=>DATE_IN>=sysdate-30]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SWIFT. ������� ����� ������ ������� ********** ');
          --  ��������� ������� SWIFT. ������� ����� ������ �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. ������� ����� ������ �������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_SW_FORECAST_NOSTRO&accessCode=1',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SWIFT. ���� ������ �� 191992, 3720, 1600, 2906 ********** ');
          --  ��������� ������� SWIFT. ���� ������ �� 191992, 3720, 1600, 2906
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. ���� ������ �� 191992, 3720, 1600, 2906',
                                                  p_funcname => '/barsroot/sep/seplockdocs/index?swt=swt',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SWIFT. ����� ���������� ********** ');
          --  ��������� ������� SWIFT. ����� ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. ����� ����������',
                                                  p_funcname => '/barsroot/swi/archive.aspx',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� SWIFT. ����� ����������(�������)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'SWIFT. ����� ����������(�������)',
															  p_funcname => '/barsroot/swi/pickup_doc.aspx?swref=/d+',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SWIFT. ������ �������� BIC(XML) ********** ');
          --  ��������� ������� SWIFT. ������ �������� BIC(XML)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. ������ �������� BIC(XML)',
                                                  p_funcname => '/barsroot/swi/import_bic.aspx',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� Nostro Reconciliation ********** ');
          --  ��������� ������� Nostro Reconciliation
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Nostro Reconciliation',
                                                  p_funcname => '/barsroot/swi/reconsilation.aspx',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� �������� SWIFT
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '�������� SWIFT',
															  p_funcname => '/barsroot/documentview/view_swift.aspx?swref=\d+',
															  p_rolename => 'BARS_ACCESS_DEFROLE' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� Nostro Reconciliation
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Nostro Reconciliation',
															  p_funcname => '/barsroot/swi/reconsilation_tt.aspx?stmt_ref=\d+&coln=\d+',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

      --  ��������� ������� ������� Nostro Reconciliation
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Nostro Reconciliation',
															  p_funcname => '/barsroot/swi/reconsilation_link_swt.aspx?stmt_ref=\d+&coln=\d+',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SWIFT. �������� ����������� �� ������������ SWIFT ���������� ********** ');
          --  ��������� ������� SWIFT. �������� ����������� �� ������������ SWIFT ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. �������� ����������� �� ������������ SWIFT ����������',
                                                  p_funcname => '/barsroot/swi/undistributed.aspx',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ����������� SWIFT
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '����������� SWIFT',
															  p_funcname => '/barsroot/swi/swi_users.aspx?fromUser=/d+',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SWIFT.��������� ����"���� ��������� ********** ');
          --  ��������� ������� SWIFT.��������� ����"���� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT.��������� ����"���� ���������',
                                                  p_funcname => '/barsroot/swi/unlink_document.aspx',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SWIFT. ³������� ���������� ********** ');
          --  ��������� ������� SWIFT. ³������� ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. ³������� ����������',
                                                  p_funcname => '/barsroot/swift/Approval',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ********** ');
          --  ��������� ������� ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����������',
                                                  p_funcname => '/barsroot/swift/positioner',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� ���������� child
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => '���������� child',
															  p_funcname => '/barsroot/swi/positioner_mt.aspx?acc=\d+&ref=\d+',
															  p_rolename => 'START1' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SWIFT. ����� ���������� ********** ');
          --  ��������� ������� SWIFT. ����� ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. ����� ����������',
                                                  p_funcname => '/barsroot/swift/search',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SWIFT. ������� ��������� ���������� (���) ********** ');
          --  ��������� ������� SWIFT. ������� ��������� ���������� (���)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. ������� ��������� ���������� (���)',
                                                  p_funcname => '/barsroot/swift/swift',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


      --  ��������� ������� ������� Way4. ������������ ��������� (web)
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'Way4. ������������ ��������� (web)',
															  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_OW_PKKQUE_1&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=>pkk_sos= 1]',
															  p_rolename => '' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SWIFT. CLAIMS. ������� ��������� ���������� ********** ');
          --  ��������� ������� SWIFT. CLAIMS. ������� ��������� ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. CLAIMS. ������� ��������� ����������',
                                                  p_funcname => '/barsroot/swift/swift?isClaims=true',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SWIFT. ���� �������/������� ��������� ���������� ********** ');
          --  ��������� ������� SWIFT. ���� �������/������� ��������� ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. ���� �������/������� ��������� ����������',
                                                  p_funcname => '/barsroot/swift/swift?sUserF=0',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SWIFT. ������� ��������� ���������� ********** ');
          --  ��������� ������� SWIFT. ������� ��������� ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. ������� ��������� ����������',
                                                  p_funcname => '/barsroot/swift/swift?strPar02=',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SWIFT. �������/������� ��������� ���������� ********** ');
          --  ��������� ������� SWIFT. �������/������� ��������� ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. �������/������� ��������� ����������',
                                                  p_funcname => '/barsroot/swift/swift?strPar02=&sUserF=0',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SWIFT. ������� ��������� ����������(�� ���������) ********** ');
          --  ��������� ������� SWIFT. ������� ��������� ����������(�� ���������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. ������� ��������� ����������(�� ���������)',
                                                  p_funcname => '/barsroot/swift/swift?strPar02=&sUserF=0&sFILTR=noturgently',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SWIFT. ������� ��������� ����������(���������) ********** ');
          --  ��������� ������� SWIFT. ������� ��������� ����������(���������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. ������� ��������� ����������(���������)',
                                                  p_funcname => '/barsroot/swift/swift?strPar02=&sUserF=0&sFILTR=urgently',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SWIFT. ��������� ����������� ����������(300,320) ********** ');
          --  ��������� ������� SWIFT. ��������� ����������� ����������(300,320)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. ��������� ����������� ����������(300,320)',
                                                  p_funcname => '/barsroot/swift/unlockmsg?mt=3_0',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SWIFT. ��������� ����������� ����������(950) ********** ');
          --  ��������� ������� SWIFT. ��������� ����������� ����������(950)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. ��������� ����������� ����������(950)',
                                                  p_funcname => '/barsroot/swift/unlockmsg?mt=950',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� SWIFT. ��������� ����������� ���������� ********** ');
          --  ��������� ������� SWIFT. ��������� ����������� ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'SWIFT. ��������� ����������� ����������',
                                                  p_funcname => '/barsroot/swift/unlockmsg?mt=all',
                                                  p_rolename => 'START1' ,
                                                  p_frontend => l_application_type_id
                                                  );


   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_@WFT) - ��� SWIFT. ��������� � �������� ��������  ');
    l := l_function_ids.first;
    while (l is not null and l_function_ids(l)  is not null) loop
        resource_utl.set_resource_access_mode(l_arm_resource_type_id, l_application_id, l_func_resource_type_id, l_function_ids(l), 1);
        l := l_function_ids.next(l);
    end loop;


    DBMS_OUTPUT.PUT_LINE(' B����� ������� ������� ���������� ������������ - ����������� ����������� �� ');
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
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_@WFT.sql =========**
PROMPT ===================================================================================== 