

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SURVEY_QUEST_DEP.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SURVEY_QUEST_DEP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SURVEY_QUEST_DEP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SURVEY_QUEST_DEP'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SURVEY_QUEST_DEP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SURVEY_QUEST_DEP ***
begin 
  execute immediate '
  CREATE TABLE BARS.SURVEY_QUEST_DEP 
   (	QUEST_ID NUMBER(38,0), 
	OPT_ID NUMBER(38,0), 
	CHILD_ID NUMBER(38,0), 
	CHILD_STATE NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SURVEY_QUEST_DEP ***
 exec bpa.alter_policies('SURVEY_QUEST_DEP');


COMMENT ON TABLE BARS.SURVEY_QUEST_DEP IS 'Связанные вопросы из анкет клиентов';
COMMENT ON COLUMN BARS.SURVEY_QUEST_DEP.QUEST_ID IS 'Код вопроса';
COMMENT ON COLUMN BARS.SURVEY_QUEST_DEP.OPT_ID IS 'Код ответа ,который меняет статус связанного вопроса';
COMMENT ON COLUMN BARS.SURVEY_QUEST_DEP.CHILD_ID IS 'Код связанного вопроса';
COMMENT ON COLUMN BARS.SURVEY_QUEST_DEP.CHILD_STATE IS 'Статус связанного вопроса';




PROMPT *** Create  constraint PK_SURVEYQDEP ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QUEST_DEP ADD CONSTRAINT PK_SURVEYQDEP PRIMARY KEY (QUEST_ID, CHILD_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYQDEP_CHILDSTATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QUEST_DEP ADD CONSTRAINT CC_SURVEYQDEP_CHILDSTATE CHECK (child_state IN (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYQDEP_QUESTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QUEST_DEP MODIFY (QUEST_ID CONSTRAINT CC_SURVEYQDEP_QUESTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYQDEP_OPTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QUEST_DEP MODIFY (OPT_ID CONSTRAINT CC_SURVEYQDEP_OPTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYQDEP_CHILDID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QUEST_DEP MODIFY (CHILD_ID CONSTRAINT CC_SURVEYQDEP_CHILDID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYQDEP_CHILDSTATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QUEST_DEP MODIFY (CHILD_STATE CONSTRAINT CC_SURVEYQDEP_CHILDSTATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_SURVEYQDEP ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_SURVEYQDEP ON BARS.SURVEY_QUEST_DEP (CHILD_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SURVEYQDEP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SURVEYQDEP ON BARS.SURVEY_QUEST_DEP (QUEST_ID, CHILD_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SURVEY_QUEST_DEP ***
grant SELECT                                                                 on SURVEY_QUEST_DEP to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SURVEY_QUEST_DEP to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SURVEY_QUEST_DEP to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SURVEY_QUEST_DEP to DPT_ADMIN;
grant SELECT                                                                 on SURVEY_QUEST_DEP to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SURVEY_QUEST_DEP to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SURVEY_QUEST_DEP.sql =========*** End 
PROMPT ===================================================================================== 
