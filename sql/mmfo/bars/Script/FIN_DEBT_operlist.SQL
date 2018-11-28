update operlist set funcname ='/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0'||chr(38)||'sPar=FIN_DEBT[showDialogWindow=>false][EDIT_MODE=>MULTI_EDIT]' where codeoper = 2122 ;
commit;
