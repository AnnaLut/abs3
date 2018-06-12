declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create global temporary table tmp_pledge
    (
            customer_code varchar2(4000 byte),
            pledge_number varchar2(4000 byte),
            pledge_date date,
            request_id number(38),
            core_pledge_kf varchar2(6 char),
            core_pledge_id number(38),
            core_customer_id number(38),
            default_core_pledge_kf varchar2(6 char),
            default_core_pledge_id number(38),
            pledge_type VARCHAR2(2)			
    ) on commit delete rows';
exception
    when name_already_used then
         null;
end;
/

begin   
   execute immediate 'alter table tmp_pledge add pledge_type VARCHAR2(2)';
     exception when others then 
       if sqlcode=-955 then null; end if; 
end;
/