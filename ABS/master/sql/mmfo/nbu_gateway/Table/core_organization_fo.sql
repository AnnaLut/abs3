declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin 
    execute immediate
    'create table core_organization_fo
     (
            request_id number(38),
            rnk        number(38),
            typew      number(1),
            codedrpou  varchar2(20),
            namew      varchar2(254),
            kf         varchar2(6 char)
     )
     tablespace brsmdld
     partition by range (request_id) interval (1)
     ( partition initial_partition values less than (1) )';
exception
    when name_already_used then
         null;
end;
/

comment on table core_organization_fo is 'Місце роботи Боржника';
comment on column core_organization_fo.rnk is 'Регистрационный номер.';
comment on column core_organization_fo.typew is 'Тип роботодавця';
comment on column core_organization_fo.codedrpou is 'Код ЄДРПОУ';
comment on column core_organization_fo.namew is 'Найменування роботодавця';

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create index i_core_organization_fo on core_organization_fo (request_id, rnk) tablespace brsmdli local compress 1';
exception
    when name_already_used then
         null;
end;
/
