exec bpa.alter_policy_info('COMPEN_RECIPIENTS', 'filial', null, null, null, null);
exec bpa.alter_policy_info('COMPEN_RECIPIENTS', 'whole',  null,  null, null, null);

-- Create table
begin
    execute immediate 'create table COMPEN_RECIPIENTS
(
  mfo       VARCHAR2(9) not null,
  url       VARCHAR2(4000),
  user_name VARCHAR2(30),
  user_pass VARCHAR2(60)
)
tablespace BRSSMLD';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table COMPEN_RECIPIENTS
  is 'Шляхи до сервісів інтеграції з РУ';
-- Add comments to the columns 
comment on column COMPEN_RECIPIENTS.mfo
  is 'МФО';
comment on column COMPEN_RECIPIENTS.url
  is 'Шлях до сервысу';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table COMPEN_RECIPIENTS
  add constraint PK_COMPENRECIPIENTS primary key (MFO)
  using index 
  tablespace BRSSMLD';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_RECIPIENTS
  add constraint FK_CRKRRECIP_BANKSRU_MFO foreign key (MFO)
  references BANKS_RU (MFO)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select, insert, update, delete on COMPEN_RECIPIENTS to BARS_ACCESS_DEFROLE;
