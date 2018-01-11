

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INT_RATN_ARC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INT_RATN_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INT_RATN_ARC'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''INT_RATN_ARC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''INT_RATN_ARC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INT_RATN_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.INT_RATN_ARC 
   (	ACC NUMBER(38,0), 
	ID NUMBER, 
	BDAT DATE, 
	IR NUMBER, 
	BR NUMBER(38,0), 
	OP NUMBER(4,0), 
	IDU NUMBER(38,0), 
	FDAT DATE, 
	VID CHAR(1), 
	IDUPD NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	EFFECTDATE DATE, 
	GLOBAL_BDATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INT_RATN_ARC ***
 exec bpa.alter_policies('INT_RATN_ARC');


COMMENT ON TABLE BARS.INT_RATN_ARC IS 'История изменений % ставок';
COMMENT ON COLUMN BARS.INT_RATN_ARC.GLOBAL_BDATE IS 'Глобальна банківська дата';
COMMENT ON COLUMN BARS.INT_RATN_ARC.ACC IS 'Идентификатор счета';
COMMENT ON COLUMN BARS.INT_RATN_ARC.ID IS 'идентификатор типа начисления %';
COMMENT ON COLUMN BARS.INT_RATN_ARC.BDAT IS 'Дата установки';
COMMENT ON COLUMN BARS.INT_RATN_ARC.IR IS 'индивидуальная % ставка';
COMMENT ON COLUMN BARS.INT_RATN_ARC.BR IS 'базовая % ставка';
COMMENT ON COLUMN BARS.INT_RATN_ARC.OP IS 'операция, между IR и BR';
COMMENT ON COLUMN BARS.INT_RATN_ARC.IDU IS 'aвтор модификации';
COMMENT ON COLUMN BARS.INT_RATN_ARC.FDAT IS 'дата модификации';
COMMENT ON COLUMN BARS.INT_RATN_ARC.VID IS 'Вид модификации';
COMMENT ON COLUMN BARS.INT_RATN_ARC.IDUPD IS 'Номер записи про модификацию';
COMMENT ON COLUMN BARS.INT_RATN_ARC.KF IS '';
COMMENT ON COLUMN BARS.INT_RATN_ARC.EFFECTDATE IS 'банковская дата изменения';




PROMPT *** Create  constraint PK_INTRATNARC ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN_ARC ADD CONSTRAINT PK_INTRATNARC PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTRATNARC_VID ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN_ARC ADD CONSTRAINT CC_INTRATNARC_VID CHECK (vid in (''D'', ''I'', ''U'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTRATNARC_GLBD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN_ARC MODIFY (GLOBAL_BDATE CONSTRAINT CC_INTRATNARC_GLBD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTRATNARC_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN_ARC MODIFY (ACC CONSTRAINT CC_INTRATNARC_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTRATNARC_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN_ARC MODIFY (ID CONSTRAINT CC_INTRATNARC_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTRATNARC_BDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN_ARC MODIFY (BDAT CONSTRAINT CC_INTRATNARC_BDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTRATNARC_IDU_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN_ARC MODIFY (IDU CONSTRAINT CC_INTRATNARC_IDU_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTRATNARC_FDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN_ARC MODIFY (FDAT CONSTRAINT CC_INTRATNARC_FDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTRATNARC_VID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN_ARC MODIFY (VID CONSTRAINT CC_INTRATNARC_VID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTRATNARC_IDUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN_ARC MODIFY (IDUPD CONSTRAINT CC_INTRATNARC_IDUPD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTRATNARC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN_ARC MODIFY (KF CONSTRAINT CC_INTRATNARC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_INTRATNARC_GLBDT_EFFDT ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_INTRATNARC_GLBDT_EFFDT ON BARS.INT_RATN_ARC (GLOBAL_BDATE, EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INTRATNARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INTRATNARC ON BARS.INT_RATN_ARC (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_INTRATNARC ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_INTRATNARC ON BARS.INT_RATN_ARC (ACC, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS NOLOGGING 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_INTRATNARC_EFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_INTRATNARC_EFFDAT ON BARS.INT_RATN_ARC (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INT_RATN_ARC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_RATN_ARC    to ABS_ADMIN;
grant SELECT                                                                 on INT_RATN_ARC    to BARSREADER_ROLE;
grant SELECT                                                                 on INT_RATN_ARC    to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_RATN_ARC    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INT_RATN_ARC    to BARS_DM;
grant SELECT                                                                 on INT_RATN_ARC    to START1;
grant SELECT                                                                 on INT_RATN_ARC    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on INT_RATN_ARC    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INT_RATN_ARC.sql =========*** End *** 
PROMPT ===================================================================================== 
