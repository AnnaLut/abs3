begin 
  bpa.alter_policy_info('CORP2_FUNCTIONS', 'WHOLE',  null,  null, null, null);
end;
/
begin
  bpa.alter_policy_info('CORP2__FUNCTIONS', 'FILIAL',  null,  null, null, null);
end;
/

begin
    execute immediate 'create table CORP2_FUNCTIONS
                       (
                         func_id     NUMBER(10),
                         func_name   VARCHAR2(100),
                         start_page  VARCHAR2(250),
                         description VARCHAR2(200),
                         func_type   NUMBER(2),
                         user_type   NUMBER(1)
                       )
                       tablespace BRSMDLD
                         pctfree 10
                         initrans 1
                         maxtrans 255
                         storage
                         (
                           initial 128K
                           next 128K
                           minextents 1
                           maxextents unlimited
                         )
                       rowdependencies';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 
-- Add comments to the table 
comment on table CORP2_FUNCTIONS
  is 'Функції КОРП2';
-- Add comments to the columns 
comment on column CORP2_FUNCTIONS.func_id
  is 'Код функції';
comment on column CORP2_FUNCTIONS.func_name
  is 'Назва функції';
comment on column CORP2_FUNCTIONS.start_page
  is 'Адреса сторінки(url)';
comment on column CORP2_FUNCTIONS.description
  is 'Опис сторінки';
comment on column CORP2_FUNCTIONS.func_type
  is 'Тип функції';
comment on column CORP2_FUNCTIONS.user_type
  is 'Тип користувача';


begin
    execute immediate 'alter table CORP2_FUNCTIONS
                         add constraint PK_CORP2FUNCTIONS primary key  (FUNC_ID)
                         using index
                         tablespace BRSDYND
                         pctfree 10
                         initrans 2
                         maxtrans 255
                         storage
                         (
                           initial 64K
                           next 1M
                           minextents 1
                           maxextents unlimited
                         )';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

                       
begin
    execute immediate 'alter table CORP2_FUNCTIONS
  add constraint UK_CORP2FUNCTIONS_STARTPAGE unique (START_PAGE)
  using index 
  tablespace BRSMDLD
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 128K
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table CORP2_FUNCTIONS
  add constraint CC_COREFUNCTIONS_USERYPE_NN
  check ("USER_TYPE" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CORP2_FUNCTIONS
  add constraint CC_CORP2FUNCTIONS_FUNCID_NN
  check ("FUNC_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CORP2_FUNCTIONS
  add constraint CC_CORP2FUNCTIONS_FUNCTYPE_NN
  check ("FUNC_TYPE" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CORP2_FUNCTIONS
  add constraint CC_CORP2FUNCTIONS_NAME_NN
  check ("FUNC_NAME" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CORP2_FUNCTIONS
  add constraint CC_CORP2FUNCTIONS_STARTPAGE_NN
  check ("START_PAGE" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

 grant select on CORP2_FUNCTIONS to bars_access_defrole;