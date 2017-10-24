

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BR_TIER_EDIT_UPDATE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BR_TIER_EDIT_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BR_TIER_EDIT_UPDATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BR_TIER_EDIT_UPDATE'', ''FILIAL'' , null, ''F'', ''F'', ''F'');
               bpa.alter_policy_info(''BR_TIER_EDIT_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BR_TIER_EDIT_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.BR_TIER_EDIT_UPDATE 
   (	IDUPD NUMBER(15,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER, 
	BR_ID NUMBER(38,0), 
	BDATE DATE, 
	KV NUMBER(3,0), 
	S NUMBER(24,0), 
	RATE NUMBER(30,8), 
	KF VARCHAR2(6) DEFAULT NULL, 
	BRANCH VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BR_TIER_EDIT_UPDATE ***
 exec bpa.alter_policies('BR_TIER_EDIT_UPDATE');


COMMENT ON TABLE BARS.BR_TIER_EDIT_UPDATE IS '';
COMMENT ON COLUMN BARS.BR_TIER_EDIT_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.BR_TIER_EDIT_UPDATE.BRANCH IS '';
COMMENT ON COLUMN BARS.BR_TIER_EDIT_UPDATE.IDUPD IS 'ѕервичный ключ дл€ таблицы обновлени€';
COMMENT ON COLUMN BARS.BR_TIER_EDIT_UPDATE.CHGACTION IS ' од обновлени€ (I/U/D)';
COMMENT ON COLUMN BARS.BR_TIER_EDIT_UPDATE.EFFECTDATE IS 'Ѕанковска€ дата начала действи€ параметров';
COMMENT ON COLUMN BARS.BR_TIER_EDIT_UPDATE.CHGDATE IS '—истемана€ дата обновлени€';
COMMENT ON COLUMN BARS.BR_TIER_EDIT_UPDATE.DONEBY IS ' од пользовател€. кто внес обновлени€(если в течении дн€ было несколько обновлений - остаетс€ только последнее)';
COMMENT ON COLUMN BARS.BR_TIER_EDIT_UPDATE.BR_ID IS '';
COMMENT ON COLUMN BARS.BR_TIER_EDIT_UPDATE.BDATE IS '';
COMMENT ON COLUMN BARS.BR_TIER_EDIT_UPDATE.KV IS '';
COMMENT ON COLUMN BARS.BR_TIER_EDIT_UPDATE.S IS '';
COMMENT ON COLUMN BARS.BR_TIER_EDIT_UPDATE.RATE IS '';




PROMPT *** Create  constraint CC_BRTIEREDITUPDATE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_TIER_EDIT_UPDATE MODIFY (KF CONSTRAINT CC_BRTIEREDITUPDATE_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BRTIEREDITUPDATE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_TIER_EDIT_UPDATE ADD CONSTRAINT FK_BRTIEREDITUPDATE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004974 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_TIER_EDIT_UPDATE MODIFY (BR_ID NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004975 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_TIER_EDIT_UPDATE MODIFY (BDATE NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004976 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_TIER_EDIT_UPDATE MODIFY (KV NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004977 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_TIER_EDIT_UPDATE MODIFY (S NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BRTIEREDIT_UPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_TIER_EDIT_UPDATE ADD CONSTRAINT PK_BRTIEREDIT_UPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_BRTIEREDIT_UPDATEEFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_BRTIEREDIT_UPDATEEFFDAT ON BARS.BR_TIER_EDIT_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BRTIEREDIT_UPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BRTIEREDIT_UPDATE ON BARS.BR_TIER_EDIT_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BR_TIER_EDIT_UPDATE ***
grant SELECT                                                                 on BR_TIER_EDIT_UPDATE to BARSUPL;
grant SELECT                                                                 on BR_TIER_EDIT_UPDATE to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BR_TIER_EDIT_UPDATE.sql =========*** E
PROMPT ===================================================================================== 
