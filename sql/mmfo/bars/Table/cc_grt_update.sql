

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_GRT_UPDATE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_GRT_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_GRT_UPDATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_GRT_UPDATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CC_GRT_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_GRT_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_GRT_UPDATE 
   (	IDUPD NUMBER(15,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER, 
	ND NUMBER(38,0), 
	GRT_DEAL_ID NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_GRT_UPDATE ***
 exec bpa.alter_policies('CC_GRT_UPDATE');


COMMENT ON TABLE BARS.CC_GRT_UPDATE IS '';
COMMENT ON COLUMN BARS.CC_GRT_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.CC_GRT_UPDATE.IDUPD IS 'ѕервичный ключ дл€ таблицы обновлени€';
COMMENT ON COLUMN BARS.CC_GRT_UPDATE.CHGACTION IS ' од обновлени€ (I/U/D)';
COMMENT ON COLUMN BARS.CC_GRT_UPDATE.EFFECTDATE IS 'Ѕанковска€ дата начала действи€ параметров';
COMMENT ON COLUMN BARS.CC_GRT_UPDATE.CHGDATE IS '—истемана€ дата обновлени€';
COMMENT ON COLUMN BARS.CC_GRT_UPDATE.DONEBY IS ' од пользовател€. кто внес обновлени€(если в течении дн€ было несколько обновлений - остаетс€ только последнее)';
COMMENT ON COLUMN BARS.CC_GRT_UPDATE.ND IS '';
COMMENT ON COLUMN BARS.CC_GRT_UPDATE.GRT_DEAL_ID IS '';




PROMPT *** Create  constraint PK_CCGRT_UPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_GRT_UPDATE ADD CONSTRAINT PK_CCGRT_UPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCGRTUPDATE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_GRT_UPDATE MODIFY (KF CONSTRAINT CC_CCGRTUPDATE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008350 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_GRT_UPDATE MODIFY (ND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008351 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_GRT_UPDATE MODIFY (GRT_DEAL_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCGRT_UPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCGRT_UPDATE ON BARS.CC_GRT_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CCGRT_UPDATEEFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CCGRT_UPDATEEFFDAT ON BARS.CC_GRT_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CCGRT_UPDATEPK ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CCGRT_UPDATEPK ON BARS.CC_GRT_UPDATE (ND, GRT_DEAL_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_GRT_UPDATE ***
grant SELECT                                                                 on CC_GRT_UPDATE   to BARSREADER_ROLE;
grant SELECT                                                                 on CC_GRT_UPDATE   to BARS_DM;
grant SELECT                                                                 on CC_GRT_UPDATE   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_GRT_UPDATE.sql =========*** End ***
PROMPT ===================================================================================== 
