prompt table bill_report_param
begin
    execute immediate '
create table bill_report_param
(
param_id number,
report_id number,
param_code varchar2(256) not null,
param_name varchar2(256) not null,
param_type varchar2(32),
nullable number(1) default 0,
constraint XPK_BILL_REPORT_PARAM primary key (param_id),
constraint FK_BILL_REPORT_PARAM_REPORT foreign key (report_id) references BILL_REPORT (report_id),
constraint C_NULLABLE_10 check (nullable in (1, 0))
)';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
comment on table bill_report_param is 'Перечень параметров отчетов (справочник)';
comment on column bill_report_param.param_id is 'ИД параметра';
comment on column bill_report_param.report_id is 'ИД отчета';
comment on column bill_report_param.param_code is 'Код параметра';
comment on column bill_report_param.param_name is 'Отображаемое название параметра';
comment on column bill_report_param.param_type is 'Тип параметра';
comment on column bill_report_param.nullable is '(1/0) допустимость NULL-значения';
