

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_DEAL_UPDATE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_DEAL_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_DEAL_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CC_DEAL_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_DEAL_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_DEAL_UPDATE 
   (	IDUPD NUMBER(15,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER, 
	ND NUMBER(10,0), 
	SOS NUMBER(*,0), 
	CC_ID VARCHAR2(50), 
	SDATE DATE, 
	WDATE DATE, 
	RNK NUMBER(*,0), 
	VIDD NUMBER(*,0), 
	LIMIT NUMBER(24,4), 
	KPROLOG NUMBER(*,0), 
	USER_ID NUMBER(*,0), 
	OBS NUMBER(*,0), 
	BRANCH VARCHAR2(30), 
	KF VARCHAR2(6), 
	IR NUMBER, 
	PROD VARCHAR2(100), 
	SDOG NUMBER(24,2), 
	SKARB_ID VARCHAR2(40), 
	FIN NUMBER(*,0), 
	NDI NUMBER(*,0), 
	FIN23 NUMBER(*,0), 
	OBS23 NUMBER(*,0), 
	KAT23 NUMBER(*,0), 
	K23 NUMBER, 
	KOL_SP NUMBER, 
	S250 VARCHAR2(1), 
	GRP NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_DEAL_UPDATE ***
 exec bpa.alter_policies('CC_DEAL_UPDATE');


COMMENT ON TABLE BARS.CC_DEAL_UPDATE IS '';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.KAT23 IS '';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.K23 IS '';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.KOL_SP IS 'К-во дней просрочки по договору';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.S250 IS 'Портфельный метод (8)';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.GRP IS 'група активу портфельного методу';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.IDUPD IS 'Первичный ключ для таблицы обновления';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.CHGACTION IS 'Код обновления (I/U/D)';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.EFFECTDATE IS 'Банковская дата начала действия параметров';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.CHGDATE IS 'Системаная дата обновления';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.DONEBY IS 'Код пользователя. кто внес обновления(если в течении дня было несколько обновлений - остается только последнее)';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.ND IS '';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.SOS IS '';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.CC_ID IS '';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.SDATE IS '';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.WDATE IS '';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.RNK IS '';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.VIDD IS '';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.LIMIT IS '';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.KPROLOG IS '';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.USER_ID IS '';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.OBS IS '';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.BRANCH IS '';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.IR IS '';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.PROD IS '';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.SDOG IS '';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.SKARB_ID IS '';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.FIN IS '';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.NDI IS '';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.FIN23 IS '';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.OBS23 IS '';




PROMPT *** Create  constraint PK_CCDEAL_UPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DEAL_UPDATE ADD CONSTRAINT PK_CCDEAL_UPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001955659 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DEAL_UPDATE MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001955658 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DEAL_UPDATE MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001955657 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DEAL_UPDATE MODIFY (USER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001955656 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DEAL_UPDATE MODIFY (VIDD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001955655 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DEAL_UPDATE MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001955654 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DEAL_UPDATE MODIFY (SOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001955653 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DEAL_UPDATE MODIFY (ND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCDEAL_UPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCDEAL_UPDATE ON BARS.CC_DEAL_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CCDEAL_UPDATEPK ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CCDEAL_UPDATEPK ON BARS.CC_DEAL_UPDATE (ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


prompt create index XAI_CCDEAL_UPDATEEFFDAT
begin
    execute immediate '
    create index BARS.XAI_CCDEAL_UPDATEEFFDAT on BARS.CC_DEAL_UPDATE (EFFECTDATE)
      tablespace BRSMDLI
      pctfree 10
      initrans 2
      maxtrans 255
      storage
      (
        initial 64K
        next 64K
        minextents 1
        maxextents unlimited
      )
      compute statistics';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/


PROMPT *** Create  grants  CC_DEAL_UPDATE ***
grant SELECT                                                                 on CC_DEAL_UPDATE  to BARSUPL;
grant SELECT                                                                 on CC_DEAL_UPDATE  to BARS_SUP;
grant select on bars.cc_deal_update to bars_dm;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_DEAL_UPDATE.sql =========*** End **
PROMPT ===================================================================================== 
