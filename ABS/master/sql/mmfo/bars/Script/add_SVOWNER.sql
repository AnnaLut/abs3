--------------------------------------------
-- �������� ������� � ���
--------------------------------------------
declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_NBUR';
begin   
    -- ������� �������� �������
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     '³������ ��� ��������� �������� �����',          -- ������������ �������
                    p_funcname  =>     '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0'||chr(38)||'sPar=V_SV_OWNER[NSIFUNCTION][showDialogWindow=>false]', 
                    p_frontend  =>      1 );                       -- 1 - web ���������, 0 - desctop
 
    -- �������� �������� ���
    umu.add_func2arm(l_codeoper, l_codearm, 1 );                 --(1/0 - ��������������/���������������� ������)
    commit;
end;
/