prompt table bill_report
begin
    execute immediate '
create table bill_report
(
report_id number,
report_name varchar2(256) not null,
frx_file_name varchar2(64),
description varchar2(512),
active number(1),
constraint XPK_BILL_REPORT primary key (report_id),
constraint C_ACTIVE check(active in (0, 1))
)';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
comment on table bill_report is 'Перечень отчетов (справочник)';
comment on column bill_report.report_id is 'ИД';
comment on column bill_report.report_name is 'Название отчета';
comment on column bill_report.frx_file_name is 'Имя файла шаблона';
comment on column bill_report.description is 'Описание';