

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RKO_LST_UPDATE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RKO_LST_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RKO_LST_UPDATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''RKO_LST_UPDATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''RKO_LST_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RKO_LST_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.RKO_LST_UPDATE 
   (	IDUPD NUMBER(38,0), 
	CHGACTION CHAR(1), 
	CHGDATE DATE, 
	EFFECTDATE DATE, 
	GLOBAL_BDATE DATE, 
	DONEBY NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT NULL, 
	ND NUMBER(38,0), 
	ACC NUMBER(38,0), 
	ACCD NUMBER(38,0), 
	ACC1 NUMBER(38,0), 
	ACC2 NUMBER(38,0), 
	DAT0A DATE, 
	DAT0B DATE, 
	S0 NUMBER, 
	DAT1A DATE, 
	DAT1B DATE, 
	DAT2A DATE, 
	DAT2B DATE, 
	COMM VARCHAR2(250), 
	KOLDOK NUMBER(*,0), 
	SUMDOK NUMBER(24,0), 
	CC_ID VARCHAR2(50), 
	SDATE DATE, 
	SOS NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RKO_LST_UPDATE ***
 exec bpa.alter_policies('RKO_LST_UPDATE');


COMMENT ON TABLE BARS.RKO_LST_UPDATE IS 'Історія змін параметрів договорів РКО';
COMMENT ON COLUMN BARS.RKO_LST_UPDATE.IDUPD IS 'Ідентифікатор зміни';
COMMENT ON COLUMN BARS.RKO_LST_UPDATE.CHGACTION IS 'Код типу зміни';
COMMENT ON COLUMN BARS.RKO_LST_UPDATE.CHGDATE IS 'Календарна дата зміни';
COMMENT ON COLUMN BARS.RKO_LST_UPDATE.EFFECTDATE IS 'Локальна  банківська дата зміни';
COMMENT ON COLUMN BARS.RKO_LST_UPDATE.GLOBAL_BDATE IS 'Глобальна банківська дата зміни';
COMMENT ON COLUMN BARS.RKO_LST_UPDATE.DONEBY IS 'Ідентифікатор користувача, що виконав зміни';
COMMENT ON COLUMN BARS.RKO_LST_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.RKO_LST_UPDATE.ND IS 'Реф. договору';
COMMENT ON COLUMN BARS.RKO_LST_UPDATE.ACC IS 'Рахунок нарахування';
COMMENT ON COLUMN BARS.RKO_LST_UPDATE.ACCD IS 'Рахунок стягнення';
COMMENT ON COLUMN BARS.RKO_LST_UPDATE.ACC1 IS 'Рахунок боргу 3570';
COMMENT ON COLUMN BARS.RKO_LST_UPDATE.ACC2 IS 'Рахунок просроченого боргу 3579';
COMMENT ON COLUMN BARS.RKO_LST_UPDATE.DAT0A IS 'Дата нарахування З';
COMMENT ON COLUMN BARS.RKO_LST_UPDATE.DAT0B IS 'Дата нарахування ПО';
COMMENT ON COLUMN BARS.RKO_LST_UPDATE.S0 IS 'Сума нарахування';
COMMENT ON COLUMN BARS.RKO_LST_UPDATE.DAT1A IS 'Дата боргу З';
COMMENT ON COLUMN BARS.RKO_LST_UPDATE.DAT1B IS 'Дата боргу ПО';
COMMENT ON COLUMN BARS.RKO_LST_UPDATE.DAT2A IS 'Дата просроченого боргу З';
COMMENT ON COLUMN BARS.RKO_LST_UPDATE.DAT2B IS 'Дата просроченого боргу ПО';
COMMENT ON COLUMN BARS.RKO_LST_UPDATE.COMM IS '';
COMMENT ON COLUMN BARS.RKO_LST_UPDATE.KOLDOK IS 'К-ть документів';
COMMENT ON COLUMN BARS.RKO_LST_UPDATE.SUMDOK IS 'Сума документів';
COMMENT ON COLUMN BARS.RKO_LST_UPDATE.CC_ID IS 'Номер договору';
COMMENT ON COLUMN BARS.RKO_LST_UPDATE.SDATE IS 'Дата початку дії договору';
COMMENT ON COLUMN BARS.RKO_LST_UPDATE.SOS IS 'Стан договору';




PROMPT *** Create  constraint PK_RKOLSTUPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_LST_UPDATE ADD CONSTRAINT PK_RKOLSTUPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RKOLSTUPDATE_IDUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_LST_UPDATE MODIFY (IDUPD CONSTRAINT CC_RKOLSTUPDATE_IDUPD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RKOLSTUPDATE_CHGACTION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_LST_UPDATE MODIFY (CHGACTION CONSTRAINT CC_RKOLSTUPDATE_CHGACTION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RKOLSTUPDATE_CHGDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_LST_UPDATE MODIFY (CHGDATE CONSTRAINT CC_RKOLSTUPDATE_CHGDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RKOLSTUPDATE_EFFECTDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_LST_UPDATE MODIFY (EFFECTDATE CONSTRAINT CC_RKOLSTUPDATE_EFFECTDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RKOLSTUPDATE_GLOBALBD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_LST_UPDATE MODIFY (GLOBAL_BDATE CONSTRAINT CC_RKOLSTUPDATE_GLOBALBD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RKOLSTUPDATE_DONEBY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_LST_UPDATE MODIFY (DONEBY CONSTRAINT CC_RKOLSTUPDATE_DONEBY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RKOLSTUPDATE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_LST_UPDATE MODIFY (KF CONSTRAINT CC_RKOLSTUPDATE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RKOLSTUPDATE_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_LST_UPDATE MODIFY (ACC CONSTRAINT CC_RKOLSTUPDATE_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_RKOLSTUPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_RKOLSTUPDATE ON BARS.RKO_LST_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_RKOLSTUPDATE_ACC ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_RKOLSTUPDATE_ACC ON BARS.RKO_LST_UPDATE (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_RKOLSTUPDATE_ND ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_RKOLSTUPDATE_ND ON BARS.RKO_LST_UPDATE (GLOBAL_BDATE, ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_RKOLSTUPDATE_ND_ACC1_ACC2 ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_RKOLSTUPDATE_ND_ACC1_ACC2 ON BARS.RKO_LST_UPDATE (ND, ACC1, ACC2) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RKO_LST_UPDATE ***
grant SELECT                                                                 on RKO_LST_UPDATE  to BARSREADER_ROLE;
grant SELECT                                                                 on RKO_LST_UPDATE  to BARSUPL;
grant SELECT                                                                 on RKO_LST_UPDATE  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RKO_LST_UPDATE  to BARS_DM;
grant SELECT                                                                 on RKO_LST_UPDATE  to RKO;
grant SELECT                                                                 on RKO_LST_UPDATE  to START1;
grant SELECT                                                                 on RKO_LST_UPDATE  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RKO_LST_UPDATE.sql =========*** End **
PROMPT ===================================================================================== 
