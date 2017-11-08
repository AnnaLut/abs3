declare
    l_application_type_id integer := user_menu_utl.APPLICATION_TYPE_WEB;
    l_function_id integer;
begin
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' NLF ��������� ���������� �� ����. ���/������� 3739 (��� NLF)');
          --  ��������� ����-�������
      l_function_id :=   operlist_adm.add_new_func(
                                                  p_name     => 'NLF ��������� ���������� �� ����. ���/������� 3739 (��� NLF)',
                                                  p_funcname => '/barsroot/gl/nl/index?tip=nlf' || chr(38) || 'tt=C14',
                                                  p_frontend => l_application_type_id
                                                  );

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  ����������� ������� ������� �� ������ ���� ($RM_@WF1) - SWIFT  ');
   operlist_adm.add_func_to_arm(l_function_id, '$RM_@WF2', p_approve => true);
   operlist_adm.add_func_to_arm(l_function_id, '$RM_@WF1', p_approve => true);
   DBMS_OUTPUT.PUT_LINE(' Commit;  ');
   commit;
end;
/



