prompt ... 


begin
    execute immediate 'Insert into BARS.SW_TT_OPER
   (ID, TT)
 Values
   (1, ''CN1'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_TT_OPER
   (ID, TT)
 Values
   (1, ''CN2'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_TT_OPER
   (ID, TT)
 Values
   (2, ''CUV'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_TT_OPER
   (ID, TT)
 Values
   (3, ''CN4'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_TT_OPER
   (ID, TT)
 Values
   (4, ''CN3'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_TT_OPER
   (ID, TT)
 Values
   (5, ''CNU'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

COMMIT;
