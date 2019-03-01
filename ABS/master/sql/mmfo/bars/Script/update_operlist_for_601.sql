begin
update operlist set funcname='/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_NBU_SESSION_HISTORY[PROC=>PUL_DAT(to_char(:A,''dd-mm-yyyy''),NULL)][PAR=>:A(SEM=Дата в фотрмате день-месяц-год,TYPE=D)][EXEC=>BEFORE][EXCEL=>ALL_CSV][showDialogWindow=>false]' where codeoper=104;
commit;
end;
/