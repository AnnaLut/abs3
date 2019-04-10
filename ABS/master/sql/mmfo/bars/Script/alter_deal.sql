declare
    name_already_used exception;
    such_constraint_already_exists exception;
    pragma exception_init(name_already_used, -955);
    pragma exception_init(such_constraint_already_exists, -2275);
begin
    lock table deal in exclusive mode;

    execute immediate 'alter table deal modify id number(38)';
    execute immediate 'alter table deal modify customer_id number(38)';
    execute immediate 'alter table deal modify deal_type_id number(38)';
    execute immediate 'alter table deal modify product_id number(38)';
    execute immediate 'alter table deal modify curator_id number(38)';

    execute immediate 'ALTER TABLE DEAL ADD CONSTRAINT FK_DEAL_REF_OBJECT FOREIGN KEY (ID) REFERENCES OBJECT (ID)';
exception
    when name_already_used or such_constraint_already_exists then
         null;
end;
/
