

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_QUESTIONS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_QUESTIONS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_QUESTIONS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_QUESTIONS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_QUESTIONS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_QUESTIONS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_QUESTIONS 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255), 
	TYPE_ID VARCHAR2(100), 
	IS_CALCABLE NUMBER, 
	CALC_PROC VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_QUESTIONS ***
 exec bpa.alter_policies('WCS_QUESTIONS');


COMMENT ON TABLE BARS.WCS_QUESTIONS IS 'Вопросы';
COMMENT ON COLUMN BARS.WCS_QUESTIONS.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.WCS_QUESTIONS.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.WCS_QUESTIONS.TYPE_ID IS 'Идентификатор типа';
COMMENT ON COLUMN BARS.WCS_QUESTIONS.IS_CALCABLE IS 'Вычисляемое ли поле';
COMMENT ON COLUMN BARS.WCS_QUESTIONS.CALC_PROC IS 'Текст вычисления';




PROMPT *** Create  constraint CC_WCSQUESTIONS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_QUESTIONS MODIFY (NAME CONSTRAINT CC_WCSQUESTIONS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSQUESTIONS_ISCALCABLE ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_QUESTIONS ADD CONSTRAINT CC_WCSQUESTIONS_ISCALCABLE CHECK (is_calcable in (0, 1) or is_calcable is null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_WCSQUESTIONS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_QUESTIONS ADD CONSTRAINT PK_WCSQUESTIONS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UC_QUESTS_ID_TID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_QUESTIONS ADD CONSTRAINT UC_QUESTS_ID_TID UNIQUE (ID, TYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSQUESTIONS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSQUESTIONS ON BARS.WCS_QUESTIONS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UC_QUESTS_ID_TID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UC_QUESTS_ID_TID ON BARS.WCS_QUESTIONS (ID, TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_QUESTIONS ***
grant SELECT                                                                 on WCS_QUESTIONS   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_QUESTIONS   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_QUESTIONS   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_QUESTIONS   to START1;
grant SELECT                                                                 on WCS_QUESTIONS   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_QUESTIONS.sql =========*** End ***
PROMPT ===================================================================================== 
