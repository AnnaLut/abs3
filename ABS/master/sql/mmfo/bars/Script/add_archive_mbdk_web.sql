	   set define off;
declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_MBDK';
begin   
     -- C������/�������� ���
    umu.cor_arm( l_codearm, '��� �������� ����', 1);   
    -- ������� �������� �������
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     '����� ���� ����',          -- ������������ �������
                    p_funcname  =>     '/barsroot/ndi/referencebook/GetRefBookData/?tableName=v_mbdk_archive&accessCode=1&sPar=[NSIFUNCTION]',      -- ������ ������ �������
                    p_frontend  =>      1 );                       -- 1 - web ���������, 0 - desctop
 
    -- �������� �������� ���
    umu.add_func2arm(l_codeoper, l_codearm, 1 );                 --(1/0 - ��������������/���������������� ������)
    commit;
end;
/
