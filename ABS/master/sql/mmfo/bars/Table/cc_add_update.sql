

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_ADD_UPDATE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_ADD_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_ADD_UPDATE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_ADD_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CC_ADD_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_ADD_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_ADD_UPDATE 
   (	IDUPD NUMBER(15,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER, 
	ND NUMBER(38,0), 
	ADDS NUMBER(*,0), 
	AIM NUMBER(*,0), 
	S NUMBER(24,4), 
	KV NUMBER(*,0), 
	BDATE DATE, 
	WDATE DATE, 
	ACCS NUMBER(38,0), 
	ACCP NUMBER(38,0), 
	SOUR NUMBER(*,0), 
	ACCKRED VARCHAR2(34), 
	MFOKRED VARCHAR2(12), 
	FREQ NUMBER(*,0), 
	PDATE DATE, 
	REFV NUMBER(*,0), 
	REFP NUMBER(*,0), 
	ACCPERC VARCHAR2(34), 
	MFOPERC VARCHAR2(12), 
	SWI_BIC CHAR(11), 
	SWI_ACC VARCHAR2(34), 
	SWI_REF NUMBER(38,0), 
	SWO_BIC CHAR(11), 
	SWO_ACC VARCHAR2(34), 
	SWO_REF NUMBER(38,0), 
	INT_AMOUNT NUMBER(24,4), 
	ALT_PARTYB VARCHAR2(250), 
	INTERM_B VARCHAR2(250), 
	INT_PARTYA VARCHAR2(250), 
	INT_PARTYB VARCHAR2(250), 
	INT_INTERMA VARCHAR2(250), 
	INT_INTERMB VARCHAR2(250), 
	SSUDA NUMBER(12,0), 
	KF VARCHAR2(6) DEFAULT NULL, 
	OKPOKRED VARCHAR2(14), 
	NAMKRED VARCHAR2(38), 
	NAZNKRED VARCHAR2(160), 
	NLS_1819 VARCHAR2(14), 
	FIELD_58D VARCHAR2(250)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_ADD_UPDATE ***
 exec bpa.alter_policies('CC_ADD_UPDATE');


COMMENT ON TABLE BARS.CC_ADD_UPDATE IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.IDUPD IS 'Первичный ключ для таблицы обновления';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.CHGACTION IS 'Код обновления (I/U/D)';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.EFFECTDATE IS 'Банковская дата начала действия параметров';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.CHGDATE IS 'Системаная дата обновления';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.DONEBY IS 'Код пользователя. кто внес обновления(если в течении дня было несколько обновлений - остается только последнее)';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.ND IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.ADDS IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.AIM IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.S IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.KV IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.BDATE IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.WDATE IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.ACCS IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.ACCP IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.SOUR IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.ACCKRED IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.MFOKRED IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.FREQ IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.PDATE IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.REFV IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.REFP IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.ACCPERC IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.MFOPERC IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.SWI_BIC IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.SWI_ACC IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.SWI_REF IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.SWO_BIC IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.SWO_ACC IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.SWO_REF IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.INT_AMOUNT IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.ALT_PARTYB IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.INTERM_B IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.INT_PARTYA IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.INT_PARTYB IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.INT_INTERMA IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.INT_INTERMB IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.SSUDA IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.OKPOKRED IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.NAMKRED IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.NAZNKRED IS '';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.NLS_1819 IS 'Транзит 1819 для кредитных ресурсов';
COMMENT ON COLUMN BARS.CC_ADD_UPDATE.FIELD_58D IS 'Поле 58D для рублей';




PROMPT *** Create  constraint PK_CCADD_UPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD_UPDATE ADD CONSTRAINT PK_CCADD_UPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007571 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD_UPDATE MODIFY (ND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007572 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD_UPDATE MODIFY (ADDS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007573 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD_UPDATE MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCADD_UPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCADD_UPDATE ON BARS.CC_ADD_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CCADD_UPDATEEFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CCADD_UPDATEEFFDAT ON BARS.CC_ADD_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CCADD_UPDATEPK ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CCADD_UPDATEPK ON BARS.CC_ADD_UPDATE (ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_ADD_UPDATE ***
grant SELECT                                                                 on CC_ADD_UPDATE   to BARSREADER_ROLE;
grant SELECT                                                                 on CC_ADD_UPDATE   to BARSUPL;
grant SELECT                                                                 on CC_ADD_UPDATE   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_ADD_UPDATE   to BARS_DM;
grant SELECT                                                                 on CC_ADD_UPDATE   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_ADD_UPDATE.sql =========*** End ***
PROMPT ===================================================================================== 
