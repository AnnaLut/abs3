declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin 
    execute immediate
    'create table core_finperformance_uo
     (
            request_id   number(38),
            rnk          number(38),
            sales        number(32),
            ebit         number(32),
            ebitda       number(32),
            totaldebt    number(32),
            kf           varchar2(6 char)
     )
     tablespace brsmdld
     partition by range (request_id) interval (1)
     ( partition initial_partition values less than (1) )';
exception
    when name_already_used then
         null;
end;
/

comment on table core_finperformance_uo is 'Розмір фінансових показників діяльності Боржника';
comment on column core_finperformance_uo.rnk is 'Регистрационный номер.';
comment on column core_finperformance_uo.sales is 'Показник сукупного обсягу реалізації  (SALES)';
comment on column core_finperformance_uo.ebit is 'Показник фінансового результату від операційної діяльності  (EBIT)';
comment on column core_finperformance_uo.ebitda is 'Показник фінансового результату від звичайної діяльності до оподаткування фінансових витрат і нарахування амортизації (EBITDA)';
comment on column core_finperformance_uo.totaldebt is 'Показник концентрації залучених коштів (TOTAL NET DEBT)';

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index ui_core_finperformance_uo on core_finperformance_uo (request_id, rnk) tablespace brsmdli local compress 1';
exception
    when name_already_used then
         null;
end;
/
