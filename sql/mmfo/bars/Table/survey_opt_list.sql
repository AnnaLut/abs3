

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SURVEY_OPT_LIST.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SURVEY_OPT_LIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SURVEY_OPT_LIST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SURVEY_OPT_LIST'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SURVEY_OPT_LIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SURVEY_OPT_LIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.SURVEY_OPT_LIST 
   (	LIST_ID NUMBER(38,0), 
	LIST_NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SURVEY_OPT_LIST ***
 exec bpa.alter_policies('SURVEY_OPT_LIST');


COMMENT ON TABLE BARS.SURVEY_OPT_LIST IS 'Списки вариантов ответов';
COMMENT ON COLUMN BARS.SURVEY_OPT_LIST.LIST_ID IS 'Код списка';
COMMENT ON COLUMN BARS.SURVEY_OPT_LIST.LIST_NAME IS 'Наименование списка';




PROMPT *** Create  constraint PK_SURVEYOPTLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_OPT_LIST ADD CONSTRAINT PK_SURVEYOPTLIST PRIMARY KEY (LIST_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYOPTLIST_LISTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_OPT_LIST MODIFY (LIST_ID CONSTRAINT CC_SURVEYOPTLIST_LISTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYOPTLIST_LISTNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_OPT_LIST MODIFY (LIST_NAME CONSTRAINT CC_SURVEYOPTLIST_LISTNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SURVEYOPTLIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SURVEYOPTLIST ON BARS.SURVEY_OPT_LIST (LIST_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SURVEY_OPT_LIST ***
grant SELECT                                                                 on SURVEY_OPT_LIST to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SURVEY_OPT_LIST to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SURVEY_OPT_LIST to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SURVEY_OPT_LIST to DPT_ADMIN;
grant SELECT                                                                 on SURVEY_OPT_LIST to START1;
grant SELECT                                                                 on SURVEY_OPT_LIST to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SURVEY_OPT_LIST to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SURVEY_OPT_LIST to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SURVEY_OPT_LIST.sql =========*** End *
PROMPT ===================================================================================== 
