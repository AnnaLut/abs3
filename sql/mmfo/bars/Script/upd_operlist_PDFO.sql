begin   
       operlist_adm.modify_func_by_path (
        p_funcpath       => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=V_PDFO[NSIFUNCTION][PROC=>PUL_DAT(:A,null)][PAR=>:A(SEM=Звiтна дата 01/ММ/РР)][EXEC=>BEFORE]',
        p_new_funcpath   => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=V_PDFO[NSIFUNCTION][PROC=>PUL.PUT(''WDAT'',:A)][PAR=>:A(SEM=Звiтна дата 01/ММ/РРPP)][EXEC=>BEFORE]');
 
END;
/
commit;