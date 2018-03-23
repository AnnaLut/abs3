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
