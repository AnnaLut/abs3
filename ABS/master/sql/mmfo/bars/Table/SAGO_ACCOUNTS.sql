
BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SAGO_ACCOUNTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SAGO_ACCOUNTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

-- Create table
begin
    execute immediate 'create table SAGO_ACCOUNTS
(
  nbs VARCHAR2(4),
  nls VARCHAR2(14),
  kf  VARCHAR2(6)
)
tablespace BRSSMLD
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table SAGO_ACCOUNTS
  is 'Счета для проведения операций из системы САГО';
-- Add comments to the columns 
comment on column SAGO_ACCOUNTS.nbs
  is 'балансовый счет';
comment on column SAGO_ACCOUNTS.nls
  is 'номер лицевого счета';
