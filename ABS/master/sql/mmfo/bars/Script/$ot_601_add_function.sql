declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_F601';
begin   
     -- C������/�������� ���
    umu.cor_arm( l_codearm, '��� "����� 601"', 1);   
    -- ������� �������� �������
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     '�������� ������� �������� ������� �� 601 �����',          -- ������������ �������
                    p_funcname  =>     '/barsroot/Compare_351_601/Compare_351_601/index',      -- ������ ������ �������
                    p_frontend  =>      1 );                       -- 1 - web ���������, 0 - desctop
    -- �������� �������� ���
    umu.add_func2arm(l_codeoper, l_codearm, 1 );      --(1/0 - ��������������/���������������� ������)
    commit;
end;
/