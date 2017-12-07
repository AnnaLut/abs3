--Script for change operlist 

begin
   operlist_adm.modify_func_by_path
                  (p_funcpath       =>  '%/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||CHR(38)||'tableName=TRANSFORM_2017_FORECAST%',
                  p_new_funcpath   =>  '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||CHR(38)||'tableName=V_TRANS2017_FORECAST_BRANCH');
   commit;
 end;
 
