prompt ... 


begin
    execute immediate 'Insert into BARS.SW_BRANCH_WS_PARAMETERS
   (KF, BRANCH_NAME, URL, LOGIN, PASSWORD)
 Values
   (''300465'', ''ГУ Ощадбанк'', ''https://10.7.98.11/barsroot/webservices/'', ''tech_sw'', ''35c0576c94cf1846eacb52a4f311b042ec37ef67'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

