declare 
    l_codeoper number;
    l_codearm  varchar2(10) := 'RISK';
    l_name     operlist.name%type := '4.5. Перегляд/заповнення параметрiв по 9200, 9300 ...';
    l_funcname operlist.funcname%type := 'FunNSIEditF("V_9200[PROC=>PUL_DAT(:Par0,'')][PAR=>:Par0(SEM=Звiтна_дата 01.mm.yyyy>,TYPE=S)][EXEC=>BEFORE]", 0)';
begin 

   -- обновить функцию
   update operlist set funcname = l_funcname where name = l_name;
   commit;
end;
/

