declare 
    l_codeoper number;
    id_        operlist.codeoper%type;
    l_codearm  varchar2(10) := '$RM_MBDK';
    l_name     operlist.name%type := '��������/���������� ��������i� ���� �� ����� ��� ������� 351';
    l_funcname operlist.funcname%type := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=2'||chr(38)||
                                         'sPar=NBU23_CCK_BN[NSIFUNCTION][PROC=>PUL_DAT(to_char(:A,''dd-mm-yyyy''),NULL)][PAR=>:A(SEM=��i���_���� 01.MM.����>,TYPE=D)][EXEC=>BEFORE]';

begin 
   -- ����������
   operlist_adm.modify_func_by_name
                   (p_name         =>  l_name,
                    p_new_funcpath =>  l_funcname,
		    p_new_name     =>  l_name );

end;
/

