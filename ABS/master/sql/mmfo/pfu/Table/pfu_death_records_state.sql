


PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_DEATH_RECORD_STATE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_DEATH_RECORD_STATE ***
begin 
  execute immediate '
create table PFU.PFU_DEATH_RECORDS_STATE
(
  id   VARCHAR2(30) not null,
  name VARCHAR2(300)
)
tablespace BRSBIGD
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

comment on table PFU.PFU_DEATH_RECORDS_STATE is 'Описания статусов записей реестра по умершим';
comment on column PFU.PFU_DEATH_RECORDS_STATE.id is 'Код статуса';
comment on column PFU.PFU_DEATH_RECORDS_STATE.name is 'Наименование статуса';


PROMPT *** Create  constraint PK_PFU_DEATH_RECORDS ***
begin   
 execute immediate '
alter table PFU.PFU_DEATH_RECORDS_STATE
  add constraint PK_PFU_DEATH_RECORDS primary key (ID)
  using index 
  tablespace BRSBIGD
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_DEATH_RECORD_STATE.sql =========*** End *** =====
PROMPT ===================================================================================== 

