prompt table w4_imp_acc_to_close
begin
    bpa.alter_policy_info('W4_IMP_ACC_TO_CLOSE', 'WHOLE', null, null, null, null);
    bpa.alter_policy_info('W4_IMP_ACC_TO_CLOSE', 'FILIAL', null, null, null, null);
end;
/
begin
    execute immediate q'[
create table w4_imp_acc_to_close
(
exp_id number,
KF varchar2(6),
NMKK varchar2(38),
nls varchar2(15),
kv number(3),
pdat date default sysdate,
branch varchar2(30),
rnk number,
dazs date,
ost number,
blk number(3),
dapp date,
dpt_binding number(1),
counter number default 1,
status number(1) default 0,
nls_abs varchar2(15),
constraint XPK_W4_IMP_ACC_TO_CLOSE primary key (exp_id, kf, nls, kv) using index tablespace brsdyni
)
partition by list (exp_id) subpartition by list (kf)
SUBPARTITION TEMPLATE
         (SUBPARTITION KF_300465 VALUES ('300465'),
            SUBPARTITION KF_302076 VALUES ('302076'),
            SUBPARTITION KF_303398 VALUES ('303398'),
            SUBPARTITION KF_304665 VALUES ('304665'),
            SUBPARTITION KF_305482 VALUES ('305482'),
            SUBPARTITION KF_311647 VALUES ('311647'),
            SUBPARTITION KF_312356 VALUES ('312356'),
            SUBPARTITION KF_313957 VALUES ('313957'),
            SUBPARTITION KF_315784 VALUES ('315784'),
            SUBPARTITION KF_322669 VALUES ('322669'),
            SUBPARTITION KF_323475 VALUES ('323475'),
            SUBPARTITION KF_324805 VALUES ('324805'),
            SUBPARTITION KF_325796 VALUES ('325796'),
            SUBPARTITION KF_326461 VALUES ('326461'),
            SUBPARTITION KF_328845 VALUES ('328845'),
            SUBPARTITION KF_331467 VALUES ('331467'),
            SUBPARTITION KF_333368 VALUES ('333368'),
            SUBPARTITION KF_335106 VALUES ('335106'),
            SUBPARTITION KF_336503 VALUES ('336503'),
            SUBPARTITION KF_337568 VALUES ('337568'),
            SUBPARTITION KF_338545 VALUES ('338545'),
            SUBPARTITION KF_351823 VALUES ('351823'),
            SUBPARTITION KF_352457 VALUES ('352457'),
            SUBPARTITION KF_353553 VALUES ('353553'),
            SUBPARTITION KF_354507 VALUES ('354507'),
            SUBPARTITION KF_356334 VALUES ('356334')
          )
(partition p_def values (0))
tablespace brsdynd
]';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
prompt rename ready_to_transfer to status
begin
    execute immediate 'alter table w4_imp_acc_to_close rename column READY_TO_TRANSFER to STATUS';
exception
    when others then
        if sqlcode = -957 then null; else raise; end if;
end;
/

begin
    execute immediate 'alter table w4_imp_acc_to_close rename column nlsalt to nls_abs';
exception
    when others then
        if sqlcode = -957 then null; else raise; end if;
end;
/
comment on table w4_imp_acc_to_close is 'Список подготовленных к закрытию счетов от w4';
comment on column w4_imp_acc_to_close.exp_id is 'ИД экспорта, инкремент';
comment on column w4_imp_acc_to_close.kf is 'Код филиала';
comment on column w4_imp_acc_to_close.nmkk is 'Краткое наименование клиента';
comment on column w4_imp_acc_to_close.nls is 'Номер лицевого счета';
comment on column w4_imp_acc_to_close.kv is 'Валюта';
comment on column w4_imp_acc_to_close.pdat is 'Системная дата получения записи';
comment on column w4_imp_acc_to_close.branch is 'Отделение счета';
comment on column w4_imp_acc_to_close.rnk is 'РНК';
comment on column w4_imp_acc_to_close.dazs is 'Дата закрытия счета';
comment on column w4_imp_acc_to_close.ost is 'Остаток (ostb/ostc)';
comment on column w4_imp_acc_to_close.blk is 'Код блокировки';
comment on column w4_imp_acc_to_close.dapp is 'Дата последнего движения';
comment on column w4_imp_acc_to_close.dpt_binding is 'Флаг привязки к депозиту';
comment on column w4_imp_acc_to_close.counter is 'Счетчик (сколько раз приходила запись из w4)';
comment on column w4_imp_acc_to_close.status is 'Статус (0 - новый, 1 - готов к передаче, -1 - счет не найден)';
comment on column w4_imp_acc_to_close.nls_abs is 'accounts.nls найденного счета';

grant insert, select on w4_imp_acc_to_close to IBMESB;
grant select on w4_imp_acc_to_close to bars_access_defrole;