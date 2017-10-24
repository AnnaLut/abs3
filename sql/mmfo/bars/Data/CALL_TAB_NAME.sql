prompt ... 


begin
    execute immediate 'Insert into BARS.CALL_TAB_NAME
   (NAME)
 Values
   (''ALL'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.CALL_TAB_NAME
   (NAME)
 Values
   (''FREE'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.CALL_TAB_NAME
   (NAME)
 Values
   (''META_COLUMNS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.CALL_TAB_NAME
   (NAME)
 Values
   (''META_NSIFUNCTION'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.CALL_TAB_NAME
   (NAME)
 Values
   (''OPERLIST'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 
