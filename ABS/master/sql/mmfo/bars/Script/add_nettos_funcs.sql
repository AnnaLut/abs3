
declare 
    l_codeoper number;
begin   
    -- ������� �������� �������
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     '�������� ��������� �������� ���(CORP2)',          -- ������������ �������
                    p_funcname  =>     '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=V_NET_TOSS_LOG[CONDITIONS=>(V_NET_TOSS_LOG.phase=''CORP2'')]',      -- ������ ������ �������
                    p_frontend  =>      1 );                       -- 1 - web ���������, 0 - desctop
 
    -- �������� �������� ���
    umu.add_func2arm(l_codeoper, '$RM_BVBB', 1 );                 --(1/0 - ��������������/���������������� ������)
	umu.add_func2arm(l_codeoper, '$RM_VIZA', 1 );                 --(1/0 - ��������������/���������������� ������)
    commit;
	
	
	-- ������� �������� �������
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     '�������� ��������� �������� ���(CorpLight)',          -- ������������ �������
                    p_funcname  =>     '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=V_NET_TOSS_LOG[CONDITIONS=>(V_NET_TOSS_LOG.phase=''CL'')]',      -- ������ ������ �������
                    p_frontend  =>      1 );                       -- 1 - web ���������, 0 - desctop
 
    -- �������� �������� ���
    umu.add_func2arm(l_codeoper, '$RM_BVBB', 1 );                 --(1/0 - ��������������/���������������� ������)
	umu.add_func2arm(l_codeoper, '$RM_VIZA', 1 );                 --(1/0 - ��������������/���������������� ������)
    commit;
	
	
end;
/

