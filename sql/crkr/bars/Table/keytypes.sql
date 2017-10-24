BEGIN
   bpa.alter_policy_info ('KEYTYPES',
                          'WHOLE',
                          NULL,
                          NULL,
                          NULL,
                          NULL);
   bpa.alter_policy_info ('KEYTYPES',
                          'FILIAL',
                          NULL,
                          NULL,
                          NULL,
                          NULL);
END;
/

begin
    execute immediate 'create table KEYTYPES
(
  id   NUMBER not null,
  name VARCHAR2(200),
  code VARCHAR2(30) not null
)';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

comment on column KEYTYPES.id
  is 'Ідентифікатор ключа';
comment on column KEYTYPES.name
  is 'Назва ключа';

begin
    execute immediate 'alter table KEYTYPES
  add constraint PK_KEYTYPES primary key (ID)';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table KEYTYPES
  add constraint UK_KEYTYPES_CODE unique (CODE)';
 exception when others then 
    if sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into keytypes (ID, NAME, CODE)
values (1, ''Вільні реквізити'', ''WAY_DOC'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into keytypes (ID, NAME, CODE)
values (2, ''Заказ пенсійних посвідчень'', ''PENS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

