PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EAD_GENSEQUENCEKF.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EAD_GENSEQUENCEKF ***

execute bpa.alter_policy_info( 'EAD_GenSequenceKF', 'WHOLE' , null, null, null, null ); 
execute bpa.alter_policy_info( 'EAD_GenSequenceKF', 'FILIAL', null, null, null, null );


PROMPT *** Create  table OPERLIST_ACSPUB ***
begin 
  execute immediate 'create table EAD_GENSEQUENCEKF
(
  id          NVARCHAR2(2),
  sequence    VARCHAR2(255),
  kf          VARCHAR2(30),
  date_update DATE
)
tablespace BRSDYND
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
  
begin 
  execute immediate 'alter table EAD_GENSEQUENCEKF modify id INTEGER';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
  
-- Add comments to the table 
comment on table EAD_GENSEQUENCEKF
  is 'Справочник Сиквенсов в разрезе МФО';
-- Add comments to the columns 
comment on column EAD_GENSEQUENCEKF.id
  is 'Код из справочника';
comment on column EAD_GENSEQUENCEKF.sequence
  is 'Наименование сиквенса';
comment on column EAD_GENSEQUENCEKF.kf
  is 'Бранч';
comment on column EAD_GENSEQUENCEKF.date_update
  is 'Дата редактирования';
  
  
 PROMPT *** Create  index PK_OPLISTACSPUB ***
begin   
 execute immediate 'alter table EAD_GENSEQUENCEKF
  add constraint UNQ_EAD_GENSEQUENCE unique (KF)
  using index 
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
  )';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
 
/
begin   
 execute immediate 'alter table EAD_GENSEQUENCEKF
  add constraint FK_EAD_GENSEQUENCEKF foreign key (KF)
  references BANKS_RU (MFO)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end;

/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EAD_GENSEQUENCEKF.sql =========*** End *** =
PROMPT ===================================================================================== 