PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_IMPC.sql =========*
PROMPT ===================================================================================== 

PROMPT *** Create/replace  ARM  $RM_IMPC ***

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET DEFINE       OFF

declare
  l_application_code      varchar2(10 char) := '$RM_IMPC';
  l_application_name      varchar2(300 char) := '��� ������ ����� ����������';
  l_application_type_id   integer := user_menu_utl.APPLICATION_TYPE_WEB;
  l_function_ids number_list := number_list();
  l_function_codeoper     OPERLIST.CODEOPER%type;
  l_function_deps         OPERLIST.CODEOPER%type;
  l_application_id        integer;
  l_role_resource_type_id integer := resource_utl.get_resource_type_id(user_role_utl.RESOURCE_TYPE_ROLE);
  l_arm_resource_type_id  integer := resource_utl.get_resource_type_id(user_menu_utl.get_arm_resource_type_code(l_application_type_id));
  l_func_resource_type_id integer := resource_utl.get_resource_type_id(user_menu_utl.get_func_resource_type_code(l_application_type_id));
  l integer := 0;
  d integer := 0;
begin
     DBMS_OUTPUT.PUT_LINE(' $RM_IMPC ��������� (��� ���������) ��� ��� ������ ����� ���������� ');
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ���������� ���. �������� - ��������� �����������(WEB) ********** ');
          --  ��������� ������� ���������� ���. �������� - ��������� �����������(WEB)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '���������� ���. �������� - ��������� �����������(WEB)',
                                                  p_funcname => '/barsroot/docinput/editprops.aspx?mode=1',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ MOPER ********** ');
          --  ��������� ������� ������ MOPER
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ MOPER',
                                                  p_funcname => '/barsroot/moper/default.aspx?int=I00&ext=I01',
                                                  p_rolename => 'START1' ,
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


    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� ������ 4.3: ������ ���������� (096) ********** ');
          --  ��������� ������� ������ 4.3: ������ ���������� (096)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => '������ 4.3: ������ ���������� (096)',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=ik&config=imp_4_3',
                                                  p_rolename => '' ,
                                                  p_frontend => l_application_type_id
                                                  );


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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I����� 3.1: ��������i ����� (tt=PKS,sk=84) ********** ');
          --  ��������� ������� I����� 3.1: ��������i ����� (tt=PKS,sk=84)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I����� 3.1: ��������i ����� (tt=PKS,sk=84)',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=zp&config=imp_3_1',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I����� 3.2: ����i��i ����� (tt=PKX,sk=87) ********** ');
          --  ��������� ������� I����� 3.2: ����i��i ����� (tt=PKX,sk=87)
      l := l +1;
      l_function_ids.extend(l);
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'I����� 3.2: ����i��i ����� (tt=PKX,sk=87)',
                                                  p_funcname => '/barsroot/sberutls/importex.aspx?imptype=zp&config=imp_3_2',
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

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I����� 6: ����� ����+ ********** ');
    l := l + 1;
    l_function_ids.extend(l);
    l_function_ids(l) := abs_utils.add_func( p_name     => 'I����� 6: ����� ����+',
                                             p_funcname => '/barsroot/sberutls/importex.aspx?imptype=sbon',
                                             p_rolename => 'WR_XMLIMP' ,
                                             p_frontend => l_application_type_id
                                           );

    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** ��������� ������� I����� : ����i� ��������i� ********** ');
    --  ��������� ������� I����� : ����i� ��������i�
    l := l + 1;
    l_function_ids.extend(l);
    l_function_ids(l) := abs_utils.add_func( p_name     => 'I����� : ����i� ��������i�',
                                             p_funcname => '/barsroot/sberutls/importproc.aspx?tp=1',
                                             p_rolename => 'WR_XMLIMP' ,
                                             p_frontend => l_application_type_id
                                           );

    -- ��������� ������� ������� I����� : ����������� i������������ ���������
    l_function_deps := abs_utils.add_func( p_name     => 'I����� : ����������� i������������ ���������',
                                           p_funcname => '/barsroot/sberutls/importproced.aspx\S*',
                                           p_rolename => 'WR_XMLIMP',
                                           p_frontend => l_application_type_id
                                         );
    abs_utils.add_func2deps( l_function_ids(l), l_function_deps );

      --  ��������� ������� ������� I����� : ����������� i������������ ���������
                     l_function_deps  :=   abs_utils.add_func(
															  p_name     => 'I����� : ����������� i������������ ���������',
															  p_funcname => '/barsroot/sberutls/importproced.aspx',
															  p_rolename => 'WR_XMLIMP' ,
															  p_frontend => l_application_type_id
															  );
					 abs_utils.add_func2deps( l_function_ids(l)  ,l_function_deps);

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_IMPC) - ��� ������ ����� ����������  ');
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
commit;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeapp$RM_IMPC.sql =========**
PROMPT ===================================================================================== 
