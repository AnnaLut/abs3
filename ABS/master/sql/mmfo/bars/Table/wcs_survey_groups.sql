

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SURVEY_GROUPS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SURVEY_GROUPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SURVEY_GROUPS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SURVEY_GROUPS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SURVEY_GROUPS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SURVEY_GROUPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SURVEY_GROUPS 
   (	SURVEY_ID VARCHAR2(100), 
	ID VARCHAR2(100), 
	NAME VARCHAR2(255), 
	DNSHOW_IF VARCHAR2(4000), 
	ORD NUMBER, 
	RESULT_QID VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SURVEY_GROUPS ***
 exec bpa.alter_policies('WCS_SURVEY_GROUPS');


COMMENT ON TABLE BARS.WCS_SURVEY_GROUPS IS 'Групы карты-анкеты';
COMMENT ON COLUMN BARS.WCS_SURVEY_GROUPS.SURVEY_ID IS 'Идентификатор карты-анкеты';
COMMENT ON COLUMN BARS.WCS_SURVEY_GROUPS.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.WCS_SURVEY_GROUPS.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.WCS_SURVEY_GROUPS.DNSHOW_IF IS 'Условие по которому не показывать группу';
COMMENT ON COLUMN BARS.WCS_SURVEY_GROUPS.ORD IS 'Порядок отображения';
COMMENT ON COLUMN BARS.WCS_SURVEY_GROUPS.RESULT_QID IS 'Идентификатор вопроса-результата заполнения группы';




PROMPT *** Create  constraint PK_SURVEYGROUPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SURVEY_GROUPS ADD CONSTRAINT PK_SURVEYGROUPS PRIMARY KEY (SURVEY_ID, ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SURGROUPS_SID_SURVEYS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SURVEY_GROUPS ADD CONSTRAINT FK_SURGROUPS_SID_SURVEYS_ID FOREIGN KEY (SURVEY_ID)
	  REFERENCES BARS.WCS_SURVEYS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SURGROUPS_RQID_QUESTS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SURVEY_GROUPS ADD CONSTRAINT FK_SURGROUPS_RQID_QUESTS_ID FOREIGN KEY (RESULT_QID)
	  REFERENCES BARS.WCS_QUESTIONS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURGROUPS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SURVEY_GROUPS MODIFY (NAME CONSTRAINT CC_SURGROUPS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURGROUPS_ORD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SURVEY_GROUPS MODIFY (ORD CONSTRAINT CC_SURGROUPS_ORD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SURVEYGROUPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SURVEYGROUPS ON BARS.WCS_SURVEY_GROUPS (SURVEY_ID, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SURVEY_GROUPS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SURVEY_GROUPS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_SURVEY_GROUPS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SURVEY_GROUPS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SURVEY_GROUPS.sql =========*** End
PROMPT ===================================================================================== 
