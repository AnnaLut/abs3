BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SAGO_REQUESTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SAGO_REQUESTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

-- Create table
begin
    execute immediate 'create table SAGO_REQUESTS
(
  id          NUMBER(38) not null,
  create_date DATE,
  data        CLOB,
  state       NUMBER(2),
  comm        VARCHAR2(1000),
  user_id     NUMBER(38),
  doc_count   NUMBER(5)
)
tablespace BRSBIGD
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

-- Add comments to the columns 
comment on column SAGO_REQUESTS.id
  is 'Идентификатор запроса';
comment on column SAGO_REQUESTS.create_date
  is 'Дата создания реестра';
comment on column SAGO_REQUESTS.data
  is 'Данные по реестру';
comment on column SAGO_REQUESTS.state
  is 'Статус реестра';
comment on column SAGO_REQUESTS.comm
  is 'Комментарий к статусу';
comment on column SAGO_REQUESTS.user_id
  is 'Пользователь';
comment on column SAGO_REQUESTS.doc_count
  is 'Количество документов';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table SAGO_REQUESTS
  add constraint PK_SAGO_REQUESTS primary key (ID)
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

