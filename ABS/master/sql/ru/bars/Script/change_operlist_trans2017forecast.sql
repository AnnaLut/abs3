--Script for change operlist 

begin
   update operlist set funcname = '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||CHR(38)||'tableName=V_TRANS2017_FORECAST_BRANCH'
   where funcname like '%/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||CHR(38)||'tableName=TRANSFORM_2017_FORECAST%';
   commit;
 end;
/ 
