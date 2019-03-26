--------------------------------------------
-- �������� ������� � ���
--------------------------------------------
declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_@VPS'; -- ��� ����. ���������� ���������
begin   
    -- ������� �������� �������
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     '��������� �� �� ����������� � ������ ��� �� 5 ���� �� ������� ����',          -- ������������ �������
                    p_funcname  =>     '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_SEP_NOTSEND'||chr(38)||'accessCode=1'||chr(38)||'sPar=[PROC=>PUL_DAT(to_char(:Par0,''dd/mm/yyyy''),null)][PAR=>:Par0(SEM=�� ����,TYPE=D)][EXEC=>BEFORE]', 
                    p_frontend  =>      1 );                       -- 1 - web ���������, 0 - desctop
 
    -- �������� �������� ���
    umu.add_func2arm(l_codeoper, l_codearm, 1 );                 --(1/0 - ��������������/���������������� ������)
    commit;
end;
/