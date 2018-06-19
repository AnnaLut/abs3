--------------------------------------------
-- �������� ������� � ���
--------------------------------------------
declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_@WF1'; -- ��� SWIFT. ������� ���������� (�����)
begin   
    -- ������� �������� �������
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     'SWIFT. ����� �������� REJECT MT199',          -- ������������ �������
                    p_funcname  =>     '/barsroot/swift/swiftmt/index?isrejectview=true', 
                    p_frontend  =>      1 );                       -- 1 - web ���������, 0 - desctop
 
    -- �������� �������� ���
    umu.add_func2arm(l_codeoper, l_codearm, 1 );                 --(1/0 - ��������������/���������������� ������)
    commit;
end;
/


--------------------------------------------
-- �������� ������� � ���
--------------------------------------------
declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_@WF1'; -- ��� SWIFT. ������� ���������� (�����)
begin   
    -- ������� �������� �������
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     'GPI. ���������� ��199(������ ACSC)',          -- ������������ �������
                    p_funcname  =>     '/barsroot/swift/swiftmt/index?isrejectview=false', 
                    p_frontend  =>      1 );                       -- 1 - web ���������, 0 - desctop
 
    -- �������� �������� ���
    umu.add_func2arm(l_codeoper, l_codearm, 1 );                 --(1/0 - ��������������/���������������� ������)
    commit;
end;
/