prompt create table BARS_INTGR.INTGR_STATS
begin
    execute immediate q'[
create table BARS_INTGR.INTGR_STATS
(
  id           NUMBER not null,
  changenumber NUMBER,
  object_name  VARCHAR2(32),
  start_time   DATE,
  stop_time    DATE,
  rows_ok      NUMBER,
  rows_err     NUMBER,
  status       VARCHAR2(15)
)
tablespace BRSMDLD
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 128K
    minextents 1
    maxextents unlimited
  )
]';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
prompt create index I_INTGR_STATS_CHGN
begin
    execute immediate q'[
create index BARS_INTGR.I_INTGR_STATS_CHGN on BARS_INTGR.INTGR_STATS (CHANGENUMBER)
  tablespace BRSMDLI
]';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
prompt create PK / index
begin
    execute immediate q'[
alter table BARS_INTGR.INTGR_STATS
  add constraint PK_STATS primary key (ID)
  using index 
  tablespace BRSMDLI
]';
exception
    when others then
        if sqlcode in (-955, -2260) then null; else raise; end if;
end;
/
