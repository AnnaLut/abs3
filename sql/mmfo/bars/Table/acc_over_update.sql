

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACC_OVER_UPDATE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACC_OVER_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACC_OVER_UPDATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ACC_OVER_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ACC_OVER_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACC_OVER_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACC_OVER_UPDATE 
   (	IDUPD NUMBER(38,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER(38,0), 
	ACC NUMBER(*,0), 
	ACCO NUMBER(*,0), 
	TIPO NUMBER(*,0), 
	FLAG NUMBER(*,0), 
	ND NUMBER, 
	DAY NUMBER(*,0), 
	SOS NUMBER(*,0), 
	DATD DATE, 
	SD NUMBER(24,0), 
	NDOC VARCHAR2(30), 
	VIDD NUMBER, 
	DATD2 DATE, 
	KRL NUMBER, 
	USEOSTF NUMBER, 
	USELIM NUMBER, 
	ACC_9129 NUMBER(*,0), 
	ACC_8000 NUMBER(*,0), 
	OBS NUMBER(*,0), 
	TXT VARCHAR2(100), 
	USERID NUMBER, 
	DELETED NUMBER, 
	PR_2600A NUMBER, 
	PR_KOMIS NUMBER, 
	PR_9129 NUMBER, 
	PR_2069 NUMBER, 
	ACC_2067 NUMBER, 
	ACC_2069 NUMBER, 
	ACC_2096 NUMBER, 
	KF VARCHAR2(6), 
	ACC_3739 NUMBER(*,0), 
	KAT23 NUMBER(*,0), 
	FIN23 NUMBER(*,0), 
	OBS23 NUMBER(*,0), 
	K23 NUMBER, 
	FIN NUMBER(*,0), 
	ACC_3600 NUMBER(*,0), 
	S_3600 NUMBER(24,0), 
	FLAG_3600 NUMBER(*,0), 
	GLOBAL_BDATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACC_OVER_UPDATE ***
 exec bpa.alter_policies('ACC_OVER_UPDATE');


COMMENT ON TABLE BARS.ACC_OVER_UPDATE IS 'Історія змін параметрів договорів портфеля овердрафтів';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.PR_2600A IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.PR_KOMIS IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.PR_9129 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.PR_2069 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.ACC_2067 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.ACC_2069 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.ACC_2096 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.ACC_3739 IS 'Счет гашения';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.KAT23 IS 'Категорiя якостi за кредитом по НБУ-23';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.FIN23 IS 'ФiнКлас по НБУ-23';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.OBS23 IS 'Обсл.долга по НБУ-23';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.K23 IS 'Коеф.Показник ризику по НБУ-23';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.FIN IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.ACC_3600 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.S_3600 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.FLAG_3600 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.GLOBAL_BDATE IS 'Глобальна банківська дата';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.IDUPD IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.CHGACTION IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.EFFECTDATE IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.CHGDATE IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.DONEBY IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.ACC IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.ACCO IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.TIPO IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.FLAG IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.ND IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.DAY IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.SOS IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.DATD IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.SD IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.NDOC IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.VIDD IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.DATD2 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.KRL IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.USEOSTF IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.USELIM IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.ACC_9129 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.ACC_8000 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.OBS IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.TXT IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.USERID IS '';
COMMENT ON COLUMN BARS.ACC_OVER_UPDATE.DELETED IS '';




PROMPT *** Create  constraint PK_ACCOVERUPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_UPDATE ADD CONSTRAINT PK_ACCOVERUPD PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0085175 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_UPDATE MODIFY (GLOBAL_BDATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOVERUPD_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_UPDATE MODIFY (KF CONSTRAINT CC_ACCOVERUPD_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOVERUPD_IDUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_UPDATE MODIFY (IDUPD CONSTRAINT CC_ACCOVERUPD_IDUPD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOVERUPD_CHGACTION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_UPDATE MODIFY (CHGACTION CONSTRAINT CC_ACCOVERUPD_CHGACTION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOVERUPD_EFFECTDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_UPDATE MODIFY (EFFECTDATE CONSTRAINT CC_ACCOVERUPD_EFFECTDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOVERUPD_CHGDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_UPDATE MODIFY (CHGDATE CONSTRAINT CC_ACCOVERUPD_CHGDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOVERUPD_DONEBY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_UPDATE MODIFY (DONEBY CONSTRAINT CC_ACCOVERUPD_DONEBY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOVERUPD_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_UPDATE MODIFY (ACC CONSTRAINT CC_ACCOVERUPD_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOVERUPD_ACCO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_UPDATE MODIFY (ACCO CONSTRAINT CC_ACCOVERUPD_ACCO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOVERUPD_DELETED_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_UPDATE MODIFY (DELETED CONSTRAINT CC_ACCOVERUPD_DELETED_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_ACCOVERUPD_EFFECTDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_ACCOVERUPD_EFFECTDATE ON BARS.ACC_OVER_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_ACCOVERUPD_ACC ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_ACCOVERUPD_ACC ON BARS.ACC_OVER_UPDATE (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCOVERUPD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCOVERUPD ON BARS.ACC_OVER_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_ACCOVERUPD_GLBDT_EFFDT ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_ACCOVERUPD_GLBDT_EFFDT ON BARS.ACC_OVER_UPDATE (GLOBAL_BDATE, EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACC_OVER_UPDATE ***
grant SELECT                                                                 on ACC_OVER_UPDATE to BARSREADER_ROLE;
grant SELECT                                                                 on ACC_OVER_UPDATE to BARSUPL;
grant SELECT                                                                 on ACC_OVER_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC_OVER_UPDATE to BARS_DM;
grant SELECT                                                                 on ACC_OVER_UPDATE to START1;
grant SELECT                                                                 on ACC_OVER_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACC_OVER_UPDATE.sql =========*** End *
PROMPT ===================================================================================== 
