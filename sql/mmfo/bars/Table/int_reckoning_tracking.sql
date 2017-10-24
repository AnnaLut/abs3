begin
    bars_policy_adm.alter_policy_info('INT_RECKONING_TRACKING', 'WHOLE', null, 'E', 'E', 'E');
    bars_policy_adm.alter_policy_info('INT_RECKONING_TRACKING', 'FILIAL', null, null, null, null);
    bars_policy_adm.alter_policy_info('INT_RECKONING_TRACKING', 'CENTER', null, null, null, null);
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table int_reckoning_tracking
     (
            id number(38) not null,
            reckoning_id number(38) not null,
            state_id number(5) not null,
            tracking_message varchar2(4000 byte),
            sys_time date not null,
            user_id number(38) not null
     )
     tablespace brsbigd';
exception
    when name_already_used then null;
end;
/

declare
    name_already_used exception;
    table_can_have_only_one_pk exception;
    pragma exception_init(name_already_used, -955);
    pragma exception_init(table_can_have_only_one_pk, -2260);
begin
    execute immediate 'alter table int_reckoning_tracking add constraint pk_int_reckoning_tracking primary key (id) using index tablespace brsbigi';
exception
    when name_already_used or table_can_have_only_one_pk then null;
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create index i_int_reckon_track_reckon_id on int_reckoning_tracking (reckoning_id) tablespace brsbigi';
exception
    when name_already_used then null;
end;
/

declare
    constraint_name_already_used exception;
    reference_already_exists exception;
    pragma exception_init(constraint_name_already_used, -1451);
    pragma exception_init(reference_already_exists, -2275);
begin
    execute immediate 'alter table int_reckoning_tracking add constraint fk_reck_track_ref_reckoning foreign key (reckoning_id) references int_reckonings (id)';
exception
    when constraint_name_already_used or reference_already_exists then null;
end;
/

comment on table int_reckoning_tracking is 'Історія обробки розрахунків відсотків';

comment on column int_reckoning_tracking.id               is 'Ідентифікатор запису про активність по розрахунку відсотків';
comment on column int_reckoning_tracking.reckoning_id     is 'Ідентифікатор розрахунку відсотків, по якому відбувалася активність';
comment on column int_reckoning_tracking.state_id         is 'Стан розрахунку відсотків, отриманий ним після внесення змін';
comment on column int_reckoning_tracking.tracking_message is 'Текстовий коментар, що супроводжує внесення змін до розрахунку';
comment on column int_reckoning_tracking.sys_time         is 'Системний час внесення змін';
comment on column int_reckoning_tracking.user_id          is 'Користувач, що виконував дії';

