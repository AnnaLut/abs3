

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SURVEY_QFMT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SURVEY_QFMT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SURVEY_QFMT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SURVEY_QFMT'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SURVEY_QFMT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SURVEY_QFMT ***
begin 
  execute immediate '
  CREATE TABLE BARS.SURVEY_QFMT 
   (	FMT_ID NUMBER(38,0), 
	FMT_NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SURVEY_QFMT ***
 exec bpa.alter_policies('SURVEY_QFMT');


COMMENT ON TABLE BARS.SURVEY_QFMT IS 'Форматы ответов на вопросы анкет клиентов';
COMMENT ON COLUMN BARS.SURVEY_QFMT.FMT_ID IS 'Идентификатор формата';
COMMENT ON COLUMN BARS.SURVEY_QFMT.FMT_NAME IS 'Наименование формата';




PROMPT *** Create  constraint PK_SURVEYQFMT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QFMT ADD CONSTRAINT PK_SURVEYQFMT PRIMARY KEY (FMT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYQFMT_FMTNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QFMT MODIFY (FMT_NAME CONSTRAINT CC_SURVEYQFMT_FMTNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SURVEYQFMT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SURVEYQFMT ON BARS.SURVEY_QFMT (FMT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SURVEY_QFMT ***
grant SELECT                                                                 on SURVEY_QFMT     to BARSREADER_ROLE;
grant SELECT                                                                 on SURVEY_QFMT     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SURVEY_QFMT     to BARS_DM;
grant SELECT                                                                 on SURVEY_QFMT     to DPT_ADMIN;
grant SELECT                                                                 on SURVEY_QFMT     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SURVEY_QFMT     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SURVEY_QFMT.sql =========*** End *** =
PROMPT ===================================================================================== 
