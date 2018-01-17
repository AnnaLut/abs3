prompt table CCK_R013

begin
    bpa.alter_policy_info('CCK_R013', 'WHOLE', null, null, null, null);
    bpa.alter_policy_info('CCK_R013', 'FILIAL', null, null, null, null);
end;
/
begin
    execute immediate q'[create table cck_r013(
                        nbs varchar2(4),
                        ob22 varchar2(2) default '-',
                        r013 varchar2(1),
						module_specific varchar2(1) default 'Y',
                        constraint XPK_CCK_R013 primary key(nbs, ob22)
                        ) organization index tablespace brssmli ]';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
prompt add column module_specific
begin
    execute immediate q'[alter table cck_r013 add module_specific varchar2(1) default 'Y']';
exception
    when others then
        if sqlcode = -1430 then null; else raise; end if;
end;
/
grant select, insert, update, delete on bars.cck_r013 to bars_access_defrole;

comment on table bars.cck_r013 is 'Справочник спецпараметра R013 для кредитов (TIP = SS, SDI, SN)';
comment on column bars.cck_r013.nbs is 'Баланс. счет';
comment on column bars.cck_r013.ob22 is 'ob22 счета; "-" если не имеет значения';
comment on column bars.cck_r013.r013 is 'Значение спецпараметра';
comment on column bars.cck_r013.module_specific is 'Специфика модуля (N - не требует доп. расчетов)';