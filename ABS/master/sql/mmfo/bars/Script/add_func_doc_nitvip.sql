declare 
    l_codeoper number; 
begin   
    --������� ������� ���� ��� ���������� � ���
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     '�������� ��������� ��������(��� ³�)',          -- ������������ �������
                    p_funcname  =>     '/barsroot/DocView/Docs/DocumentDateFilter?type=3', 
                    p_frontend  =>      1 );                       -- 1 - web ���������, 0 - desctop

    -- �� ������� �������� � ��� � �� ����
	umu.add_func2arm(l_codeoper, '$RM_BUHG', 1);  -- ��� �������� ���������
					
					
    commit;
end;
/