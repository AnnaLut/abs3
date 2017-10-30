declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_RISK';
    l_name     operlist.name%type := '4.5. ��������/���������� ��������i� �� 9200, 9300 ...';
    -- l_name2    operlist.name%type := '����: �������� ����';
    l_funcname operlist.funcname%type := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0'||chr(38)||
                                         'sPar=V_9200[PROC=>PUL_DAT(to_char(:A,''dd-mm-yyyy''),null)][PAR=>:A(SEM=��_����_01,TYPE=D)][EXEC=>BEFORE]';
begin 

    -- ������� �������� �������
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>   l_name,
                    p_funcname  =>   l_funcname, 
                    p_frontend  =>   1 ); 
 
    -- �������� �������� ���
    umu.add_func2arm(l_codeoper, l_codearm, 1 );     
    commit;

    -- �������� �������
    --update operlist set funcname = l_funcname where name = l_name2;
    --commit;
end;
/

