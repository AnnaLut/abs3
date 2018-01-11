

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REPORTS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REPORTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REPORTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REPORTS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''REPORTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REPORTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.REPORTS 
   (	ID NUMBER(38,0), 
	NAME VARCHAR2(35), 
	DESCRIPTION VARCHAR2(210), 
	FORM VARCHAR2(35), 
	PARAM VARCHAR2(254), 
	NDAT NUMBER(5,0), 
	WT VARCHAR2(1), 
	MASK VARCHAR2(12), 
	NAMEW VARCHAR2(35), 
	PATH VARCHAR2(225), 
	WT2 VARCHAR2(1), 
	IDF NUMBER(38,0), 
	NODEL NUMBER(1,0), 
	DBTYPE VARCHAR2(3), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	USEARC NUMBER(1,0) DEFAULT 0, 
	EMPTYFILES NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REPORTS ***
 exec bpa.alter_policies('REPORTS');


COMMENT ON TABLE BARS.REPORTS IS 'Печатные отчеты АБС';
COMMENT ON COLUMN BARS.REPORTS.ID IS 'Номер';
COMMENT ON COLUMN BARS.REPORTS.NAME IS 'Имя файла Шаблона отчёта';
COMMENT ON COLUMN BARS.REPORTS.DESCRIPTION IS 'Название отчета';
COMMENT ON COLUMN BARS.REPORTS.FORM IS 'Форма';
COMMENT ON COLUMN BARS.REPORTS.PARAM IS 'Параметры';
COMMENT ON COLUMN BARS.REPORTS.NDAT IS 'Кол-во дат';
COMMENT ON COLUMN BARS.REPORTS.WT IS 'Не используется';
COMMENT ON COLUMN BARS.REPORTS.MASK IS 'Маска';
COMMENT ON COLUMN BARS.REPORTS.NAMEW IS '';
COMMENT ON COLUMN BARS.REPORTS.PATH IS 'Похоже не используется';
COMMENT ON COLUMN BARS.REPORTS.WT2 IS 'Похоже не используется';
COMMENT ON COLUMN BARS.REPORTS.IDF IS 'Код папки отчетов';
COMMENT ON COLUMN BARS.REPORTS.NODEL IS 'НЕ удалять пустые строки отчета';
COMMENT ON COLUMN BARS.REPORTS.DBTYPE IS 'Тип БД';
COMMENT ON COLUMN BARS.REPORTS.BRANCH IS '';
COMMENT ON COLUMN BARS.REPORTS.USEARC IS '';
COMMENT ON COLUMN BARS.REPORTS.EMPTYFILES IS 'Создавать или нет файл, если данных отчета не выбрано (1-да/нет)';




PROMPT *** Create  constraint CC_REPORTS_EMPTF ***
begin   
 execute immediate '
  ALTER TABLE BARS.REPORTS ADD CONSTRAINT CC_REPORTS_EMPTF CHECK ( emptyfiles in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_REPORTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.REPORTS ADD CONSTRAINT PK_REPORTS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REPORTS_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REPORTS MODIFY (ID CONSTRAINT CC_REPORTS_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REPORTS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REPORTS MODIFY (NAME CONSTRAINT CC_REPORTS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REPORTS_DESC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REPORTS MODIFY (DESCRIPTION CONSTRAINT CC_REPORTS_DESC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REPORTS_FORM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REPORTS MODIFY (FORM CONSTRAINT CC_REPORTS_FORM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REPORTS_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REPORTS MODIFY (BRANCH CONSTRAINT CC_REPORTS_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REPORTS_USEARC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REPORTS MODIFY (USEARC CONSTRAINT CC_REPORTS_USEARC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REPORTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REPORTS ON BARS.REPORTS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REPORTS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on REPORTS         to ABS_ADMIN;
grant SELECT                                                                 on REPORTS         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REPORTS         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REPORTS         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on REPORTS         to REPORTS;
grant SELECT                                                                 on REPORTS         to START1;
grant SELECT                                                                 on REPORTS         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REPORTS         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on REPORTS         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REPORTS.sql =========*** End *** =====
PROMPT ===================================================================================== 
