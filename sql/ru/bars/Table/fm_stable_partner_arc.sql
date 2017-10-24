begin
  bpa.alter_policy_info('FM_STABLE_PARTNER_ARC', 'WHOLE', null, null, null, null); 
  bpa.alter_policy_info('FM_STABLE_PARTNER_ARC', 'FILIAL', null, null, null, null);
end;
/
-- Create table
begin
  execute immediate 'create table FM_STABLE_PARTNER_ARC
(
  dat          DATE,
  rnk          VARCHAR2(30),
  partner_list VARCHAR2(4000),
  kf		VARCHAR2(6)
)
tablespace BRSBIGD
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 4M
    next 4M
    minextents 1
    maxextents unlimited
    pctincrease 0
  )';
exception when others then 
if sqlcode = -955 then null; else raise; end if;
end;
/

begin
  execute immediate 'create unique index I_FM_STPARTNERARC on FM_STABLE_PARTNER_ARC (DAT, RNK, KF)
  tablespace BRSDYND
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
    pctincrease 0
  )';
exception when others then 
if sqlcode = -955 then null; else raise; end if;
end;
/

grant select on FM_STABLE_PARTNER_ARC to BARS_ACCESS_DEFROLE;
grant select on FM_STABLE_PARTNER_ARC to BARS_DM;
grant select on FM_STABLE_PARTNER_ARC to START1;
/
