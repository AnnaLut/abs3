declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_WCCK';
    l_name     operlist.name%type := 'I�����������i� �� �� (JOB)';
    l_funcname operlist.funcname%type := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2'||chr(38)||
                                         'sPar=INV_FL_23[NSIFUNCTION][PROC=>PUL_DAT(to_char(:A,''dd-mm-yyyy''),null)][PAR=>:A(SEM=��_���� 01/��/����,TYPE=D)][EXEC=>BEFORE]';

begin 
    -- ������� �������� �������
    l_codeoper := operlist_adm.add_new_func (p_name  =>  l_name, p_funcname  =>  l_funcname, p_frontend  =>  1 ); 
 
    -- �������� �������� ���
    umu.add_func2arm(l_codeoper, l_codearm, 1 );     
    commit;

end;
/

