

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_PROTOCOL_UPDATE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_PROTOCOL_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_PROTOCOL_UPDATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REZ_PROTOCOL_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''REZ_PROTOCOL_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_PROTOCOL_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ_PROTOCOL_UPDATE 
   (	IDUPD NUMBER(38,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER(38,0), 
	USERID NUMBER, 
	DAT DATE, 
	BRANCH VARCHAR2(30), 
	DAT_BANK DATE, 
	GLOBAL_BDATE DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZ_PROTOCOL_UPDATE ***
 exec bpa.alter_policies('REZ_PROTOCOL_UPDATE');


COMMENT ON TABLE BARS.REZ_PROTOCOL_UPDATE IS 'Історія змін протоколу формування резервів';
COMMENT ON COLUMN BARS.REZ_PROTOCOL_UPDATE.IDUPD IS 'Ідентифікатор зміни';
COMMENT ON COLUMN BARS.REZ_PROTOCOL_UPDATE.CHGACTION IS 'Код типу зміни';
COMMENT ON COLUMN BARS.REZ_PROTOCOL_UPDATE.EFFECTDATE IS 'Банківська дата зміни параметрів';
COMMENT ON COLUMN BARS.REZ_PROTOCOL_UPDATE.CHGDATE IS 'Календарна дата зміни параметрів';
COMMENT ON COLUMN BARS.REZ_PROTOCOL_UPDATE.DONEBY IS 'Ідентифікатор користувача, що виконав зміни';
COMMENT ON COLUMN BARS.REZ_PROTOCOL_UPDATE.USERID IS 'Ідентифікатор користувача, що виконав формування резервів';
COMMENT ON COLUMN BARS.REZ_PROTOCOL_UPDATE.DAT IS 'Звітна дата формування резервів';
COMMENT ON COLUMN BARS.REZ_PROTOCOL_UPDATE.BRANCH IS 'Код відділення';
COMMENT ON COLUMN BARS.REZ_PROTOCOL_UPDATE.DAT_BANK IS 'Дата, що теоретично має бути рівною EFFECTDATE';
COMMENT ON COLUMN BARS.REZ_PROTOCOL_UPDATE.GLOBAL_BDATE IS 'Глобальна банківська дата зміни';
COMMENT ON COLUMN BARS.REZ_PROTOCOL_UPDATE.KF IS '';




PROMPT *** Create  constraint PK_REZPRTCLUPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_PROTOCOL_UPDATE ADD CONSTRAINT PK_REZPRTCLUPD PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REZ_PROTOCOL_UPDATE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_PROTOCOL_UPDATE MODIFY (KF CONSTRAINT CC_REZ_PROTOCOL_UPDATE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REZPRTCLUPD_IDUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_PROTOCOL_UPDATE MODIFY (IDUPD CONSTRAINT CC_REZPRTCLUPD_IDUPD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REZPRTCLUPD_CHGACTION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_PROTOCOL_UPDATE MODIFY (CHGACTION CONSTRAINT CC_REZPRTCLUPD_CHGACTION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REZPRTCLUPD_EFFECTDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_PROTOCOL_UPDATE MODIFY (EFFECTDATE CONSTRAINT CC_REZPRTCLUPD_EFFECTDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REZPRTCLUPD_CHGDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_PROTOCOL_UPDATE MODIFY (CHGDATE CONSTRAINT CC_REZPRTCLUPD_CHGDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REZPRTCLUPD_DONEBY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_PROTOCOL_UPDATE MODIFY (DONEBY CONSTRAINT CC_REZPRTCLUPD_DONEBY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REZPRTCLUPD_GLOBALBD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_PROTOCOL_UPDATE MODIFY (GLOBAL_BDATE CONSTRAINT CC_REZPRTCLUPD_GLOBALBD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REZPRTCLUPD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REZPRTCLUPD ON BARS.REZ_PROTOCOL_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_REZPRTCLUPD_EFFECTDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_REZPRTCLUPD_EFFECTDATE ON BARS.REZ_PROTOCOL_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_REZPRTCLUPD_DAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_REZPRTCLUPD_DAT ON BARS.REZ_PROTOCOL_UPDATE (DAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REZ_PROTOCOL_UPDATE ***
grant SELECT                                                                 on REZ_PROTOCOL_UPDATE to BARSREADER_ROLE;
grant SELECT                                                                 on REZ_PROTOCOL_UPDATE to BARSUPL;
grant SELECT                                                                 on REZ_PROTOCOL_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REZ_PROTOCOL_UPDATE to BARS_DM;
grant SELECT                                                                 on REZ_PROTOCOL_UPDATE to START1;
grant SELECT                                                                 on REZ_PROTOCOL_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_PROTOCOL_UPDATE.sql =========*** E
PROMPT ===================================================================================== 
