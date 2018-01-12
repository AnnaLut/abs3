prompt table CCK_R011
begin
    bpa.alter_policy_info('CCK_R011', 'WHOLE', null, null, null, null);
    bpa.alter_policy_info('CCK_R011', 'FILIAL', null, null, null, null);
end;
/
begin
    execute immediate 'create table cck_r011(
                        nbs varchar2(4), 
                        r011 varchar2(1),
                        constraint XPK_CCK_R011 primary key(nbs)
                        ) organization index tablespace brssmli ';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
grant select, insert, update, delete on bars.cck_r011 to bars_access_defrole;

comment on table bars.cck_r011 is 'Справочник спецпараметра R011 для кредитов (TIP = SS, SDI, SN)';
comment on column bars.cck_r011.nbs is 'Баланс. счет';
comment on column bars.cck_r011.r011 is 'Значение спецпараметра';