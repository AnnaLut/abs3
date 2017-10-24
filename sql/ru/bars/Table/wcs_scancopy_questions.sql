

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SCANCOPY_QUESTIONS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SCANCOPY_QUESTIONS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SCANCOPY_QUESTIONS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SCANCOPY_QUESTIONS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SCANCOPY_QUESTIONS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SCANCOPY_QUESTIONS 
   (	SCOPY_ID VARCHAR2(100), 
	QUESTION_ID VARCHAR2(100), 
	TYPE_ID VARCHAR2(100), 
	IS_REQUIRED NUMBER DEFAULT 0, 
	ORD NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SCANCOPY_QUESTIONS ***
 exec bpa.alter_policies('WCS_SCANCOPY_QUESTIONS');


COMMENT ON TABLE BARS.WCS_SCANCOPY_QUESTIONS IS 'Вопросы карты сканкопий';
COMMENT ON COLUMN BARS.WCS_SCANCOPY_QUESTIONS.SCOPY_ID IS 'Идентификатор карты сканкопий';
COMMENT ON COLUMN BARS.WCS_SCANCOPY_QUESTIONS.QUESTION_ID IS 'Идентификатор вопроса сканкопии';
COMMENT ON COLUMN BARS.WCS_SCANCOPY_QUESTIONS.TYPE_ID IS 'Идентификатор типа сканкопии';
COMMENT ON COLUMN BARS.WCS_SCANCOPY_QUESTIONS.IS_REQUIRED IS 'Обязательный для заполнения';
COMMENT ON COLUMN BARS.WCS_SCANCOPY_QUESTIONS.ORD IS 'Порядок отображения';




PROMPT *** Create  constraint FK_SCOPYQUESTS_TID_SCTYPES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCANCOPY_QUESTIONS ADD CONSTRAINT FK_SCOPYQUESTS_TID_SCTYPES_ID FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.WCS_SCANCOPY_QUESTION_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SCOPYQUESTS_SID_SCOPIES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCANCOPY_QUESTIONS ADD CONSTRAINT FK_SCOPYQUESTS_SID_SCOPIES_ID FOREIGN KEY (SCOPY_ID)
	  REFERENCES BARS.WCS_SCANCOPIES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCOPYQUESTS_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCANCOPY_QUESTIONS ADD CONSTRAINT CC_SCOPYQUESTS_TYPEID_NN CHECK (TYPE_ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCOPYQUESTS_ORD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCANCOPY_QUESTIONS ADD CONSTRAINT CC_SCOPYQUESTS_ORD_NN CHECK (ORD IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCOPYQUESTIONS_ISREQUIRED ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCANCOPY_QUESTIONS ADD CONSTRAINT CC_SCOPYQUESTIONS_ISREQUIRED CHECK (is_required in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_WCSSCANCOPYQUESTIONS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCANCOPY_QUESTIONS ADD CONSTRAINT PK_WCSSCANCOPYQUESTIONS PRIMARY KEY (SCOPY_ID, QUESTION_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177157 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCANCOPY_QUESTIONS MODIFY (QUESTION_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177156 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCANCOPY_QUESTIONS MODIFY (SCOPY_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSSCANCOPYQUESTIONS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSSCANCOPYQUESTIONS ON BARS.WCS_SCANCOPY_QUESTIONS (SCOPY_ID, QUESTION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SCANCOPY_QUESTIONS.sql =========**
PROMPT ===================================================================================== 
