exec bpa.alter_policy_info('COMPEN_PORTFOLIO_DBCODE_OLD', 'filial', null, null, null, null);
exec bpa.alter_policy_info('COMPEN_PORTFOLIO_DBCODE_OLD', 'whole',  null,  null, null, null);

begin
    execute immediate 'create table COMPEN_PORTFOLIO_DBCODE_OLD
(
  compen_id NUMBER,
  dbcode    VARCHAR2(32),
  doctype   INTEGER,
  docserial VARCHAR2(16),
  docnumber VARCHAR2(32)
)tablespace BRSMDLD';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table COMPEN_PORTFOLIO_DBCODE_OLD
  is 'Старі DBCODE при зміні документів на вкладах';

begin
-- Create/Rebegin
    execute immediate 'create index IDX_DBCODE_COMPEN_ID on COMPEN_PORTFOLIO_DBCODE_OLD (COMPEN_ID)
  tablespace BRSMDLI';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table COMPEN_PORTFOLIO_DBCODE_OLD
  add constraint FK_DBCODE_COMPEN_ID foreign key (COMPEN_ID)
  references COMPEN_PORTFOLIO (ID) on delete cascade';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 

begin
-- Create/Rebegin
    execute immediate 'create index IDX_DBCODE_DBCODE_ID on COMPEN_PORTFOLIO_DBCODE_OLD (dbcode)
  tablespace BRSMDLI';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_PORTFOLIO_DBCODE_OLD add docorg VARCHAR2(256)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table COMPEN_PORTFOLIO_DBCODE_OLD add docdate DATE';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table COMPEN_PORTFOLIO_DBCODE_OLD add state_compen_prev NUMBER';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table COMPEN_PORTFOLIO_DBCODE_OLD add oper_id NUMBER';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
begin
-- Create/Rebegin
    execute immediate 'create index IDX_DBCODE_OPER_ID on COMPEN_PORTFOLIO_DBCODE_OLD (oper_id)
  tablespace BRSMDLI';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table COMPEN_PORTFOLIO_DBCODE_OLD add type_person number(1) default 0';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

comment on column COMPEN_PORTFOLIO_DBCODE_OLD.type_person is 'Тип особи 0-фіз 1-юр (оф.спадщини)';

begin
    execute immediate 'alter table COMPEN_PORTFOLIO_DBCODE_OLD add name_person varchar2(255)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

comment on column COMPEN_PORTFOLIO_DBCODE_OLD.name_person is 'Назва юр.особи (оф.спадщини)';

begin
    execute immediate 'alter table COMPEN_PORTFOLIO_DBCODE_OLD add edrpo_person varchar2(10)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

comment on column COMPEN_PORTFOLIO_DBCODE_OLD.edrpo_person is 'ЄДРПОУ юр.особи (оф.спадщини)';


  GRANT SELECT ON COMPEN_PORTFOLIO_DBCODE_OLD TO BARS_ACCESS_DEFROLE;