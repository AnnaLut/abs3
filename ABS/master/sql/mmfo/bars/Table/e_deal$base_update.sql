

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/E_DEAL$BASE_UPDATE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to E_DEAL$BASE_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''E_DEAL$BASE_UPDATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''E_DEAL$BASE_UPDATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''E_DEAL$BASE_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table E_DEAL$BASE_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.E_DEAL$BASE_UPDATE 
   (	IDUPD NUMBER(15,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER, 
	ND NUMBER(*,0), 
	RNK NUMBER(*,0), 
	SOS NUMBER(*,0), 
	CC_ID VARCHAR2(20), 
	SDATE DATE, 
	WDATE DATE, 
	USER_ID NUMBER(*,0), 
	SA NUMBER, 
	KF VARCHAR2(6), 
	ACC26 NUMBER(*,0), 
	ACC36 NUMBER(*,0), 
	ACCD NUMBER(*,0), 
	ACCP NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to E_DEAL$BASE_UPDATE ***
 exec bpa.alter_policies('E_DEAL$BASE_UPDATE');


COMMENT ON TABLE BARS.E_DEAL$BASE_UPDATE IS '';
COMMENT ON COLUMN BARS.E_DEAL$BASE_UPDATE.IDUPD IS 'ѕервичный ключ дл€ таблицы обновлени€';
COMMENT ON COLUMN BARS.E_DEAL$BASE_UPDATE.CHGACTION IS ' од обновлени€ (I/U/D)';
COMMENT ON COLUMN BARS.E_DEAL$BASE_UPDATE.EFFECTDATE IS 'Ѕанковска€ дата начала действи€ параметров';
COMMENT ON COLUMN BARS.E_DEAL$BASE_UPDATE.CHGDATE IS '—истемана€ дата обновлени€';
COMMENT ON COLUMN BARS.E_DEAL$BASE_UPDATE.DONEBY IS ' од пользовател€. кто внес обновлени€(если в течении дн€ было несколько обновлений - остаетс€ только последнее)';
COMMENT ON COLUMN BARS.E_DEAL$BASE_UPDATE.ND IS '';
COMMENT ON COLUMN BARS.E_DEAL$BASE_UPDATE.RNK IS '';
COMMENT ON COLUMN BARS.E_DEAL$BASE_UPDATE.SOS IS '';
COMMENT ON COLUMN BARS.E_DEAL$BASE_UPDATE.CC_ID IS '';
COMMENT ON COLUMN BARS.E_DEAL$BASE_UPDATE.SDATE IS '';
COMMENT ON COLUMN BARS.E_DEAL$BASE_UPDATE.WDATE IS '';
COMMENT ON COLUMN BARS.E_DEAL$BASE_UPDATE.USER_ID IS '';
COMMENT ON COLUMN BARS.E_DEAL$BASE_UPDATE.SA IS '';
COMMENT ON COLUMN BARS.E_DEAL$BASE_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.E_DEAL$BASE_UPDATE.ACC26 IS '';
COMMENT ON COLUMN BARS.E_DEAL$BASE_UPDATE.ACC36 IS '';
COMMENT ON COLUMN BARS.E_DEAL$BASE_UPDATE.ACCD IS '';
COMMENT ON COLUMN BARS.E_DEAL$BASE_UPDATE.ACCP IS '';




PROMPT *** Create  constraint PK_EDEALUPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_DEAL$BASE_UPDATE ADD CONSTRAINT PK_EDEALUPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005548 ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_DEAL$BASE_UPDATE MODIFY (ND NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005549 ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_DEAL$BASE_UPDATE MODIFY (RNK NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005550 ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_DEAL$BASE_UPDATE MODIFY (KF NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005551 ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_DEAL$BASE_UPDATE MODIFY (ACC26 NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_EDEALUPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EDEALUPDATE ON BARS.E_DEAL$BASE_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_EDEALUPDATE_EFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_EDEALUPDATE_EFFDAT ON BARS.E_DEAL$BASE_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_EDEALUPDATE_ND ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_EDEALUPDATE_ND ON BARS.E_DEAL$BASE_UPDATE (ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  E_DEAL$BASE_UPDATE ***
grant SELECT                                                                 on E_DEAL$BASE_UPDATE to BARSREADER_ROLE;
grant SELECT                                                                 on E_DEAL$BASE_UPDATE to BARSUPL;
grant SELECT                                                                 on E_DEAL$BASE_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on E_DEAL$BASE_UPDATE to BARS_DM;
grant SELECT                                                                 on E_DEAL$BASE_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/E_DEAL$BASE_UPDATE.sql =========*** En
PROMPT ===================================================================================== 
