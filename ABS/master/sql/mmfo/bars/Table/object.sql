begin
    bars_policy_adm.alter_policy_info('OBJECT', 'WHOLE', null, null, null, null);
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'CREATE TABLE OBJECT
     (
            ID             NUMBER(38) NOT NULL,
            OBJECT_TYPE_ID NUMBER(38) NOT NULL,
            STATE_ID       NUMBER(38) NOT NULL
     )
     SEGMENT CREATION DEFERRED
     TABLESPACE BRSBIGD
     PARTITION BY RANGE (OBJECT_TYPE_ID) INTERVAL (1)
     (
         PARTITION DEFAULT_PARTITION VALUES LESS THAN (1)
     )';
exception
     when name_already_used then
          null;
end;
/

declare
     name_already_used exception;
     table_can_have_only_one_pk exception;
     pragma exception_init(name_already_used, -955);
     pragma exception_init(table_can_have_only_one_pk, -2260);
begin
    execute immediate 'ALTER TABLE OBJECT ADD CONSTRAINT PK_OBJECT PRIMARY KEY (ID) USING INDEX TABLESPACE BRSBIGI';
exception
    when name_already_used or table_can_have_only_one_pk then
         null;
end;
/

declare
    name_already_used exception;
    such_constraint_already_exists exception;
    pragma exception_init(name_already_used, -955);
    pragma exception_init(such_constraint_already_exists, -2275);
begin
    lock table object in exclusive mode;
    lock table object_type in exclusive mode;

    execute immediate 'ALTER TABLE OBJECT ADD CONSTRAINT FK_OBJECT_REF_OBJECT_TYPE FOREIGN KEY (OBJECT_TYPE_ID) REFERENCES OBJECT_TYPE (ID)';
exception
    when name_already_used or such_constraint_already_exists then
         null;
end;
/

declare
    name_already_used exception;
    such_constraint_already_exists exception;
    pragma exception_init(name_already_used, -955);
    pragma exception_init(such_constraint_already_exists, -2275);
begin
    lock table object in exclusive mode;
    lock table object_state in exclusive mode;

    execute immediate 'ALTER TABLE OBJECT ADD CONSTRAINT FK_OBJECT_REF_OBJECT_STATE FOREIGN KEY (STATE_ID) REFERENCES OBJECT_STATE (ID)';
exception
    when name_already_used or such_constraint_already_exists then
         null;
end;
/

comment on table object is 'Спільна таблиця об''єктів АБС будь-яких типів';
comment on column object.id is 'Глобальний внутрішній ідентифікатор об''єкта';
comment on column object.object_type_id is 'Тип об''єкту, описаний в OBJECT_TYPE';
comment on column object.state_id is 'Стан об''єкту, описаний в OBJECT_STATE';
