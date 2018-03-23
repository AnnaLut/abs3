PROMPT *** Create  table DEPOSIT_PLT ***
begin 
  execute immediate '
  CREATE TABLE BARS_DM.DEPOSIT_PLT 
  (	PER_ID NUMBER, 
  DEPOSIT_ID NUMBER, 
  BRANCH VARCHAR2(30), 
  KF VARCHAR2(12), 
  RNK NUMBER(38,0), 
  ND VARCHAR2(35), 
  DAT_BEGIN DATE, 
  DAT_END DATE, 
  NLS VARCHAR2(15), 
  VIDD NUMBER(38,0), 
  TERM NUMBER(*,0), 
  SDOG NUMBER, 
  MASSA NUMBER, 
  KV NUMBER(3,0), 
  INTRATE NUMBER, 
  SDOG_BEGIN NUMBER, 
  LAST_ADD_DATE DATE, 
  LAST_ADD_SUMA NUMBER, 
  OSTC NUMBER, 
  SUMA_PROC NUMBER, 
  SUMA_PROC_PLAN NUMBER, 
  DPT_STATUS NUMBER(1,0), 
  SUMA_PROC_PAYOFF NUMBER, 
  DATE_PROC_PAYOFF DATE, 
  DATE_DEP_PAYOFF DATE, 
  DATZ DATE, 
  DAZS DATE, 
  BLKD NUMBER(3,0), 
  BLKK NUMBER(3,0), 
  CNT_DUBL NUMBER, 
  ARCHDOC_ID NUMBER, 
  NCASH VARCHAR2(128), 
  NAME_D VARCHAR2(128), 
  OKPO_D VARCHAR2(14), 
  NLS_D VARCHAR2(15), 
  MFO_D VARCHAR2(12), 
  NAME_P VARCHAR2(128), 
  OKPO_P VARCHAR2(14), 
  NLSB VARCHAR2(15), 
  MFOB VARCHAR2(12), 
  NLSP VARCHAR2(15), 
  ROSP_M NUMBER(1,0), 
  MAL NUMBER(1,0), 
  BEN NUMBER(1,0), 
  VIDD_NAME VARCHAR2(50),
  WB CHAR(1),
  ob22 varchar(2),
  nms varchar(70)
	) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin
    execute immediate 'alter table bars_dm.deposit_plt add wb char(1)';
exception
    when others then
        if sqlcode = -1430 then null; else raise; end if;
end;
/

prompt add ob22, nms
begin
    execute immediate q'[alter table bars_dm.deposit_plt add ob22 varchar2(2)]';
exception
    when others then
        if sqlcode = -1430 then null; else raise; end if;
end;
/
begin
    execute immediate q'[alter table bars_dm.deposit_plt add nms varchar2(70)]';
exception
    when others then
        if sqlcode = -1430 then null; else raise; end if;
end;
/

PROMPT *** Create  constraint SYS_C003232546 ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.DEPOSIT_PLT MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint SYS_C003232545 ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.DEPOSIT_PLT MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint SYS_C003232544 ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.DEPOSIT_PLT MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint SYS_C003232543 ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.DEPOSIT_PLT MODIFY (PER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  DEPOSIT_PLT ***
grant SELECT                                                                 on DEPOSIT_PLT     to BARSUPL;