

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PAWN_ACC_UPDATE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PAWN_ACC_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PAWN_ACC_UPDATE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PAWN_ACC_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''PAWN_ACC_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PAWN_ACC_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.PAWN_ACC_UPDATE 
   (	IDUPD NUMBER(15,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER, 
	ACC NUMBER(*,0), 
	PAWN NUMBER(*,0), 
	MPAWN NUMBER(*,0), 
	NREE VARCHAR2(45), 
	IDZ NUMBER(*,0), 
	NDZ NUMBER(*,0), 
	DEPOSIT_ID NUMBER(38,0), 
	KF VARCHAR2(6), 
	SV NUMBER(38,0), 
	CC_IDZ VARCHAR2(20), 
	SDATZ DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PAWN_ACC_UPDATE ***
 exec bpa.alter_policies('PAWN_ACC_UPDATE');


COMMENT ON TABLE BARS.PAWN_ACC_UPDATE IS '';
COMMENT ON COLUMN BARS.PAWN_ACC_UPDATE.IDUPD IS 'ѕервичный ключ дл€ таблицы обновлени€';
COMMENT ON COLUMN BARS.PAWN_ACC_UPDATE.CHGACTION IS ' од обновлени€ (I/U/D)';
COMMENT ON COLUMN BARS.PAWN_ACC_UPDATE.EFFECTDATE IS 'Ѕанковска€ дата начала действи€ параметров';
COMMENT ON COLUMN BARS.PAWN_ACC_UPDATE.CHGDATE IS '—истемана€ дата обновлени€';
COMMENT ON COLUMN BARS.PAWN_ACC_UPDATE.DONEBY IS ' од пользовател€. кто внес обновлени€(если в течении дн€ было несколько обновлений - остаетс€ только последнее)';
COMMENT ON COLUMN BARS.PAWN_ACC_UPDATE.ACC IS '';
COMMENT ON COLUMN BARS.PAWN_ACC_UPDATE.PAWN IS '';
COMMENT ON COLUMN BARS.PAWN_ACC_UPDATE.MPAWN IS '';
COMMENT ON COLUMN BARS.PAWN_ACC_UPDATE.NREE IS '';
COMMENT ON COLUMN BARS.PAWN_ACC_UPDATE.IDZ IS '';
COMMENT ON COLUMN BARS.PAWN_ACC_UPDATE.NDZ IS '';
COMMENT ON COLUMN BARS.PAWN_ACC_UPDATE.DEPOSIT_ID IS '';
COMMENT ON COLUMN BARS.PAWN_ACC_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.PAWN_ACC_UPDATE.SV IS '';
COMMENT ON COLUMN BARS.PAWN_ACC_UPDATE.CC_IDZ IS '';
COMMENT ON COLUMN BARS.PAWN_ACC_UPDATE.SDATZ IS '';




PROMPT *** Create  constraint PK_PAWNACC_UPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.PAWN_ACC_UPDATE ADD CONSTRAINT PK_PAWNACC_UPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008944 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PAWN_ACC_UPDATE MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008945 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PAWN_ACC_UPDATE MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PAWNACC_UPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PAWNACC_UPDATE ON BARS.PAWN_ACC_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_PAWNACC_UPDATEEFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_PAWNACC_UPDATEEFFDAT ON BARS.PAWN_ACC_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_PAWNACC_UPDATEPK ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_PAWNACC_UPDATEPK ON BARS.PAWN_ACC_UPDATE (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PAWN_ACC_UPDATE ***
grant SELECT                                                                 on PAWN_ACC_UPDATE to BARSUPL;
grant SELECT                                                                 on PAWN_ACC_UPDATE to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PAWN_ACC_UPDATE.sql =========*** End *
PROMPT ===================================================================================== 
