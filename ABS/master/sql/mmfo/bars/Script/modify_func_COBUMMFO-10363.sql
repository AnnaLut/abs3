declare 

begin
  bc.go ('/');   
     operlist_adm.modify_func_by_name
                   (p_name          =>     '0.������� �������i�(��), �� �i��� � ��',          -- ������������ �������
                    p_new_funcpath  =>     '/barsroot/ndi/referencebook/GetRefBookData/?tableName=MONEX0'||chr(38)||'accessCode=5'||chr(38)||'sPar=[NSIFUNCTION]',
                    p_new_name      =>      '0.������� �������i�(��), �� �i��� � ��' );
commit;
bc.home;
end;
/
