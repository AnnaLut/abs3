SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET DEFINE OFF 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_W_CP.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_W_CP ***
  declare
    l_application_code varchar2(10 char) := '$RM_W_CP';
    l_application_name varchar2(300 char) := '��� ֳ�� ������';
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
     DBMS_OUTPUT.PUT_LINE(' $RM_W_CP ��������� (��� ���������) ��� ��� ֳ�� ������ ');
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����: �������� ���� ********** ');
          --  ��������� ������� ����: �������� ����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����: �������� ����',
                                                  p_funcname => '/barsroot/Mbdk/Deal/Index',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� �� ********** ');
          --  ��������� ������� ���������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ��',
                                                  p_funcname => '/barsroot/dcp/depositary/acceptpfiles?nPar=3',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );
      /*�� ������� ��� ����� ����, ��� ������ ����� ���� �� ���� � OPERLIST.runable is null
        ���� �� �������������  abs_utils.add_func
      */
     update OPERLIST set runable = 1 where  codeoper = l_function_ids(l) and runable is null;
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. ��������� ������ > 30 ��� (WEB)  ********** ');
          --  ��������� ������� ��. ��������� ������ > 30 ��� (WEB) 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. ��������� ������ > 30 ��� (WEB) ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=TMP_CP_PRGN[PROC=>CP_KUP_PROGNOZ(:Param2,:RNK,:REG)][PAR=>:Param2(SEM=���� ��,TYPE=D),:RNK(SEM=��� ��-��,TYPE=N),:REG(SEM=�����,TYPE=N))][CONDITIONS=>u_id=user_id][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��: �������� ������� �������� ������ ********** ');
          --  ��������� ������� ��: �������� ������� �������� ������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��: �������� ������� �������� ������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_DAT',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. �i�i�. ����-���������� ��������� ���i��� (WEB)  ********** ');
          --  ��������� ������� ��. �i�i�. ����-���������� ��������� ���i��� (WEB) 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. �i�i�. ����-���������� ��������� ���i��� (WEB) ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_DOK_DNK[PROC=>CP.DOK_DNK(bankdate)][EXEC=>BEFORE][QST=>�������� ?][MSG=>������!]',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. �i�i�. ����-���������� ��������� ���i��� (WEB)  ********** ');
          --  ��������� ������� ��. �i�i�. ����-���������� ��������� ���i��� (WEB) 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. �i�i�. ����-���������� ��������� ���i��� (WEB) ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_DOK_DNK[PROC=>CP.DOK_DNK(bankdate)][EXEC=>BEFORE][QST=>��������?][MSG=>������!]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��: �������������� ����� KALENDAR Y/H/Q/M/D  WEB ********** ');
          --  ��������� ������� ��: �������������� ����� KALENDAR Y/H/Q/M/D  WEB
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��: �������������� ����� KALENDAR Y/H/Q/M/D  WEB',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_KALENDAR[PROC=>CP_KALENDAR(0,:B,:E,:Z,:F,:P)][PAR=>:B(SEM=���� � <dd.mm.yyyy>,TYPE=D),:E(SEM=���� �� <dd.mm.yyyy>,TYPE=D),:Z(SEM=������������� ���/� =1/0,TYPE=N),:F(SEM=����� �������/������� KLB/KLS,TYPE=C),:P(SEM=�����=Y/H/Q/M/D,TYPE=C)][EXEC=>BEFORE][QST=>�������� ��: �������������� ����� KALENDAR ?][MSG=>�������� !]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��: �������� ����� KALENDAR (���������) Գ���� Y/H/Q/M/D  WEB ********** ');
          --  ��������� ������� ��: �������� ����� KALENDAR (���������) Գ���� Y/H/Q/M/D  WEB
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��: �������� ����� KALENDAR (���������) Գ���� Y/H/Q/M/D  WEB',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_KALENDAR_BUY][CONDITIONS=> frm=''KLB'']',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��: �������� ����� KALENDAR (������/���������) Գ���� Y/H/Q/M/D  WEB ********** ');
          --  ��������� ������� ��: �������� ����� KALENDAR (������/���������) Գ���� Y/H/Q/M/D  WEB
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��: �������� ����� KALENDAR (������/���������) Գ���� Y/H/Q/M/D  WEB',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_KALENDAR_SALE][CONDITIONS=> frm=''KLS'']',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ����� ���� �������� ********** ');
          --  ��������� ������� ����� ���� ��������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '����� ���� ��������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_PRICES',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��: (OLD)���������� ����� DGP_F007 �� ����� (Y/H/Q/D) ********** ');
          --  ��������� ������� ��: ���������� ����� DGP_F007 �� ����� (Y/H/Q/D)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��: (OLD)���������� ����� DGP_F007 �� ����� (Y/H/Q/D)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_ZV7K[PROC=>CP_ZV_D(0,:B,:E,:Z,''7'',:P)][PAR=>:B(SEM=���� � <dd.mm.yyyy>,TYPE=D),:E(SEM=���� �� <dd.mm.yyyy>,TYPE=D),:Z(SEM=������������� ���/� =1/0,TYPE=N),:P(SEM=�����=Y/H/Q/D,TYPE=C)][EXEC=>BEFORE][QST=>³������ ����� ��� ����� DGP_F007 ?][MSG=>�������� !]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��: ���������� ����� DGP_007 �� ����� ********** ');
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��: ���������� ����� DGP_F007 �� �����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_DGP007[PROC=>cp_rep_dgp.prepare_dgp(:B,:E, 7)][PAR=>:B(SEM=���� � <dd.mm.yyyy>,TYPE=D),:E(SEM=���� �� <dd.mm.yyyy>,TYPE=D)][EXEC=>BEFORE][QST=>³������ ����� ��� ����� DGP_F007 ("ͳ" - �������� ���� � ������������ ���������)?][MSG=>�������� !][showDialogWindow=>false][CONDITIONS=>user_id = user_id()]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��: (OLD)���������� ����� DGP_F008 �� ����� (Y/H/Q/D) ********** ');
          --  ��������� ������� ��: ���������� ����� DGP_F008 �� ����� (Y/H/Q/D)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��: (OLD)���������� ����� DGP_F008 �� ����� (Y/H/Q/D)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_ZV8K[PROC=>CP_ZV_D(0,:B,:E,:Z,''8'',:P)][PAR=>:B(SEM=���� � <dd.mm.yyyy>,TYPE=D),:E(SEM=���� �� <dd.mm.yyyy>,TYPE=D),:Z(SEM=������������� ���/� =1/0,TYPE=N),:P(SEM=�����=Y/H/Q/D,TYPE=C)][EXEC=>BEFORE][QST=>³������ ����� ��� ����� DGP_F008 ?][MSG=>�������� !]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��: ���������� ����� DGP_008 �� ����� ********** ');
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��: ���������� ����� DGP_F008 �� �����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_DGP008[PROC=>cp_rep_dgp.prepare_dgp(:B,:E, 8)][PAR=>:B(SEM=���� � <dd.mm.yyyy>,TYPE=D),:E(SEM=���� �� <dd.mm.yyyy>,TYPE=D)][EXEC=>BEFORE][NSIFUNCTION][QST=>³������ ����� ��� ����� DGP_F008 ("ͳ" - �������� ���� � ������������ ���������)?][MSG=>�������� !][showDialogWindow=>false][CONDITIONS=>user_id = user_id()]',
                                                  p_rolename => 'bars_access_defrole' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��: ���������� ����� DGP_F009 �� ����� (Y/H/Q/D) ********** ');
          --  ��������� ������� ��: ���������� ����� DGP_F009 �� ����� (Y/H/Q/D)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��: ���������� ����� DGP_F009 �� ����� (Y/H/Q/D)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_ZV9K[PROC=>CP_ZV_D(0,:B,:E,:Z,''9'',:P)][PAR=>:B(SEM=���� � <dd.mm.yyyy>,TYPE=D),:E(SEM=���� �� <dd.mm.yyyy>,TYPE=D),:Z(SEM=������������� ���/� =1/0,TYPE=N),:P(SEM=�����=Y/H/Q/D,TYPE=C)][EXEC=>BEFORE][QST=>³������ ����� ��� ����� DGP_F009 ?][MSG=>�������� !]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��: �������� ����� DGP_F007 (Q-����������) ********** ');
          --  ��������� ������� ��: �������� ����� DGP_F007 (Q-����������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��: �������� ����� DGP_F007 (Q-����������)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_ZV[CONDITIONS=>period=''Q'' and frm=''7'']',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��: �������� ����� DGP_F008 (Q-����������) ********** ');
          --  ��������� ������� ��: �������� ����� DGP_F008 (Q-����������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��: �������� ����� DGP_F008 (Q-����������)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_ZV[CONDITIONS=>period=''Q'' and frm=''8'']',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��: �������� ����� DGP_F008 (Y-����) ********** ');
          --  ��������� ������� ��: �������� ����� DGP_F008 (Y-����)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��: �������� ����� DGP_F008 (Y-����)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_ZV[CONDITIONS=>period=''Y'' and frm=''8'']',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. ����������� �������� ������ �� �� (WEB)  ********** ');
          --  ��������� ������� ��. ����������� �������� ������ �� �� (WEB) 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. ����������� �������� ������ �� �� (WEB) ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CP.RMANY_ALL(bankdate)][QST=>�������� ?][MSG=>������!]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��. ������������ ����������� ������� �� �������� (WEB)  ********** ');
          --  ��������� ������� ��. ������������ ����������� ������� �� �������� (WEB) 
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��. ������������ ����������� ������� �� �������� (WEB) ',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CP_CLOSE(1,bankdate)][QST=>�������� ?][MSG=>������!]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��: ������������ ����.��������� �� �������� � �������� �� ********** ');
          --  ��������� ������� ��: ������������ ����.��������� �� �������� � �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��: ������������ ����.��������� �� �������� � �������� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=>CP_SPEC(bankdate,5)][QST=>�������� ?][MSG=>������!]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��: ����.��������� ������� �� �� (����� ������������) ********** ');
          --  ��������� ������� ��: ����.��������� ������� �� �� (����� ������������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��: ����.��������� ������� �� �� (����� ������������)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=SPECPARAM_CP_V',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��: ����� ��� ��������� ����������� ������������� ********** ');
          --  ��������� ������� ��: ����� ��� ��������� ����������� �������������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��: ����� ��� ��������� ����������� �������������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=V_CPDEAL_EXPPAY',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��: ��������/����������� ���-� �������� ���� (V_CP_REFW) ********** ');
          --  ��������� ������� ��: ��������/����������� ���-� �������� ���� (V_CP_REFW)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��: ��������/����������� ���-� �������� ���� (V_CP_REFW)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=V_CP_REFW',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��: ��������� ����� �������� �� ����� ********** ');
          --  ��������� ������� ��: ��������� ����� �������� �� �����
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��: ��������� ����� �������� �� �����',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&tableName=CP_HIERARCHY_IDS&sPar=[PROC=>p_cp_levels_ids(:dat1,:dat2)][PAR=>:dat1(SEM=� >,TYPE=D),:dat2(SEM=��>,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��: ��������� ����� �������� �� ����� (��������� ��������) ********** ');
          --  ��������� ������� ��: ��������� ����� �������� �� ����� (��������� ��������)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��: ��������� ����� �������� �� ����� (��������� ��������)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&tableName=CP_HIERARCHY_IDSREFS',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��: ������������� ��� �� ���������� ********** ');
          --  ��������� ������� ��: ������������� ��� �� ����������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��: ������������� ��� �� ����������',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&tableName=CP_HIERARCHY_LEVELS&sPar=[PROC=>p_cp_levels(:dat1,:dat2)][PAR=>:dat1(SEM=� >,TYPE=D),:dat2(SEM=��>,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��: �������������� ���� DGP_F... (V_CP_ZV) Y/H/Q/M/D ********** ');
          --  ��������� ������� ��: �������������� ���� DGP_F... (V_CP_ZV) Y/H/Q/M/D
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��: �������������� ���� DGP_F... (V_CP_ZV) Y/H/Q/M/D',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=5&sPar=V_CP_ZV[PROC=>CP_ZV_D(0,:B,:E,:Z,:F,:P)][PAR=>:B(SEM=���� � <dd.mm.yyyy>,TYPE=D),:E(SEM=���� �� <dd.mm.yyyy>,TYPE=D),:Z(SEM=������������� ���/� =1/0,TYPE=N),:F(SEM=�����=7/8/9,TYPE=C),:P(SEM=�����=Y/H/Q/M/D,TYPE=C)][EXEC=>BEFORE][QST=>�������� ��: �������������� ���� DGP_F... ?][MSG=>�������� !]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��: ����� ��� ����-�� ���������� (CP_PEREOC_V) ********** ');
          --  ��������� ������� ��: ����� ��� ����-�� ���������� (CP_PEREOC_V)
      --�������� ����� ����� (�� ���� p_funcname)
      delete from operlist a where  a.funcname = '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CP_PEREOC_V&accessCode=2&sPar=[PROC=>CP_PEREOC_P(0,:VOB)][PAR=>:VOB(SEM=��������������� VOB=96,TYPE=N)][DESCR=>����������][EXEC=>ONCE][QST=>�������� ������i��� ?][MSG=>��������!]';
      --����� �����������

      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��: ����� ��� ����-�� ���������� (CP_PEREOC_V)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CP_PEREOC_V&accessCode=2&sPar=[PROC=>CP_PEREOC_P(0,:VOB)][PAR=>:VOB(SEM=��������������� VOB=96,TYPE=N)][DESCR=>����������][EXEC=>ONCE][QST=>�������� ������i��� ?][MSG=>��������!][SAVE_COLUMNS=>BY_DEFAULT]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� (14*), �� ����������� � ������i ********** ');
          --  ��������� ������� �� (14*), �� ����������� � ������i
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� (14*), �� ����������� � ������i',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CP_V_ZAL_WEB&accessCode=2&sPar=[NSIFUNCTION][PROC=>PUL.PUT(''DAT_ZAL'',to_char(:Par0,''dd.mm.yyyy''))][PAR=>:Par0(SEM=���� �� <dd.mm.yyyy>,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������� ������ �� ����� �� �������� �� ********** ');
          --  ��������� ������� ������� ������ �� ����� �� �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������� ������ �� ����� �� �������� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=TMP_CP_REP_DOX&accessCode=1&sPar=[PROC=>CP_revenue_forecast(0,:B)][PAR=>:B(SEM=�������-����>,TYPE=D)][EXEC=>BEFORE]',
                                                  p_rolename => 'BARS_ACCESS_DEFROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� - ����� ���� ��� ********** ');
          --  ��������� ������� �� - ����� ���� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� - ����� ���� ���',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CP_ARCH_META&accessCode=1&sPar=[CONDITIONS=> kv != 980]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� - ����� ���� ��� ********** ');
          --  ��������� ������� �� - ����� ���� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� - ����� ���� ���',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CP_ARCH_META&accessCode=1&sPar=[CONDITIONS=> kv = 980]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� - ����� ���� ��� ********** ');
          --  ��������� ������� �� - ����� ���� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� - ����� ���� ���',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CP_ARCH_META&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=> kv != 980]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� - ����� ���� ��� ********** ');
          --  ��������� ������� �� - ����� ���� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� - ����� ���� ���',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CP_ARCH_META&accessCode=1&sPar=[NSIFUNCTION][CONDITIONS=> kv = 980]',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������i ����i���� �� �������� �� ********** ');
          --  ��������� ������� ��������i ����i���� �� �������� ��
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������i ����i���� �� �������� ��',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CP_EMI&accessCode=1',
                                                  p_rolename => 'bars_access_defrole' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ��������/���������� V_CP_UA (�� UA ����� 25) ********** ');
          --  ��������� ������� ��������/���������� V_CP_UA (�� UA ����� 25)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '��������/���������� V_CP_UA (�� UA ����� 25)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_CP_UA&accessCode=1&sPar=[PROC=>CP_F25(:Param1,:Param2,:ISIN)][PAR=>:Param1(SEM=���� ''�'',TYPE=D),:Param2(SEM=���� ''��'',TYPE=D),:ISIN(SEM=�����/��� ��,TYPE=C))][EXEC=>BEFORE][MSG=>OK!][CONDITIONS=>frm=25]',
                                                  p_rolename => 'bars_access_defrole' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� �������� ��������� ********** ');
          --  ��������� ������� �� �������� ���������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� �������� ���������',
                                                  p_funcname => '/barsroot/valuepapers/generalfolder/index/?nMode=1&nGrp=22&strPar01=1&strPar02=1&p_active=1',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� �������� ������ ��� ********** ');
          --  ��������� ������� �� �������� ������ ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� �������� ������ ���',
                                                  p_funcname => '/barsroot/valuepapers/generalfolder/index/?nMode=5&nGrp=22&strPar01=1&strPar02=1&p_active=1',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� ��������. ���� ������� ********** ');
          --  ��������� ������� �� ��������. ���� �������
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� ��������. ���� �������',
                                                  p_funcname => '/barsroot/valuepapers/generalfolder/index/?nMode=6&nGrp=22&strPar01=1&strPar02=1&p_active=1',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� �������� ��� ********** ');
          --  ��������� ������� �� �������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� �������� ���',
                                                  p_funcname => '/barsroot/valuepapers/generalfolder/index/?nMode=7&nGrp=22&strPar01=1&strPar02=1&p_active=1',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� �� �������� ��� ********** ');
          --  ��������� ������� �� �������� ���
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� �������� ���',
                                                  p_funcname => '/barsroot/valuepapers/generalfolder/index/?nMode=8&nGrp=22&strPar01=1&strPar02=1&p_active=1',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );

--    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ��������� ������� �� ����������� ��������� �� ���� ********** ');
    --
    delete from operlist a where  a.name = '�� ����������� ��������� �� ���� (���������)';
          --  ��������� ������� �� 
/*
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� ����������� ��������� �� ���� (���������)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2&sPar=V_CP_INT_DIVIDENTS[NSIFUNCTION][PROC=>value_paper.make_int_dividends_prepare(:A)][PAR=>:A(SEM=REF �����,TYPE=N)][EXEC=>BEFORE][showDialogWindow=>false]',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );
*/
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ��������� ������� �� ���������� �� ������ (����9) ********** ');

    delete from operlist a where  a.name = '�� ���������� ���� ����9 (���������)';
          --  ��������� ������� �� 

      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '�� ���������� ���� ����9 (���������)',
                                                  p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_CP_MOVE_MSFZ9[NSIFUNCTION][showDialogWindow=>false]',
                                                  p_rolename => 'CP_ROLE' ,
                                                  p_frontend => l_application_type_id
                                                  );




   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_W_CP) - ��� ֳ�� ������  ');
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
umu.add_report2arm(365,'$RM_W_CP');
umu.add_report2arm(1005,'$RM_W_CP');
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_W_CP.sql =========**
PROMPT ===================================================================================== 
