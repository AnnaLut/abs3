declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table core_ownerpp_uo
     (
            request_id  number(38),
            rnk         number(38),
            rnkb        number(38),
            lastname    varchar2(100),
            firstname   varchar2(100),
            middlename  varchar2(100),
            isrez       varchar(5),
            inn         varchar2(20),
            countrycod  varchar2(3),
            percent     number(9,6),
            kf          varchar2(6 char)
     )
     tablespace brsmdld
     partition by range (request_id) interval (1)
     ( partition initial_partition values less than (1) )';
exception
    when name_already_used then
         null;
end;
/

comment on table core_ownerpp_uo is 'Власники істотної участі – юридичні особи';
comment on column core_ownerpp_uo.rnk is 'Регистрационный номер.';
comment on column core_ownerpp_uo.rnkb is 'Рег.номер связанного клиента';
comment on column core_ownerpp_uo.lastname is 'Прізвище';
comment on column core_ownerpp_uo.firstname is 'Ім’я';
comment on column core_ownerpp_uo.middlename is 'По батькові';
comment on column core_ownerpp_uo.isrez is 'Резидентність особи';
comment on column core_ownerpp_uo.inn is 'Ідентифікацій-ний код';
comment on column core_ownerpp_uo.countrycod is 'Код країни';
comment on column core_ownerpp_uo.percent is 'Частка власника істотної участі';

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create index i_core_ownerpp_uo on core_ownerpp_uo (request_id, rnk) tablespace brsmdli local compress 1';
exception
    when name_already_used then
         null;
end;
/
