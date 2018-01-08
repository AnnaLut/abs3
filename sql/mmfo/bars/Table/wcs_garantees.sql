

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_GARANTEES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_GARANTEES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_GARANTEES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_GARANTEES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_GARANTEES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_GARANTEES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_GARANTEES 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255), 
	GRT_TABLE_ID NUMBER, 
	SCOPY_ID VARCHAR2(100), 
	SURVEY_ID VARCHAR2(100), 
	COUNT_QID VARCHAR2(100), 
	STATUS_QID VARCHAR2(100), 
	WS_ID VARCHAR2(100) DEFAULT ''MAIN''
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_GARANTEES ***
 exec bpa.alter_policies('WCS_GARANTEES');


COMMENT ON TABLE BARS.WCS_GARANTEES IS 'Внутр. типы залогов';
COMMENT ON COLUMN BARS.WCS_GARANTEES.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.WCS_GARANTEES.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.WCS_GARANTEES.GRT_TABLE_ID IS 'Идентификатор типа обеспечения (таблицы деталей)';
COMMENT ON COLUMN BARS.WCS_GARANTEES.SCOPY_ID IS 'Карта сканкопий залога';
COMMENT ON COLUMN BARS.WCS_GARANTEES.SURVEY_ID IS 'Карта анкета залога';
COMMENT ON COLUMN BARS.WCS_GARANTEES.COUNT_QID IS 'Вопрос количество договоров обеспечения даного типа';
COMMENT ON COLUMN BARS.WCS_GARANTEES.STATUS_QID IS 'Вопрос состояние договора обеспечения даного типа';
COMMENT ON COLUMN BARS.WCS_GARANTEES.WS_ID IS 'Идентификатор рабочего пространства';




PROMPT *** Create  constraint CC_WCSGARANTEES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_GARANTEES MODIFY (NAME CONSTRAINT CC_WCSGARANTEES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSGARANTEES_CQID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_GARANTEES MODIFY (COUNT_QID CONSTRAINT CC_WCSGARANTEES_CQID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSGARANTEES_SQID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_GARANTEES MODIFY (STATUS_QID CONSTRAINT CC_WCSGARANTEES_SQID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSGARANTEES_WSID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_GARANTEES MODIFY (WS_ID CONSTRAINT CC_WCSGARANTEES_WSID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_WCSGARANTEES ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_GARANTEES ADD CONSTRAINT PK_WCSGARANTEES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSGARANTEES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSGARANTEES ON BARS.WCS_GARANTEES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_GARANTEES ***
grant SELECT                                                                 on WCS_GARANTEES   to BARSREADER_ROLE;
grant SELECT                                                                 on WCS_GARANTEES   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_GARANTEES   to BARS_DM;
grant SELECT                                                                 on WCS_GARANTEES   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_GARANTEES.sql =========*** End ***
PROMPT ===================================================================================== 
