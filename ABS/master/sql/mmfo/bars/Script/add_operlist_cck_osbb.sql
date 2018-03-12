--------------------------------------------
-- �������� ������� � ���
--------------------------------------------
declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_UCCK';
begin   
    -- ������� �������� �������
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     'Գ�� ���������� �� ���� � ����� ���������� �� ���� �� ������� �� ��',          -- ������������ �������
                    p_funcname  =>     '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=[PROC=>CCK_OSBB(2,:ND)][PAR=>:ND(SEM=�������� ��)][QST=>�������� ���� ���������� � ����� ���������� �� ����?][MSG=>��������!]', 
                    p_frontend  =>      1 );                       -- 1 - web ���������, 0 - desctop
 
    -- �������� �������� ���
    umu.add_func2arm(l_codeoper, l_codearm, 1 );                 --(1/0 - ��������������/���������������� ������)
    commit;
end;
/

grant execute on CCK_OSBB to bars_access_defrole;