declare 

begin
  bc.go ('/');   
     operlist_adm.modify_func_by_name
                   (p_name          =>     '0.Системи переводiв(СП), що дiють в ОБ',          -- Наименование функции
                    p_new_funcpath  =>     '/barsroot/ndi/referencebook/GetRefBookData/?tableName=MONEX0'||chr(38)||'accessCode=5'||chr(38)||'sPar=[NSIFUNCTION]',
                    p_new_name      =>      '0.Системи переводiв(СП), що дiють в ОБ' );
commit;
bc.home;
end;
/
