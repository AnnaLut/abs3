--------------------------------------------
-- �������� ������� � ���
--------------------------------------------
declare  
    l_codeoper number; 
    l_codearm  varchar2(10) := '$RM_STO1';
begin    
     -- C������/�������� ���
    umu.cor_arm( l_codearm, '��� �������� ������', 1);    
    -- ������� �������� �������
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     '���� ����',          -- ������������ �������
                    p_funcname  =>     '%/barsroot/cbirep/rep_list.aspx?codeapp=\S*%',      -- ������ ������ �������
                    p_frontend  =>      1 );                       -- 1 - web ���������, 0 - desctop

    -- �������� �������� ��� 
    umu.add_func2arm(l_codeoper, l_codearm, 1 );                 --(1/0 - ��������������/���������������� ������)
    commit;
end;
/

               

