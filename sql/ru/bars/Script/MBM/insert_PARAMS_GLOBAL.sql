begin
    execute immediate 
	'Insert into PARAMS$GLOBAL
		(PAR, VAL, COMM, SRV_FLAG)
	Values
		(''USAGE_CORPLIGHT'', ''1'', ''1=Признак що використовується підключення до CorpLight'', 0)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 