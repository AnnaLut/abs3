--------------------------------------------
-- �������� ������� � ���
--------------------------------------------
declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_@WF1'; -- ��� ����. ���������� ���������
begin   
    -- ������� �������� �������
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     'GPI. �������� ���������',          -- ������������ �������
                    p_funcname  =>     '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_SW_GPI_STATUSES'||chr(38)||'accessCode=1[EXEC=>BEFORE]', 
                    p_frontend  =>      1 );                       -- 1 - web ���������, 0 - desctop
 
    -- �������� �������� ���
    umu.add_func2arm(l_codeoper, l_codearm, 1 );                 --(1/0 - ��������������/���������������� ������)
    commit;
end;
/