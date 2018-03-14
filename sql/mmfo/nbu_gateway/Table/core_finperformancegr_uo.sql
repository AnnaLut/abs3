declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table core_finperformancegr_uo
     (
            request_id  number(38),
            rnk         number(38),
            salesgr     number(32),
            ebitgr      number(32),
            ebitdagr    number(32),
            totaldebtgr number(32),
            classgr     varchar2(3),
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

comment on table core_finperformancegr_uo is 'Розмір фінансових показників діяльності групи юридичних осіб, що знаходяться під спільним контролем';
comment on column core_finperformancegr_uo.rnk is 'Регистрационный номер.';
comment on column core_finperformancegr_uo.salesgr is 'Показник сукупного обсягу реалізації  (SALES)';
comment on column core_finperformancegr_uo.ebitgr is 'Показник фінансового результату від операційної діяльності  (EBIT)';
comment on column core_finperformancegr_uo.ebitdagr is 'Показник фінансового результату від звичайної діяльності до оподаткування фінансових витрат і нарахування амортизації (EBITDA)';
comment on column core_finperformancegr_uo.totaldebtgr is 'Показник концентрації залучених коштів (TOTAL NET DEBT)';
comment on column core_finperformancegr_uo.classgr is 'Клас групи';

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index ui_core_finperformancegr_uo on core_finperformancegr_uo (request_id, rnk) tablespace brsmdli local compress 1';
exception
    when name_already_used then
         null;
end;
/

