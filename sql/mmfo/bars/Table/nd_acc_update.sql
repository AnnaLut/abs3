

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ND_ACC_UPDATE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ND_ACC_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ND_ACC_UPDATE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ND_ACC_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ND_ACC_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ND_ACC_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ND_ACC_UPDATE 
   (	IDUPD NUMBER(15,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER, 
	ND NUMBER(38,0), 
	ACC NUMBER(38,0), 
	KF VARCHAR2(6), 
	GLOBAL_BDATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ND_ACC_UPDATE ***
 exec bpa.alter_policies('ND_ACC_UPDATE');


COMMENT ON TABLE BARS.ND_ACC_UPDATE IS '';
COMMENT ON COLUMN BARS.ND_ACC_UPDATE.GLOBAL_BDATE IS 'Глобальна банківська дата';
COMMENT ON COLUMN BARS.ND_ACC_UPDATE.IDUPD IS 'Первичный ключ для таблицы обновления';
COMMENT ON COLUMN BARS.ND_ACC_UPDATE.CHGACTION IS 'Код обновления (I/U/D)';
COMMENT ON COLUMN BARS.ND_ACC_UPDATE.EFFECTDATE IS 'Банковская дата начала действия параметров';
COMMENT ON COLUMN BARS.ND_ACC_UPDATE.CHGDATE IS 'Системаная дата обновления';
COMMENT ON COLUMN BARS.ND_ACC_UPDATE.DONEBY IS 'Код пользователя. кто внес обновления(если в течении дня было несколько обновлений - остается только последнее)';
COMMENT ON COLUMN BARS.ND_ACC_UPDATE.ND IS '';
COMMENT ON COLUMN BARS.ND_ACC_UPDATE.ACC IS '';
COMMENT ON COLUMN BARS.ND_ACC_UPDATE.KF IS '';




PROMPT *** Create  constraint PK_NDACC_UPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_ACC_UPDATE ADD CONSTRAINT PK_NDACC_UPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0085193 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_ACC_UPDATE MODIFY (GLOBAL_BDATE NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005689 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_ACC_UPDATE MODIFY (ND NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005690 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_ACC_UPDATE MODIFY (ACC NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005691 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_ACC_UPDATE MODIFY (KF NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_NDACCUPDATE_GLBDT_EFFDT ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_NDACCUPDATE_GLBDT_EFFDT ON BARS.ND_ACC_UPDATE (GLOBAL_BDATE, EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NDACC_UPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NDACC_UPDATE ON BARS.ND_ACC_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_NDACC_UPDATEEFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_NDACC_UPDATEEFFDAT ON BARS.ND_ACC_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_NDACC_UPDATEPK ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_NDACC_UPDATEPK ON BARS.ND_ACC_UPDATE (ND, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ND_ACC_UPDATE ***
grant SELECT                                                                 on ND_ACC_UPDATE   to BARSUPL;
grant SELECT                                                                 on ND_ACC_UPDATE   to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ND_ACC_UPDATE.sql =========*** End ***
PROMPT ===================================================================================== 
