

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML_GATE.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML_GATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XML_GATE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''XML_GATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''XML_GATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML_GATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML_GATE 
   (	ID NUMBER, 
	PNAM VARCHAR2(20), 
	XML CLOB, 
	ERR VARCHAR2(254), 
	XML_O CLOB, 
	SOS NUMBER DEFAULT 0, 
	PARTITION_COUNT NUMBER, 
	DATF DATE, 
	DATP DATE, 
	NDOCTOTAL NUMBER, 
	NDOCPAYED NUMBER, 
	MESSTYPE VARCHAR2(20), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD 
 LOB (XML) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (XML_O) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML_GATE ***
 exec bpa.alter_policies('XML_GATE');


COMMENT ON TABLE BARS.XML_GATE IS 'Таблица входящих сообщений от клиент-банка';
COMMENT ON COLUMN BARS.XML_GATE.ID IS '';
COMMENT ON COLUMN BARS.XML_GATE.PNAM IS '';
COMMENT ON COLUMN BARS.XML_GATE.XML IS '';
COMMENT ON COLUMN BARS.XML_GATE.ERR IS '';
COMMENT ON COLUMN BARS.XML_GATE.XML_O IS '';
COMMENT ON COLUMN BARS.XML_GATE.SOS IS '';
COMMENT ON COLUMN BARS.XML_GATE.PARTITION_COUNT IS '';
COMMENT ON COLUMN BARS.XML_GATE.DATF IS 'Дата формирования файла (из заголовка файла)';
COMMENT ON COLUMN BARS.XML_GATE.DATP IS 'Дата обработки файла';
COMMENT ON COLUMN BARS.XML_GATE.NDOCTOTAL IS 'Загальна кiлькiсть документiв в файлi';
COMMENT ON COLUMN BARS.XML_GATE.NDOCPAYED IS 'Кiлькiсть документiв в файлi, що оплатилася';
COMMENT ON COLUMN BARS.XML_GATE.MESSTYPE IS '';
COMMENT ON COLUMN BARS.XML_GATE.KF IS '';




PROMPT *** Create  constraint XPK_XML_GATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_GATE ADD CONSTRAINT XPK_XML_GATE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XUK_XMLGATE_PNAME_DATF ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_GATE ADD CONSTRAINT XUK_XMLGATE_PNAME_DATF UNIQUE (PNAM, DATF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_XMLGATE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_GATE MODIFY (KF CONSTRAINT CC_XMLGATE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_XML_GATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_XML_GATE ON BARS.XML_GATE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XUK_XMLGATE_PNAME_DATF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XUK_XMLGATE_PNAME_DATF ON BARS.XML_GATE (PNAM, DATF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML_GATE ***
grant SELECT                                                                 on XML_GATE        to BARSREADER_ROLE;
grant SELECT                                                                 on XML_GATE        to BARS_DM;
grant SELECT                                                                 on XML_GATE        to KLBX;
grant SELECT                                                                 on XML_GATE        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on XML_GATE        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML_GATE.sql =========*** End *** ====
PROMPT ===================================================================================== 
