
PROMPT ===================================================================================== 
PROMPT *** Run *** ===== Scripts /Sql/BARSUPL/Table/CP_ACCOUNTS_UPDATE.sql ====*** Run *
PROMPT ===================================================================================== 

--PROMPT *** ADD  CP_ACCOUNTS_UPDATE into POLICY_TABLE ***
begin
  execute immediate 'begin bars.bpa.alter_policy_info( ''BARS'', ''CP_ACCOUNTS_UPDATE'', ''CENTER'',  null, null, null, null ); end;';
  execute immediate 'begin bars.bpa.alter_policy_info( ''BARS'', ''CP_ACCOUNTS_UPDATE'', ''WHOLE'',   null, null, null, null ); end;';
  execute immediate 'begin bars.bpa.alter_policy_info( ''BARS'', ''CP_ACCOUNTS_UPDATE'', ''FILIAL'' , null, null, null, null ); end;'; 
  commit;
end;
/

PROMPT *** Create  table CP_ ACCOUNTS_UPDATE ***
begin
  execute immediate '
CREATE TABLE BARS.CP_ACCOUNTS_UPDATE(
    IDUPD           NUMBER(15,0),
    CHGACTION       CHAR(1),
    EFFECTDATE      DATE,
    GLOBALBD        DATE,
    CHGDATE         DATE,
    DONEBY          NUMBER,
    KF              VARCHAR2(6),
    CP_REF          NUMBER,
    CP_ACCTYPE      VARCHAR2(5),
    CP_ACC          NUMBER)
TABLESPACE BRSMDLD';

exception when others then
  if sqlcode=-955 then null; else raise; end if;
end;
/

COMMENT ON TABLE  BARS.CP_ACCOUNTS_UPDATE            IS 'Рахунки угоди';
COMMENT ON COLUMN BARS.CP_ACCOUNTS_UPDATE.IDUPD      IS 'Идентификатор изменения';
COMMENT ON COLUMN BARS.CP_ACCOUNTS_UPDATE.CHGACTION  IS 'Тип изменения';
COMMENT ON COLUMN BARS.CP_ACCOUNTS_UPDATE.EFFECTDATE IS 'банковская дата изменения';
COMMENT ON COLUMN BARS.CP_ACCOUNTS_UPDATE.GLOBALBD   IS 'Глобальна банківська дата';
COMMENT ON COLUMN BARS.CP_ACCOUNTS_UPDATE.CHGDATE    IS 'Дата/время изменения';
COMMENT ON COLUMN BARS.CP_ACCOUNTS_UPDATE.DONEBY     IS 'ID пользователя, выполнившего изменения';
COMMENT ON COLUMN BARS.CP_ACCOUNTS_UPDATE.KF         IS 'МФО региона';
COMMENT ON COLUMN BARS.CP_ACCOUNTS_UPDATE.CP_REF     IS 'Ідентифікатор угоди';
COMMENT ON COLUMN BARS.CP_ACCOUNTS_UPDATE.CP_ACCTYPE IS 'Тип рахунку';
COMMENT ON COLUMN BARS.CP_ACCOUNTS_UPDATE.CP_ACC     IS 'Ідентифікатор рахунку';

PROMPT *** ALTER  POLICIES  CP_ACCOUNTS_UPDATE***
 exec bars.bpa.alter_policies( 'BARS', 'CP_ACCOUNTS_UPDATE');


PROMPT *** Create  constraint PK_CPACCUPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ACCOUNTS_UPDATE ADD CONSTRAINT PK_CPACCUPD PRIMARY KEY (IDUPD)
  USING INDEX COMPUTE STATISTICS TABLESPACE BRSMDLI  ENABLE VALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint CC_CPACCUPD_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ACCOUNTS_UPDATE MODIFY (KF CONSTRAINT CC_CPACCUPD_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_CPACCUPD_CPREF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ACCOUNTS_UPDATE MODIFY (CP_REF CONSTRAINT CC_CPACCUPD_CPREF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_CPACCUPD_CPACCTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ACCOUNTS_UPDATE MODIFY (CP_ACCTYPE CONSTRAINT CC_CPACCUPD_CPACCTYPE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_CPACCUPD_CPACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ACCOUNTS_UPDATE MODIFY (CP_ACC CONSTRAINT CC_CPACCUPD_CPACC_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  index IDX_CPACCUPD_KF_GL_EF ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_CPACCUPD_KF_GL_EF ON BARS.CP_ACCOUNTS_UPDATE (KF, GLOBALBD, EFFECTDATE)
  COMPUTE STATISTICS TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index IDX_CPACCUPD_KF_REF ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_CPACCUPD_KF_REF ON BARS.CP_ACCOUNTS_UPDATE (KF, CP_REF)
  COMPUTE STATISTICS TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index IDX_CPACCUPD_KF_ACC ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_CPACCUPD_KF_ACC ON BARS.CP_ACCOUNTS_UPDATE (KF, CP_ACC)
  COMPUTE STATISTICS TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** CREATE GRANT on BARS.CP_ACCOUNTS_UPDATE  ...***
begin
   execute immediate 'grant SELECT  on BARS.CP_ACCOUNTS_UPDATE to BARSUPL';
   exception when others then 
   if sqlcode=-1917 or sqlcode=-990 or sqlcode=-1031  then null; else raise; end if;
end;
/

begin
   execute immediate 'grant SELECT, UPDATE, DELETE on BARS.CP_ACCOUNTS_UPDATE to BARS_ACCESS_DEFROLE';
   exception when others then 
   if sqlcode=-1917 or sqlcode=-990 or sqlcode=-1031   then null; else raise; end if; 
end;
/

begin
   execute immediate 'grant SELECT  on BARS.CP_ACCOUNTS_UPDATE to START1';
   exception when others then 
   if sqlcode=-1917 or sqlcode=-990 or sqlcode=-1031   then null; else raise; end if;
end;
/

begin
   execute immediate 'grant SELECT  on BARS.CP_ACCOUNTS_UPDATE to BARS_DM';
   exception when others then 
   if sqlcode=-1917 or sqlcode=-990 or sqlcode=-1031   then null; else raise; end if;
end;
/

begin
   execute immediate 'grant SELECT  on BARS.CP_ACCOUNTS_UPDATE to UPLD';
   exception when others then 
   if sqlcode=-1917 or sqlcode=-990 or sqlcode=-1031   then null; else raise; end if;
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ===== Scripts /Sql/BARSUPL/Table/CP_ACCOUNTS_UPDATE.sql ====*** End *
PROMPT ===================================================================================== 


