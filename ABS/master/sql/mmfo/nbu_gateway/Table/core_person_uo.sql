declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table core_person_uo
     (
            request_id              number(38),
            rnk                     number(38),
            nameur                  varchar2(254 char),
            isrez                   varchar2(5 char),
            codedrpou               varchar2(20 char),
            registryday             date,
            numberregistry          varchar2(32 char),
            k110                    varchar2(5 char),
            ec_year                 date,
            countrycodnerez         varchar2(3 char),
            ismember                varchar2(5 char),
            iscontroller            varchar2(5 char),
            ispartner               varchar2(5 char),
            isaudit                 varchar2(5 char),
            k060                    varchar2(2 char),
            company_code            varchar2(30 char),
            default_company_kf      varchar2(6 char),
            default_company_id      number(38),
            company_object_id       number(38),
            status                  varchar2(30 char),
            status_message          varchar2(4000 byte),
            kf                      varchar2(6 char)
     )
     tablespace brsmdld
     partition by range (request_id) interval (1)
     ( partition initial_partition values less than (1) )';
exception
    when name_already_used then
         null;
end;
/

begin
    execute immediate
    'alter table CORE_PERSON_UO add iskr number';
exception
    when others then
         null;
end;
/

begin
    execute immediate
    'alter table CORE_PERSON_UO add coddocum number';
exception
    when others then
         null;
end;
/

begin
    execute immediate
    'alter table CORE_PERSON_UO add k020 varchar2(20)';
exception
    when others then
         null;
end;
/

comment on table core_person_uo is 'Боржник ЮО';
comment on column core_person_uo.rnk is 'Регистрационный номер.';
comment on column core_person_uo.nameur is 'Найменування Боржника';
comment on column core_person_uo.isrez is 'Резидентність особи';
comment on column core_person_uo.codedrpou is 'Код ЄДРПОУ Боржника';
comment on column core_person_uo.registryday is 'Дата державної реєстрації';
comment on column core_person_uo.numberregistry is 'Номер державної реєстрації';
comment on column core_person_uo.k110 is 'Вид економічної діяльності';
comment on column core_person_uo.ec_year is 'Період';
comment on column core_person_uo.countrycodnerez is 'Країна реєстрації Боржника – нерезидента';
comment on column core_person_uo.ismember is 'Приналежність Боржника до групи юридичних осіб';
comment on column core_person_uo.iscontroller is 'Статус участі Боржника в групі';
comment on column core_person_uo.ispartner is 'Факт приналежності Боржника до групи пов’язаних контрагентів';
comment on column core_person_uo.isaudit  is 'Факт проходження аудиту фінансової звітності';
comment on column core_person_uo.k060 is 'Тип пов’язаної з банком особи';
comment on column core_person_uo.status is 'Статус';

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index ui_core_person_uo on core_person_uo (request_id, rnk) tablespace brsmdli local compress 1';
exception
    when name_already_used then
         null;
end;
/

begin
	execute immediate'alter table core_person_uo add k020 VARCHAR2(20)';
exception
 when others then if sqlcode=-955 then null; end if;
end;
/

begin
	execute immediate'alter table core_person_uo add codDocum number(2)';
exception
 when others then if sqlcode=-955 then null; end if;
end;
/

begin
	execute immediate'alter table core_person_uo add isKr number(1)';
exception
 when others then if sqlcode=-955 then null; end if;
end;
/