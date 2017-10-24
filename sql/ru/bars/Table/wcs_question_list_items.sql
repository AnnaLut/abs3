

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_QUESTION_LIST_ITEMS.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_QUESTION_LIST_ITEMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_QUESTION_LIST_ITEMS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_QUESTION_LIST_ITEMS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_QUESTION_LIST_ITEMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_QUESTION_LIST_ITEMS 
   (	QUESTION_ID VARCHAR2(100), 
	ORD NUMBER, 
	TEXT VARCHAR2(255), 
	VISIBLE NUMBER, 
	VISIBLE_ORD NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_QUESTION_LIST_ITEMS ***
 exec bpa.alter_policies('WCS_QUESTION_LIST_ITEMS');


COMMENT ON TABLE BARS.WCS_QUESTION_LIST_ITEMS IS 'Описание списочного вопроса';
COMMENT ON COLUMN BARS.WCS_QUESTION_LIST_ITEMS.QUESTION_ID IS 'Идентификатор вопроса';
COMMENT ON COLUMN BARS.WCS_QUESTION_LIST_ITEMS.ORD IS 'Порядок в списке';
COMMENT ON COLUMN BARS.WCS_QUESTION_LIST_ITEMS.TEXT IS 'Текст';
COMMENT ON COLUMN BARS.WCS_QUESTION_LIST_ITEMS.VISIBLE IS 'Флаг активности записи';
COMMENT ON COLUMN BARS.WCS_QUESTION_LIST_ITEMS.VISIBLE_ORD IS 'Порядок визуального отображения';




PROMPT *** Create  constraint CC_QUESTLISTITEMS_TEXT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_QUESTION_LIST_ITEMS ADD CONSTRAINT CC_QUESTLISTITEMS_TEXT_NN CHECK (TEXT IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_QLISTITEMS_VISIBLE ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_QUESTION_LIST_ITEMS ADD CONSTRAINT CC_QLISTITEMS_VISIBLE CHECK (visible in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_WCSQUESTIONLISTITEMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_QUESTION_LIST_ITEMS ADD CONSTRAINT PK_WCSQUESTIONLISTITEMS PRIMARY KEY (QUESTION_ID, ORD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177013 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_QUESTION_LIST_ITEMS MODIFY (ORD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177012 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_QUESTION_LIST_ITEMS MODIFY (QUESTION_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSQUESTIONLISTITEMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSQUESTIONLISTITEMS ON BARS.WCS_QUESTION_LIST_ITEMS (QUESTION_ID, ORD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_QUESTION_LIST_ITEMS.sql =========*
PROMPT ===================================================================================== 
