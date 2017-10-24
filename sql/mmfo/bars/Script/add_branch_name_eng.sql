begin
    execute immediate 'Insert into BARS.PARAMS$BASE
   (PAR, VAL, COMM, KF)
 Values
   (''BRANCH_NAME_ENG'', ''of the PJSC “State Savings Bank of Ukraine” Kyiv Regional Directorate'', ''Назва філії англійською мовою'', ''322669'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

COMMIT;
