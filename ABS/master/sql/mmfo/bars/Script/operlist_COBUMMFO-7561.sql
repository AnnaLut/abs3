declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_RISK';
    l_name     operlist.name%type := '4.5. ��������/���������� ��������i� �� 9200, 9300 ...';
    l_funcname operlist.funcname%type := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0'||chr(38)||
                                         'sPar=V_9200[PROC=>REZ_PAR_9200_ADD(:A)][PAR=>:A(SEM=��_����_01,TYPE=D)][EXEC=>BEFORE]';
begin 

   -- �������� �������
   update operlist set funcname = l_funcname where name = l_name;
   commit;
end;
/

