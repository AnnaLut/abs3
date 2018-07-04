--------------------------------------------
-- �������� ������� � ���
--------------------------------------------
declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_VALB'; -- ��� �������� ��������� 
    l_codearm_1  varchar2(10) := '$RM_@WF1'; -- ��� SWIFT. ������� ���������� (�����) 
begin   
    -- ������� �������� �������
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     '3720 NLI ->����� ����������� SWIFT �� ��. ������',          -- ������������ �������
                    p_funcname  =>     '/barsroot/gl/nl/index?tip=nli'||chr(38)||'ttList=99', 
                    p_frontend  =>      1 );                       -- 1 - web ���������, 0 - desctop
 
    -- �������� �������� ���
    umu.add_func2arm(l_codeoper, l_codearm, 1 );                 --(1/0 - ��������������/���������������� ������)
    umu.add_func2arm(l_codeoper, l_codearm_1, 1 );                 --(1/0 - ��������������/���������������� ������)
    commit;
end;
/

declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_VALB'; -- ��� �������� ���������
    l_codearm_1  varchar2(10) := '$RM_@WF1'; -- ��� SWIFT. ������� ���������� (�����)
begin   
    -- ������� �������� �������
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     '3720 NLJ ->����� ����������� SWIFT �� Գ�. ������',          -- ������������ �������
                    p_funcname  =>     '/barsroot/gl/nl/index?tip=nlj'||chr(38)||'ttList=99', 
                    p_frontend  =>      1 );                       -- 1 - web ���������, 0 - desctop
 
    -- �������� �������� ���
    umu.add_func2arm(l_codeoper, l_codearm, 1 );                 --(1/0 - ��������������/���������������� ������)
    umu.add_func2arm(l_codeoper, l_codearm_1, 1 );                 --(1/0 - ��������������/���������������� ������)
    commit;
end;
/