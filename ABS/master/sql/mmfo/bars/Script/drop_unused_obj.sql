
begin
   execute immediate 'drop trigger TAU_ACCOUNTS_NBU49';
exception when others then       
  if sqlcode=-942 then null; else raise; end if; 
end; 
/


begin
   execute immediate 'drop view V_INTEREST_TO_ACCRUAL2';
exception when others then       
  if sqlcode=-942 then null; else raise; end if; 
end; 
/


