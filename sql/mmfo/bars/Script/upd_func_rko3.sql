begin
  operlist_adm.modify_func_by_name(
    p_name         => 'RKO3.�������� �������� ���� 2600->357* �� �Ѳ� ���.',
    p_new_funcpath => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0'||chr(38)||'sPar=[PROC=>RKO.PAY( 2, gl.BD, '' and a.acc not in (select acc from RKO_3570 ) '' )][QST=>�������� RKO3.�������� �������� ���� 2600->357* �� �Ѳ� ���.?][MSG=>OK]',
    p_new_name     => null);
commit;
end;
/
