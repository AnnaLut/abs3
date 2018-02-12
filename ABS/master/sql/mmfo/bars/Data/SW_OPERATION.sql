prompt ... 


begin
    execute immediate 'Insert into BARS.SW_OPERATION
   (ID, CODE, NAME)
 Values
   (1, ''SEND'', ''Відправка'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_OPERATION
   (ID, CODE, NAME)
 Values
   (2, ''PAYOUT'', ''Виплата'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_OPERATION
   (ID, CODE, NAME)
 Values
   (3, ''CANCEL'', ''Відкликання'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_OPERATION
   (ID, CODE, NAME)
 Values
   (4, ''RETURN'', ''Анулювання'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_OPERATION
   (ID, CODE, NAME)
 Values
   (5, ''PAYOUTCANCEL'', ''Відміна виплати в день виплати'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_OPERATION
   (ID, CODE, NAME)
 Values
   (6, ''PAYOUTRETURN'', ''Відміна виплати НЕ в день виплати'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

