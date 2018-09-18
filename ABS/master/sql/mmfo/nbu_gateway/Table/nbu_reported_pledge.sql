declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table nbu_reported_pledge
     (
            id number(38) not null,
            customer_object_id number(38) not null,
            order_number number(2) not null,
            pledge_number varchar2(30 char) not null,
            pledge_date date not null,
            pledge_amount number(38),
            pledge_currency_id number(3),
            core_pledge_kf varchar2(6 char),
            core_pledge_id number(38),
 	    pledge_type VARCHAR2(2)
     )
     tablespace brsmdld';
exception
    when name_already_used then
         null;
end;
/

begin
    execute immediate
    'alter table NBU_REPORTED_PLEDGE add PLEDGE_TYPE VARCHAR2(2)';
exception
    when others then
         null;
end;
/

declare
    name_already_used exception;
    table_can_have_only_one_pk exception;
    pragma exception_init(name_already_used, -955);
    pragma exception_init(table_can_have_only_one_pk, -2260);
begin
    execute immediate 'alter table nbu_reported_pledge add constraint pk_nbu_reported_pledge primary key (id) using index tablespace brsmdli';
exception
    when name_already_used or table_can_have_only_one_pk then
         null;
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index uix_nbu_reported_pledge on nbu_reported_pledge (customer_object_id, pledge_number, pledge_date) tablespace brsmdli compress 2';
exception
    when name_already_used then
         null;
end;
/

begin   
   execute immediate 'alter table nbu_reported_pledge add pledge_type VARCHAR2(2)';
     exception when others then 
       if sqlcode=-955 then null; end if; 
end;
/
