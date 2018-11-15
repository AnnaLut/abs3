begin 
  bpa.alter_policy_info('CORP2_USER_FUNCTIONS', 'WHOLE',  null,  null, null, null);
end;
/
begin
  bpa.alter_policy_info('CORP2_USER_FUNCTIONS', 'FILIAL',  null,  null, null, null);
end;
/


-- Create table
begin
    execute immediate 'create table CORP2_USER_FUNCTIONS
(
  user_id NUMBER(38),
  func_id NUMBER(10),
  constraint PK_CRPUSERFUNCS primary key (USER_ID, func_id)
)
organization index';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/

-- Add comments to the table 
comment on table CORP2_USER_FUNCTIONS
  is 'Звязок користувач-функція';
-- Add comments to the columns 
comment on column CORP2_USER_FUNCTIONS.user_id
  is 'Ід користувача';
comment on column CORP2_USER_FUNCTIONS.func_id
  is 'Ід функції';

grant select, insert, update, delete, alter on CORP2_USER_FUNCTIONS to BARS_ACCESS_DEFROLE;
