begin
operlist_adm.modify_func_by_path
                   (p_funcpath       =>  '%/barsroot/swi/Search.aspx',
                    p_new_funcpath   =>  '/barsroot/swift/search');
end;                    
/
commit; 