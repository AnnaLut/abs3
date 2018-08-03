begin
    execute immediate 'create table TMP_CL_PAYMENT
(
  cl_id NUMBER(38) not null,
  ref   NUMBER(38)
)
tablespace BRSDYND
  pctfree 10
  initrans 1
  maxtrans 255';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table TMP_CL_PAYMENT
  add constraint PK_TMP_CL_PAYMENT primary key (CL_ID)
  using index 
  tablespace BRSDYND
  pctfree 10
  initrans 2
  maxtrans 255';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table BARS.TMP_CL_PAYMENT add is_auto_pay NUMBER(1) default 0';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/


begin
    execute immediate 'alter table BARS.TMP_CL_PAYMENT add is_payed NUMBER(1) default 0';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/

begin
    execute immediate 'alter table TMP_CL_PAYMENT add type NUMBER(1) default 1 not null';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/

-- Add comments to the columns 
comment on column TMP_CL_PAYMENT.type
  is '1-платеж, 2- свифт, 3- заявка';