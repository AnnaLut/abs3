

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BPK_PARAMETERS_UPDATE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BPK_PARAMETERS_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BPK_PARAMETERS_UPDATE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BPK_PARAMETERS_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''BPK_PARAMETERS_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BPK_PARAMETERS_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.BPK_PARAMETERS_UPDATE 
   (	IDUPD NUMBER(38,0), 
	CHGACTION CHAR(1), 
	CHGDATE DATE, 
	GLOBAL_BDATE DATE, 
	EFFECTDATE DATE, 
	DONEBY NUMBER(38,0), 
	ND NUMBER(22,0), 
	TAG VARCHAR2(30), 
	VALUE VARCHAR2(254), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BPK_PARAMETERS_UPDATE ***
 exec bpa.alter_policies('BPK_PARAMETERS_UPDATE');


COMMENT ON TABLE BARS.BPK_PARAMETERS_UPDATE IS 'Історія змін додаткових реквізитів догоіорів БПК';
COMMENT ON COLUMN BARS.BPK_PARAMETERS_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.BPK_PARAMETERS_UPDATE.IDUPD IS 'Ідентифікатор зміни';
COMMENT ON COLUMN BARS.BPK_PARAMETERS_UPDATE.CHGACTION IS 'Код типу зміни';
COMMENT ON COLUMN BARS.BPK_PARAMETERS_UPDATE.CHGDATE IS 'Календарна дата зміни';
COMMENT ON COLUMN BARS.BPK_PARAMETERS_UPDATE.GLOBAL_BDATE IS 'Глобальна банківська дата зміни';
COMMENT ON COLUMN BARS.BPK_PARAMETERS_UPDATE.EFFECTDATE IS 'Локальна банківська дата зміни';
COMMENT ON COLUMN BARS.BPK_PARAMETERS_UPDATE.DONEBY IS 'Ідентифікатор користувача, що виконав зміни';
COMMENT ON COLUMN BARS.BPK_PARAMETERS_UPDATE.ND IS 'Ідентифікатор договору';
COMMENT ON COLUMN BARS.BPK_PARAMETERS_UPDATE.TAG IS 'Код дод. параметру';
COMMENT ON COLUMN BARS.BPK_PARAMETERS_UPDATE.VALUE IS 'Значення параметру';




PROMPT *** Create  constraint CC_BPKPARAMETERSUPDATE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PARAMETERS_UPDATE MODIFY (KF CONSTRAINT CC_BPKPARAMETERSUPDATE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BPKPARAMSUPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PARAMETERS_UPDATE ADD CONSTRAINT PK_BPKPARAMSUPD PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BPKPARAMETERSUPDATE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PARAMETERS_UPDATE ADD CONSTRAINT FK_BPKPARAMETERSUPDATE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKPARAMSUPD_IDUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PARAMETERS_UPDATE MODIFY (IDUPD CONSTRAINT CC_BPKPARAMSUPD_IDUPD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKPARAMSUPD_CHGACTION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PARAMETERS_UPDATE MODIFY (CHGACTION CONSTRAINT CC_BPKPARAMSUPD_CHGACTION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKPARAMSUPD_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PARAMETERS_UPDATE MODIFY (TAG CONSTRAINT CC_BPKPARAMSUPD_TAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKPARAMSUPD_GLOBALBD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PARAMETERS_UPDATE MODIFY (GLOBAL_BDATE CONSTRAINT CC_BPKPARAMSUPD_GLOBALBD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKPARAMSUPD_EFFECTDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PARAMETERS_UPDATE MODIFY (EFFECTDATE CONSTRAINT CC_BPKPARAMSUPD_EFFECTDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKPARAMSUPD_DONEBY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PARAMETERS_UPDATE MODIFY (DONEBY CONSTRAINT CC_BPKPARAMSUPD_DONEBY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKPARAMSUPD_ND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PARAMETERS_UPDATE MODIFY (ND CONSTRAINT CC_BPKPARAMSUPD_ND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKPARAMSUPD_CHGDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PARAMETERS_UPDATE MODIFY (CHGDATE CONSTRAINT CC_BPKPARAMSUPD_CHGDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_BPKPARAMSUPD_TAG_VALUE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_BPKPARAMSUPD_TAG_VALUE ON BARS.BPK_PARAMETERS_UPDATE (TAG, VALUE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BPKPARAMSUPD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BPKPARAMSUPD ON BARS.BPK_PARAMETERS_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_BPKPARAMSUPD_GLBDT_EFFDT ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_BPKPARAMSUPD_GLBDT_EFFDT ON BARS.BPK_PARAMETERS_UPDATE (GLOBAL_BDATE, EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_BPKPARAMSUPD_ND_TAG ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_BPKPARAMSUPD_ND_TAG ON BARS.BPK_PARAMETERS_UPDATE (ND, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BPK_PARAMETERS_UPDATE ***
grant SELECT                                                                 on BPK_PARAMETERS_UPDATE to BARSUPL;
grant SELECT                                                                 on BPK_PARAMETERS_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BPK_PARAMETERS_UPDATE to BARS_DM;
grant SELECT                                                                 on BPK_PARAMETERS_UPDATE to START1;
grant SELECT                                                                 on BPK_PARAMETERS_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BPK_PARAMETERS_UPDATE.sql =========***
PROMPT ===================================================================================== 
