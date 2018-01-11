

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/APP_REP.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to APP_REP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''APP_REP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''APP_REP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''APP_REP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table APP_REP ***
begin 
  execute immediate '
  CREATE TABLE BARS.APP_REP 
   (	CODEAPP VARCHAR2(30 CHAR), 
	CODEREP NUMBER(38,0), 
	APPROVE NUMBER(1,0), 
	ADATE1 DATE, 
	ADATE2 DATE, 
	RDATE1 DATE, 
	RDATE2 DATE, 
	REVERSE NUMBER(1,0), 
	REVOKED NUMBER(1,0), 
	GRANTOR NUMBER(38,0), 
	ACODE VARCHAR2(8)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to APP_REP ***
 exec bpa.alter_policies('APP_REP');


COMMENT ON TABLE BARS.APP_REP IS 'Печатные отчеты <->АРМ-ы';
COMMENT ON COLUMN BARS.APP_REP.CODEAPP IS 'Код приложения
';
COMMENT ON COLUMN BARS.APP_REP.CODEREP IS 'Код  отчета';
COMMENT ON COLUMN BARS.APP_REP.APPROVE IS 'Признак подтверждения';
COMMENT ON COLUMN BARS.APP_REP.ADATE1 IS 'Дата начала действия привилегии';
COMMENT ON COLUMN BARS.APP_REP.ADATE2 IS 'Дата окончания действия привилегии';
COMMENT ON COLUMN BARS.APP_REP.RDATE1 IS 'Дата начала бездействия привилегии';
COMMENT ON COLUMN BARS.APP_REP.RDATE2 IS 'Дата окончания бездействия привилегии';
COMMENT ON COLUMN BARS.APP_REP.REVERSE IS '';
COMMENT ON COLUMN BARS.APP_REP.REVOKED IS 'Пометка на удаление ресурса';
COMMENT ON COLUMN BARS.APP_REP.GRANTOR IS 'Идентификатор администратора';
COMMENT ON COLUMN BARS.APP_REP.ACODE IS 'Код доступа к отчету';




PROMPT *** Create  constraint PK_APPREP ***
begin   
 execute immediate '
  ALTER TABLE BARS.APP_REP ADD CONSTRAINT PK_APPREP PRIMARY KEY (CODEAPP, CODEREP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_APPREP_APPROVE ***
begin   
 execute immediate '
  ALTER TABLE BARS.APP_REP ADD CONSTRAINT CC_APPREP_APPROVE CHECK (approve in (0,1)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_APPREP_REVERSE ***
begin   
 execute immediate '
  ALTER TABLE BARS.APP_REP ADD CONSTRAINT CC_APPREP_REVERSE CHECK (reverse in (0,1)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_APPREP_REVOKED ***
begin   
 execute immediate '
  ALTER TABLE BARS.APP_REP ADD CONSTRAINT CC_APPREP_REVOKED CHECK (revoked in (0,1)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_APPREP_CODEAPP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.APP_REP MODIFY (CODEAPP CONSTRAINT CC_APPREP_CODEAPP_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_APPREP_CODEREP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.APP_REP MODIFY (CODEREP CONSTRAINT CC_APPREP_CODEREP_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_APPREP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_APPREP ON BARS.APP_REP (CODEAPP, CODEREP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  APP_REP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on APP_REP         to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on APP_REP         to APP_REP;
grant SELECT                                                                 on APP_REP         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on APP_REP         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on APP_REP         to BARS_DM;
grant SELECT                                                                 on APP_REP         to START1;
grant SELECT                                                                 on APP_REP         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on APP_REP         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on APP_REP         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/APP_REP.sql =========*** End *** =====
PROMPT ===================================================================================== 
