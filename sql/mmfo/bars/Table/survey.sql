

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SURVEY.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SURVEY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SURVEY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SURVEY'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SURVEY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SURVEY ***
begin 
  execute immediate '
  CREATE TABLE BARS.SURVEY 
   (	SURVEY_ID NUMBER(38,0), 
	SURVEY_NAME VARCHAR2(100), 
	CUSTTYPE NUMBER(1,0), 
	TEMPLATE_ID VARCHAR2(35), 
	ACTIVITY NUMBER(1,0), 
	SURVEY_MULTI NUMBER(1,0), 
	SURVEY_CODE VARCHAR2(16)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SURVEY ***
 exec bpa.alter_policies('SURVEY');


COMMENT ON TABLE BARS.SURVEY IS 'Анкеты клиентов';
COMMENT ON COLUMN BARS.SURVEY.SURVEY_ID IS 'Идентификатор анкеты';
COMMENT ON COLUMN BARS.SURVEY.SURVEY_NAME IS 'Наименование';
COMMENT ON COLUMN BARS.SURVEY.CUSTTYPE IS 'Тип клиента (ФЛ/ЮЛ/БН)';
COMMENT ON COLUMN BARS.SURVEY.TEMPLATE_ID IS 'Код шаблона';
COMMENT ON COLUMN BARS.SURVEY.ACTIVITY IS 'Признак активности';
COMMENT ON COLUMN BARS.SURVEY.SURVEY_MULTI IS 'Признак многократного анкетирования';
COMMENT ON COLUMN BARS.SURVEY.SURVEY_CODE IS 'Программный идентификатор анкеты';




PROMPT *** Create  constraint CC_SURVEY_SURVEYNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY MODIFY (SURVEY_NAME CONSTRAINT CC_SURVEY_SURVEYNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEY_CUSTTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY MODIFY (CUSTTYPE CONSTRAINT CC_SURVEY_CUSTTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEY_TEMPLATEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY MODIFY (TEMPLATE_ID CONSTRAINT CC_SURVEY_TEMPLATEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEY_ACTIVITY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY MODIFY (ACTIVITY CONSTRAINT CC_SURVEY_ACTIVITY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEY_SURVEYMULTI_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY MODIFY (SURVEY_MULTI CONSTRAINT CC_SURVEY_SURVEYMULTI_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEY_SURVEYMULTI ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY ADD CONSTRAINT CC_SURVEY_SURVEYMULTI CHECK (survey_multi IN (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SURVEY ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY ADD CONSTRAINT PK_SURVEY PRIMARY KEY (SURVEY_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEY_ACTIVITY ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY ADD CONSTRAINT CC_SURVEY_ACTIVITY CHECK (activity IN (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_SURVEY ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY ADD CONSTRAINT UK_SURVEY UNIQUE (ACTIVITY, SURVEY_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_SURVEY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_SURVEY ON BARS.SURVEY (ACTIVITY, SURVEY_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SURVEY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SURVEY ON BARS.SURVEY (SURVEY_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SURVEY ***
grant SELECT                                                                 on SURVEY          to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SURVEY          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SURVEY          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SURVEY          to DPT_ADMIN;
grant SELECT                                                                 on SURVEY          to RCC_DEAL;
grant SELECT                                                                 on SURVEY          to START1;
grant SELECT                                                                 on SURVEY          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SURVEY          to WR_ALL_RIGHTS;
grant SELECT                                                                 on SURVEY          to WR_CREDIT;
grant FLASHBACK,SELECT                                                       on SURVEY          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SURVEY.sql =========*** End *** ======
PROMPT ===================================================================================== 
