

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NAEK_ECOUNTERS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NAEK_ECOUNTERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NAEK_ECOUNTERS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NAEK_ECOUNTERS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NAEK_ECOUNTERS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NAEK_ECOUNTERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.NAEK_ECOUNTERS 
   (	ECODE VARCHAR2(4), 
	DAT DATE, 
	CNT NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NAEK_ECOUNTERS ***
 exec bpa.alter_policies('NAEK_ECOUNTERS');


COMMENT ON TABLE BARS.NAEK_ECOUNTERS IS 'Счетчики для файлов "Реестр корпоративных клиентов"';
COMMENT ON COLUMN BARS.NAEK_ECOUNTERS.ECODE IS 'Электронный код для файлов "Реестр корпоративных клиентов"';
COMMENT ON COLUMN BARS.NAEK_ECOUNTERS.DAT IS 'Рабочая дата счетчика';
COMMENT ON COLUMN BARS.NAEK_ECOUNTERS.CNT IS 'Счетчик файлов филиала';
COMMENT ON COLUMN BARS.NAEK_ECOUNTERS.KF IS '';




PROMPT *** Create  constraint CC_NAEKECOUNTERS_ECODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_ECOUNTERS MODIFY (ECODE CONSTRAINT CC_NAEKECOUNTERS_ECODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKECOUNTERS_DAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_ECOUNTERS MODIFY (DAT CONSTRAINT CC_NAEKECOUNTERS_DAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKECOUNTERS_CNT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_ECOUNTERS MODIFY (CNT CONSTRAINT CC_NAEKECOUNTERS_CNT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKECOUNTERS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_ECOUNTERS MODIFY (KF CONSTRAINT CC_NAEKECOUNTERS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKECOUNTERS_DAT_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_ECOUNTERS ADD CONSTRAINT CC_NAEKECOUNTERS_DAT_CC CHECK (trunc(dat)=dat) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_NAEKECOUNTERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_ECOUNTERS ADD CONSTRAINT PK_NAEKECOUNTERS PRIMARY KEY (KF, ECODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NAEKECOUNTERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NAEKECOUNTERS ON BARS.NAEK_ECOUNTERS (KF, ECODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NAEK_ECOUNTERS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on NAEK_ECOUNTERS  to ABS_ADMIN;
grant SELECT                                                                 on NAEK_ECOUNTERS  to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NAEK_ECOUNTERS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NAEK_ECOUNTERS  to BARS_DM;
grant SELECT                                                                 on NAEK_ECOUNTERS  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NAEK_ECOUNTERS  to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on NAEK_ECOUNTERS  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NAEK_ECOUNTERS.sql =========*** End **
PROMPT ===================================================================================== 
