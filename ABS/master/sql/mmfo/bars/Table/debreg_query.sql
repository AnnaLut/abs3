

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEBREG_QUERY.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEBREG_QUERY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DEBREG_QUERY'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DEBREG_QUERY'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DEBREG_QUERY'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEBREG_QUERY ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEBREG_QUERY 
   (	REQUESTID NUMBER, 
	DEBNUM NUMBER, 
	EVENTTYPE NUMBER, 
	EVENTDATE DATE, 
	QUERYTYPE NUMBER, 
	PHASEID CHAR(1), 
	OKPO VARCHAR2(14), 
	NMK VARCHAR2(70), 
	SOS NUMBER DEFAULT 0, 
	FILENAME CHAR(12), 
	ILNUM NUMBER, 
	ERRORCODE CHAR(4) DEFAULT 0000, 
	ERRORCOMMENT VARCHAR2(255), 
	SIGNKEY VARCHAR2(6), 
	SIGN RAW(128), 
	FILEDATE DATE, 
	REC_PF NUMBER, 
	OSN VARCHAR2(250), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEBREG_QUERY ***
 exec bpa.alter_policies('DEBREG_QUERY');


COMMENT ON TABLE BARS.DEBREG_QUERY IS 'Запросы к Реестру должников';
COMMENT ON COLUMN BARS.DEBREG_QUERY.REQUESTID IS 'Для внутреннего пользования системы';
COMMENT ON COLUMN BARS.DEBREG_QUERY.DEBNUM IS 'Для внутреннего пользования системы (ссылка на ключ на запись в DEBREG_DEBUG)';
COMMENT ON COLUMN BARS.DEBREG_QUERY.EVENTTYPE IS 'Тип события';
COMMENT ON COLUMN BARS.DEBREG_QUERY.EVENTDATE IS 'Дата события';
COMMENT ON COLUMN BARS.DEBREG_QUERY.QUERYTYPE IS 'Тип запроса к Реестру';
COMMENT ON COLUMN BARS.DEBREG_QUERY.PHASEID IS 'Идентификатор фазы (для вертушки)';
COMMENT ON COLUMN BARS.DEBREG_QUERY.OKPO IS 'Идентификационный код клиента';
COMMENT ON COLUMN BARS.DEBREG_QUERY.NMK IS 'Наименование клиента';
COMMENT ON COLUMN BARS.DEBREG_QUERY.SOS IS 'Состояние запроса';
COMMENT ON COLUMN BARS.DEBREG_QUERY.FILENAME IS 'Имя файла запроса';
COMMENT ON COLUMN BARS.DEBREG_QUERY.ILNUM IS 'Порядковый номер ИС в файле';
COMMENT ON COLUMN BARS.DEBREG_QUERY.ERRORCODE IS 'Код ошибки по файлу запроса';
COMMENT ON COLUMN BARS.DEBREG_QUERY.ERRORCOMMENT IS 'Коментарий к ERRORCODE';
COMMENT ON COLUMN BARS.DEBREG_QUERY.SIGNKEY IS '';
COMMENT ON COLUMN BARS.DEBREG_QUERY.SIGN IS '';
COMMENT ON COLUMN BARS.DEBREG_QUERY.FILEDATE IS '';
COMMENT ON COLUMN BARS.DEBREG_QUERY.REC_PF IS 'номер строки в файле PF';
COMMENT ON COLUMN BARS.DEBREG_QUERY.OSN IS 'Данi про керiвникiв та засновникiв';
COMMENT ON COLUMN BARS.DEBREG_QUERY.KF IS '';




PROMPT *** Create  constraint XPK_DEBREG_QUERY ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEBREG_QUERY ADD CONSTRAINT XPK_DEBREG_QUERY PRIMARY KEY (REQUESTID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_DEBREG_QUERY_PHASEID ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEBREG_QUERY MODIFY (PHASEID CONSTRAINT NK_DEBREG_QUERY_PHASEID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_DEBREG_QUERY_SOS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEBREG_QUERY MODIFY (SOS CONSTRAINT NK_DEBREG_QUERY_SOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_DEBREG_QUERY_ERRORCODE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEBREG_QUERY MODIFY (ERRORCODE CONSTRAINT NK_DEBREG_QUERY_ERRORCODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEBREGQUERY_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEBREG_QUERY MODIFY (KF CONSTRAINT CC_DEBREGQUERY_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_DEBREG_QUERY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_DEBREG_QUERY ON BARS.DEBREG_QUERY (REQUESTID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DEBREG_QUERY ***
grant SELECT                                                                 on DEBREG_QUERY    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DEBREG_QUERY    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DEBREG_QUERY    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DEBREG_QUERY    to DEB_REG;
grant SELECT                                                                 on DEBREG_QUERY    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEBREG_QUERY.sql =========*** End *** 
PROMPT ===================================================================================== 
