

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RS_TMP_SESSION_DATA.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RS_TMP_SESSION_DATA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RS_TMP_SESSION_DATA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''RS_TMP_SESSION_DATA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''RS_TMP_SESSION_DATA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RS_TMP_SESSION_DATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.RS_TMP_SESSION_DATA 
   (	SESSION_ID NUMBER(38,0), 
	QUERY_ID NUMBER(38,0), 
	INT_SQL VARCHAR2(4000), 
	TEMPLATE VARCHAR2(12), 
	DATE1 DATE, 
	DATE2 DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RS_TMP_SESSION_DATA ***
 exec bpa.alter_policies('RS_TMP_SESSION_DATA');


COMMENT ON TABLE BARS.RS_TMP_SESSION_DATA IS 'Система формирования каталогизированных запросов для WEB. Сессии формирования отчетов.';
COMMENT ON COLUMN BARS.RS_TMP_SESSION_DATA.SESSION_ID IS 'Идентификатор сессии';
COMMENT ON COLUMN BARS.RS_TMP_SESSION_DATA.QUERY_ID IS 'Идентификатор кат. запроса';
COMMENT ON COLUMN BARS.RS_TMP_SESSION_DATA.INT_SQL IS 'SQL для выборки данных из временной таблицы RS_TMP_REPORT_DATA';
COMMENT ON COLUMN BARS.RS_TMP_SESSION_DATA.TEMPLATE IS 'Имя файла шаблона отчета';
COMMENT ON COLUMN BARS.RS_TMP_SESSION_DATA.DATE1 IS 'Дата начала формирования отчета (дата с)';
COMMENT ON COLUMN BARS.RS_TMP_SESSION_DATA.DATE2 IS 'Дата окончания формирования отчета (дата по)';




PROMPT *** Create  constraint CC_RSTMPSESSDATA_QID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RS_TMP_SESSION_DATA MODIFY (QUERY_ID CONSTRAINT CC_RSTMPSESSDATA_QID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RSTMPSESSDATA_SQL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RS_TMP_SESSION_DATA MODIFY (INT_SQL CONSTRAINT CC_RSTMPSESSDATA_SQL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RSTMPSESSDATA_TPL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RS_TMP_SESSION_DATA MODIFY (TEMPLATE CONSTRAINT CC_RSTMPSESSDATA_TPL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_RSTMPSESSDATA ***
begin   
 execute immediate '
  ALTER TABLE BARS.RS_TMP_SESSION_DATA ADD CONSTRAINT PK_RSTMPSESSDATA PRIMARY KEY (SESSION_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_RSTMPSESSDATA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_RSTMPSESSDATA ON BARS.RS_TMP_SESSION_DATA (SESSION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RS_TMP_SESSION_DATA ***
grant DELETE,INSERT,SELECT,UPDATE                                            on RS_TMP_SESSION_DATA to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on RS_TMP_SESSION_DATA to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RS_TMP_SESSION_DATA to BARS_DM;
grant SELECT                                                                 on RS_TMP_SESSION_DATA to RS;
grant SELECT                                                                 on RS_TMP_SESSION_DATA to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RS_TMP_SESSION_DATA to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RS_TMP_SESSION_DATA.sql =========*** E
PROMPT ===================================================================================== 
