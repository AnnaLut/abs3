declare
l_codeoper number;
begin
l_codeoper:=operlist_adm.add_new_func
                   (p_name      =>     'Âèõ³äí³ çàïèòè Barstrans',          
                    p_funcname  =>     '/barsroot/TranspUi/TranspUi/Index?formType=1',     
                    p_frontend  =>      1 );
end;
/
declare
l_codeoper number;
begin
l_codeoper:=operlist_adm.add_new_func
                   (p_name      =>     'Âõ³äí³ çàïèòè Barstrans',          
                    p_funcname  =>     '/barsroot/TranspUi/TranspUi/Index?formType=2',     
                    p_frontend  =>      1 );
end;
/