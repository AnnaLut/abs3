declare 
    l_codeoper number; 
begin   
    --������� ������� ���� ��� ���������� � ���
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     '���� ����������� ������� T00 �� ����',
                    p_funcname  =>     '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=V_T00_STATS[NSIFUNCTION][PROC=>PUL.PUT(''ZDAT'', to_char ( :D , ''dd.mm.yyyy'' ) )][PAR=>:D(SEM=�����_����,TYPE=D)][EXEC=>BEFORE]',
                    p_frontend  =>      1 );                       -- 1 - web ���������, 0 - desctop
	umu.add_func2arm(l_codeoper, '$RM_BVBB', 1);  -- ��� ���-�����
        umu.add_func2arm(l_codeoper, '$RM_@VPS', 1);  -- ��� ����. ���������� ���������
    commit;
end;
/