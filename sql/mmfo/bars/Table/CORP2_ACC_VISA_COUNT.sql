begin  
               bpa.alter_policy_info('CORP2_ACC_VISA_COUNT', 'FILIAL' , null, null, null, null);
               bpa.alter_policy_info('CORP2_ACC_VISA_COUNT', 'WHOLE' , null, null, null, null);
               null;
           end;
/
           
begin
    execute immediate 'create table CORP2_ACC_VISA_COUNT
(
  acc_id       NUMBER not null,
  visa_id      NUMBER not null,
  count        NUMBER
)';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table CORP2_ACC_VISA_COUNT
  add constraint PK_CORP2_ACC primary key (ACC_ID, VISA_ID)';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/   

grant ALL on  CORP2_ACC_VISA_COUNT to bars_access_defrole;
