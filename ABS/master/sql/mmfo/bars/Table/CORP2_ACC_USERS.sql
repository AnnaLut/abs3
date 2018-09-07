begin 
  bpa.alter_policy_info('CORP2_ACC_USERS', 'WHOLE',  null,  null, null, null);
end;
/
begin
  bpa.alter_policy_info('CORP2_ACC_USERS', 'FILIAL',  null,  null, null, null);
end;
/

-- Create table
begin
    execute immediate 'create table CORP2_ACC_USERS
(
  nls             varchar2(20),
  kv              varchar2(20),
  kf              varchar2(10),
  user_id         NUMBER,
  cust_id         NUMBER,
  can_view        VARCHAR2(1),
  can_debit       VARCHAR2(1),
  can_visa        VARCHAR2(1),
  visa_id         INTEGER,
  active          VARCHAR2(1) default ''N'',
  sequential_visa VARCHAR2(1),
  constraint PK_CRPACCUSERS primary key (NLS, KV, KF, USER_ID)
)
organization index';

 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

grant select, insert, update, delete, alter on CORP2_ACC_USERS to BARS_ACCESS_DEFROLE;

