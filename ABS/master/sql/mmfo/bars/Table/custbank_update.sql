

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTBANK_UPDATE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTBANK_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTBANK_UPDATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTBANK_UPDATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTBANK_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTBANK_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUSTBANK_UPDATE 
   (	IDUPD NUMBER(15,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER, 
	RNK NUMBER(38,0), 
	MFO VARCHAR2(12), 
	ALT_BIC CHAR(11), 
	BIC CHAR(11), 
	RATING VARCHAR2(5), 
	KOD_B NUMBER(5,0), 
	DAT_ND DATE, 
	RUK VARCHAR2(70), 
	TELR VARCHAR2(20), 
	BUH VARCHAR2(70), 
	TELB VARCHAR2(20), 
	NUM_ND VARCHAR2(20), 
	KF VARCHAR2(6) DEFAULT NULL
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUSTBANK_UPDATE ***
 exec bpa.alter_policies('CUSTBANK_UPDATE');


COMMENT ON TABLE BARS.CUSTBANK_UPDATE IS '';
COMMENT ON COLUMN BARS.CUSTBANK_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.CUSTBANK_UPDATE.IDUPD IS 'ѕервичный ключ дл€ таблицы обновлени€';
COMMENT ON COLUMN BARS.CUSTBANK_UPDATE.CHGACTION IS ' од обновлени€ (I/U/D)';
COMMENT ON COLUMN BARS.CUSTBANK_UPDATE.EFFECTDATE IS 'Ѕанковска€ дата начала действи€ параметров';
COMMENT ON COLUMN BARS.CUSTBANK_UPDATE.CHGDATE IS '—истемана€ дата обновлени€';
COMMENT ON COLUMN BARS.CUSTBANK_UPDATE.DONEBY IS ' од пользовател€. кто внес обновлени€(если в течении дн€ было несколько обновлений - остаетс€ только последнее)';
COMMENT ON COLUMN BARS.CUSTBANK_UPDATE.RNK IS '';
COMMENT ON COLUMN BARS.CUSTBANK_UPDATE.MFO IS '';
COMMENT ON COLUMN BARS.CUSTBANK_UPDATE.ALT_BIC IS '';
COMMENT ON COLUMN BARS.CUSTBANK_UPDATE.BIC IS '';
COMMENT ON COLUMN BARS.CUSTBANK_UPDATE.RATING IS '';
COMMENT ON COLUMN BARS.CUSTBANK_UPDATE.KOD_B IS '';
COMMENT ON COLUMN BARS.CUSTBANK_UPDATE.DAT_ND IS '';
COMMENT ON COLUMN BARS.CUSTBANK_UPDATE.RUK IS '';
COMMENT ON COLUMN BARS.CUSTBANK_UPDATE.TELR IS '';
COMMENT ON COLUMN BARS.CUSTBANK_UPDATE.BUH IS '';
COMMENT ON COLUMN BARS.CUSTBANK_UPDATE.TELB IS '';
COMMENT ON COLUMN BARS.CUSTBANK_UPDATE.NUM_ND IS '';




PROMPT *** Create  constraint CC_CUSTBANKUPDATE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTBANK_UPDATE MODIFY (KF CONSTRAINT CC_CUSTBANKUPDATE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTBANKUPDATE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTBANK_UPDATE ADD CONSTRAINT FK_CUSTBANKUPDATE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CUSTBANK_UPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTBANK_UPDATE ADD CONSTRAINT PK_CUSTBANK_UPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006376 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTBANK_UPDATE MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CUSTBANK_UPDATEPK ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CUSTBANK_UPDATEPK ON BARS.CUSTBANK_UPDATE (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CUSTBANK_UPDATEEFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CUSTBANK_UPDATEEFFDAT ON BARS.CUSTBANK_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTBANK_UPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTBANK_UPDATE ON BARS.CUSTBANK_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTBANK_UPDATE ***
grant SELECT                                                                 on CUSTBANK_UPDATE to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTBANK_UPDATE.sql =========*** End *
PROMPT ===================================================================================== 
