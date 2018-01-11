

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TICKETS_ADVERTISING.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TICKETS_ADVERTISING ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TICKETS_ADVERTISING'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TICKETS_ADVERTISING'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''TICKETS_ADVERTISING'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TICKETS_ADVERTISING ***
begin 
  execute immediate '
  CREATE TABLE BARS.TICKETS_ADVERTISING 
   (	ID NUMBER, 
	NAME VARCHAR2(200), 
	DAT_BEGIN DATE, 
	DAT_END DATE, 
	ACTIVE VARCHAR2(1), 
	DATA_BODY_HTML CLOB, 
	DATA_BODY BLOB, 
	DESCRIPTION VARCHAR2(4000), 
	TRANSACTION_CODE_LIST VARCHAR2(4000), 
	DEF_FLAG VARCHAR2(1), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	WIDTH NUMBER, 
	HEIGHT NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (DATA_BODY_HTML) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (DATA_BODY) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TICKETS_ADVERTISING ***
 exec bpa.alter_policies('TICKETS_ADVERTISING');


COMMENT ON TABLE BARS.TICKETS_ADVERTISING IS 'Таблиця рекламних блоків для друку на тікетах';
COMMENT ON COLUMN BARS.TICKETS_ADVERTISING.HEIGHT IS '������ ���������� ����� � �������';
COMMENT ON COLUMN BARS.TICKETS_ADVERTISING.ID IS 'Ід. реклами';
COMMENT ON COLUMN BARS.TICKETS_ADVERTISING.NAME IS 'Назва рекламного блоку';
COMMENT ON COLUMN BARS.TICKETS_ADVERTISING.DAT_BEGIN IS 'Дата початку дії';
COMMENT ON COLUMN BARS.TICKETS_ADVERTISING.DAT_END IS 'Дата закінчення дії';
COMMENT ON COLUMN BARS.TICKETS_ADVERTISING.ACTIVE IS 'Признак активності';
COMMENT ON COLUMN BARS.TICKETS_ADVERTISING.DATA_BODY_HTML IS 'Тіло самої реклами в HTML';
COMMENT ON COLUMN BARS.TICKETS_ADVERTISING.DATA_BODY IS 'Тіло самої реклами в вигляді картинки';
COMMENT ON COLUMN BARS.TICKETS_ADVERTISING.DESCRIPTION IS 'Довільний опис';
COMMENT ON COLUMN BARS.TICKETS_ADVERTISING.TRANSACTION_CODE_LIST IS 'Список операцій для яких виводити рекламу';
COMMENT ON COLUMN BARS.TICKETS_ADVERTISING.DEF_FLAG IS 'Признак реклами по зхамовчуванню';
COMMENT ON COLUMN BARS.TICKETS_ADVERTISING.KF IS '';
COMMENT ON COLUMN BARS.TICKETS_ADVERTISING.WIDTH IS '������ ���������� ����� � �������';




PROMPT *** Create  constraint SYS_C0011613 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TICKETS_ADVERTISING ADD CHECK (active in(''Y'',''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0011614 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TICKETS_ADVERTISING ADD CHECK (def_flag in(''Y'',''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TICKETS_ADVERTISING ***
begin   
 execute immediate '
  ALTER TABLE BARS.TICKETS_ADVERTISING ADD CONSTRAINT PK_TICKETS_ADVERTISING PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0011616 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TICKETS_ADVERTISING ADD CHECK (active in(''Y'',''N'')) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0011617 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TICKETS_ADVERTISING ADD CHECK (def_flag in(''Y'',''N'')) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TICKETS_ADVERTISING ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TICKETS_ADVERTISING ON BARS.TICKETS_ADVERTISING (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TICKETS_ADVERTISING ***
grant SELECT                                                                 on TICKETS_ADVERTISING to BARSREADER_ROLE;
grant SELECT                                                                 on TICKETS_ADVERTISING to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TICKETS_ADVERTISING to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TICKETS_ADVERTISING.sql =========*** E
PROMPT ===================================================================================== 
