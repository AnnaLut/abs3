prompt table extracts_detail
begin
    execute immediate q'[
create table extracts_detail
(
extract_id number,
exp_id number,
ext_status number,
constraint xpk_extracts_detail primary key (extract_id, exp_id),
constraint r_extracts_detail_extracts foreign key (extract_id) references extracts (extract_number_id)
)
organization index]';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/

comment on table extracts_detail is 'Состояние выдержки (получатели) на момент отправки';
comment on column extracts_detail.extract_id is 'Номер выдержки';
comment on column extracts_detail.exp_id is 'Внешний ид получателя';
comment on column extracts_detail.ext_status is 'Внешний статус получателя';