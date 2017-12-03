declare
 l_co           operlist.codeoper%type ; 
 l_funcname_old operlist.funcname%type := 
            'FunNSIEditF("TEST_MANY_CCK_DH[PROC=>Z23.REZ_DEB_F(:D,1,:Z,1)][PAR=>:D(SEM=Зв_дата_01,TYPE=D),:Z(SEM=Включ.в 1B=1/0,TYPE=N))][EXEC=>BEFORE]",1)'; 
 l_funcname_new operlist.funcname%type := 
            'FunNSIEditF("TEST_MANY_CCK_DH[PROC=>Z23.REZ_DEB_F(:D,1,0,1)][PAR=>:D(SEM=Зв_дата_01,TYPE=D)][EXEC=>BEFORE]",1)'; 

begin
   update operlist set funcname = l_funcname_new where funcname = l_funcname_old;
end;
/

