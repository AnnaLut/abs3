prompt
prompt Creating table OW_KEYS
prompt ======================
prompt
begin
  bpa.alter_policy_info('OW_KEYS','FILIAL',null,null,null,null);
  bpa.alter_policy_info('OW_KEYS','WHOLE',null,null,null,null);
end;
/

begin
    execute immediate 'create table ow_keys
(
  key_id     NUMBER(18) not null,
  key_value  VARCHAR2(3900) not null,
  start_date DATE not null,
  end_date   DATE not null,
  is_active  VARCHAR2(1) default ''Y'' not null
)';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

comment on column OW_KEYS.key_id
  is 'Ідентифікатор ключа';
comment on column OW_KEYS.key_value
  is 'Значення ключа';
comment on column OW_KEYS.start_date
  is 'Термін початку дії ключа';
comment on column OW_KEYS.end_date
  is 'Термін закінчення дії ключа';
comment on column OW_KEYS.is_active
  is 'Статус(Y-активний(по-замовчуванню), N-не активний )';

begin
    execute immediate 'alter table OW_KEYS
  add constraint PK_OW_KEYS primary key (KEY_ID)';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if;
end;
/     
-- Add/modify columns 
begin
    execute immediate 'alter table OW_KEYS add type number';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table OW_KEYS
  add constraint FK_KEYSTOKEYTYPES foreign key (TYPE)
  references KEYTYPES (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 	
update ow_keys t
   set t.type =
       (select id from keytypes t where upper(t.code) = 'WAY_DOC')
where t.type is null;
/
commit;