prompt ... 


begin
    execute immediate 'Insert into BARS.SW_OPERATION
   (ID, CODE, NAME)
 Values
   (1, ''SEND'', ''³�������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_OPERATION
   (ID, CODE, NAME)
 Values
   (2, ''PAYOUT'', ''�������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_OPERATION
   (ID, CODE, NAME)
 Values
   (3, ''CANCEL'', ''³���������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_OPERATION
   (ID, CODE, NAME)
 Values
   (4, ''RETURN'', ''����������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_OPERATION
   (ID, CODE, NAME)
 Values
   (5, ''PAYOUTCANCEL'', ''³���� ������� � ���� �������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.SW_OPERATION
   (ID, CODE, NAME)
 Values
   (6, ''PAYOUTRETURN'', ''³���� ������� �� � ���� �������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

