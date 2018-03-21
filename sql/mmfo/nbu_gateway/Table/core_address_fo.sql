declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table core_address_fo
     (
            request_id    number(38),
            rnk           number(38),
            codregion     varchar2(4000 byte),
            area          varchar2(4000 byte),
            zip           varchar2(4000 byte),
            city          varchar2(4000 byte),
            streetaddress varchar2(4000 byte),
            houseno       varchar2(4000 byte),
            adrkorp       varchar2(4000 byte),
            flatno        varchar2(4000 byte),
            kf            varchar2(6 char)
     )
     tablespace brsmdld
     partition by range (request_id) interval (1)
     ( partition initial_partition values less than (1) )';
exception
    when name_already_used then
         null;
end;
/

comment on table core_address_fo is 'Адреса реєстрації. Структура';
comment on column core_address_fo.rnk is 'Регистрационный номер.';
comment on column core_address_fo.codregion is 'Код регіону';
comment on column core_address_fo.area is 'Район';
comment on column core_address_fo.zip is 'Поштовий індекс';
comment on column core_address_fo.city is 'Назва населеного пункту ';
comment on column core_address_fo.streetaddress is 'Вулиця';
comment on column core_address_fo.houseno is 'Будинок';
comment on column core_address_fo.adrkorp is 'Корпус (споруда)';
comment on column core_address_fo.flatno is 'Квартира';

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create index i_core_address_fo on core_address_fo (request_id, rnk) tablespace brsmdli local compress 1';
exception
    when name_already_used then
         null;
end;
/

declare
    name_already_used exception;
    such_constraint_already_exists exception;
    pragma exception_init(name_already_used, -955);
    pragma exception_init(such_constraint_already_exists, -2275);
begin
    execute immediate 'alter table core_address_fo add constraint fk_core_address_ref_request foreign key (request_id) references nbu_core_data_request (id)';
exception
    when name_already_used or such_constraint_already_exists then
         null;
end;
/