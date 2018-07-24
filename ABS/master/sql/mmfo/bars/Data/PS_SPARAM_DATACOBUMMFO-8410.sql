prompt ... 

SET DEFINE OFF;

begin
    execute immediate 'Insert into BARS.PS_SPARAM
   (NBS, SPID)
 Values
   (''9031'', 348)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.PS_SPARAM
   (NBS, SPID)
 Values
   (''9030'', 348)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.PS_SPARAM
   (NBS, SPID)
 Values
   (''9500'', 348)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.PS_SPARAM
   (NBS, SPID)
 Values
   (''9503'', 348)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.PS_SPARAM
   (NBS, SPID)
 Values
   (''9510'', 348)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.PS_SPARAM
   (NBS, SPID)
 Values
   (''9520'', 348)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.PS_SPARAM
   (NBS, SPID)
 Values
   (''9521'', 348)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.PS_SPARAM
   (NBS, SPID)
 Values
   (''9523'', 348)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

COMMIT;
/