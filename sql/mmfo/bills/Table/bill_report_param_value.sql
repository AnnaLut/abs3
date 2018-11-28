prompt table bill_report_param_value
begin
    execute immediate '
create table bill_report_param_value
(
kf varchar2(6),
param_id number,
value_id number,
value varchar2(256),
constraint XPK_BILL_REPORT_PARAM_VALUE primary key (kf, param_id, value_id),
constraint R_PARAM_VALUE_PARAM foreign key (param_id) references BILL_REPORT_PARAM (param_id)
)';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
comment on table bill_report_param_value is 'Перечень значений параметров отчетов (справочник)';
comment on column bill_report_param_value.kf is 'Код филиала';
comment on column bill_report_param_value.param_id is 'ИД параметра';
comment on column bill_report_param_value.value_id is 'Относительный ИД значения';
comment on column bill_report_param_value.value is 'Значение параметра';
