

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_ACCP_UPDATE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_ACCP_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_ACCP_UPDATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_ACCP_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CC_ACCP_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_ACCP_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_ACCP_UPDATE 
   (	IDUPD NUMBER(15,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER, 
	ACC NUMBER(38,0), 
	ACCS NUMBER(38,0), 
	ND NUMBER(38,0), 
	PR_12 NUMBER(*,0), 
	IDZ NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT NULL, 
	MPAWN NUMBER, 
	PAWN NUMBER, 
	RNK NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_ACCP_UPDATE ***
 exec bpa.alter_policies('CC_ACCP_UPDATE');


COMMENT ON TABLE BARS.CC_ACCP_UPDATE IS '';
COMMENT ON COLUMN BARS.CC_ACCP_UPDATE.IDUPD IS 'ѕервичный ключ дл€ таблицы обновлени€';
COMMENT ON COLUMN BARS.CC_ACCP_UPDATE.CHGACTION IS ' од обновлени€ (I/U/D)';
COMMENT ON COLUMN BARS.CC_ACCP_UPDATE.EFFECTDATE IS 'Ѕанковска€ дата начала действи€ параметров';
COMMENT ON COLUMN BARS.CC_ACCP_UPDATE.CHGDATE IS '—истемана€ дата обновлени€';
COMMENT ON COLUMN BARS.CC_ACCP_UPDATE.DONEBY IS ' од пользовател€. кто внес обновлени€(если в течении дн€ было несколько обновлений - остаетс€ только последнее)';
COMMENT ON COLUMN BARS.CC_ACCP_UPDATE.ACC IS '';
COMMENT ON COLUMN BARS.CC_ACCP_UPDATE.ACCS IS '';
COMMENT ON COLUMN BARS.CC_ACCP_UPDATE.ND IS '';
COMMENT ON COLUMN BARS.CC_ACCP_UPDATE.PR_12 IS '';
COMMENT ON COLUMN BARS.CC_ACCP_UPDATE.IDZ IS '';
COMMENT ON COLUMN BARS.CC_ACCP_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.CC_ACCP_UPDATE.MPAWN IS '';
COMMENT ON COLUMN BARS.CC_ACCP_UPDATE.PAWN IS '';
COMMENT ON COLUMN BARS.CC_ACCP_UPDATE.RNK IS '';




PROMPT *** Create  constraint SYS_C008325 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ACCP_UPDATE MODIFY (ACC NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008326 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ACCP_UPDATE MODIFY (ACCS NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008327 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ACCP_UPDATE MODIFY (KF NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CCACCP_UPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ACCP_UPDATE ADD CONSTRAINT PK_CCACCP_UPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCACCP_UPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCACCP_UPDATE ON BARS.CC_ACCP_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CCACCP_UPDATEEFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CCACCP_UPDATEEFFDAT ON BARS.CC_ACCP_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CCACCP_UPDATEPK ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CCACCP_UPDATEPK ON BARS.CC_ACCP_UPDATE (ACC, ACCS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CCACCP_UPDACCS ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CCACCP_UPDACCS ON BARS.CC_ACCP_UPDATE (ACCS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_ACCP_UPDATE ***
grant SELECT                                                                 on CC_ACCP_UPDATE  to BARSUPL;
grant SELECT                                                                 on CC_ACCP_UPDATE  to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_ACCP_UPDATE.sql =========*** End **
PROMPT ===================================================================================== 
