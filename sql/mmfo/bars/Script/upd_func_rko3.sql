begin
  operlist_adm.modify_func_by_name(
    p_name         => 'RKO3.Äîãîâ³ðíå ÑÏÈÑÀÍÍß êîì³ñ³¿ 2600->357* ïî ÂÑ²Õ ðàõ.',
    p_new_funcpath => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0'||chr(38)||'sPar=[PROC=>RKO.PAY( 2, gl.BD, '' and a.acc not in (select acc from RKO_3570 ) '' )][QST=>Âèêîíàòè RKO3.Äîãîâ³ðíå ÑÏÈÑÀÍÍß êîì³ñ³¿ 2600->357* ïî ÂÑ²Õ ðàõ.?][MSG=>OK]',
    p_new_name     => null);
commit;
end;
/
