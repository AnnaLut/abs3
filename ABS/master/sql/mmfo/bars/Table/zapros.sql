

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAPROS.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAPROS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAPROS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ZAPROS'', ''FILIAL'' , ''P'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''ZAPROS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAPROS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAPROS 
   (	KODZ NUMBER(38,0), 
	ID NUMBER(38,0), 
	NAME VARCHAR2(65), 
	NAMEF VARCHAR2(254), 
	BINDVARS VARCHAR2(4000), 
	CREATE_STMT VARCHAR2(4000), 
	RPT_TEMPLATE VARCHAR2(12), 
	KODR NUMBER(38,0), 
	FORM_PROC VARCHAR2(254), 
	DEFAULT_VARS VARCHAR2(500), 
	CREATOR NUMBER(38,0), 
	BIND_SQL VARCHAR2(2000), 
	XSL_DATA CLOB, 
	TXT CLOB, 
	XSD_DATA CLOB, 
	XML_ENCODING VARCHAR2(12) DEFAULT ''CL8MSWIN1251'', 
	PKEY VARCHAR2(30), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	LAST_UPDATED DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD 
 LOB (XSL_DATA) STORE AS BASICFILE (
  TABLESPACE BRSSMLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (TXT) STORE AS BASICFILE (
  TABLESPACE BRSSMLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (XSD_DATA) STORE AS BASICFILE (
  TABLESPACE BRSSMLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAPROS ***
 exec bpa.alter_policies('ZAPROS');


COMMENT ON TABLE BARS.ZAPROS IS 'Таблица запросов';
COMMENT ON COLUMN BARS.ZAPROS.KODZ IS 'Код';
COMMENT ON COLUMN BARS.ZAPROS.ID IS 'Идентификатор пользователя';
COMMENT ON COLUMN BARS.ZAPROS.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.ZAPROS.NAMEF IS 'Имя файла';
COMMENT ON COLUMN BARS.ZAPROS.BINDVARS IS 'Бинд переменные';
COMMENT ON COLUMN BARS.ZAPROS.CREATE_STMT IS '';
COMMENT ON COLUMN BARS.ZAPROS.RPT_TEMPLATE IS 'Код шаблона';
COMMENT ON COLUMN BARS.ZAPROS.KODR IS 'Код связанного запроса';
COMMENT ON COLUMN BARS.ZAPROS.FORM_PROC IS '';
COMMENT ON COLUMN BARS.ZAPROS.DEFAULT_VARS IS 'Умолчательные значения переменных';
COMMENT ON COLUMN BARS.ZAPROS.CREATOR IS 'Идентификатор пользователя, который создал';
COMMENT ON COLUMN BARS.ZAPROS.BIND_SQL IS '';
COMMENT ON COLUMN BARS.ZAPROS.XSL_DATA IS '';
COMMENT ON COLUMN BARS.ZAPROS.TXT IS 'Текст запроса';
COMMENT ON COLUMN BARS.ZAPROS.XSD_DATA IS '';
COMMENT ON COLUMN BARS.ZAPROS.XML_ENCODING IS '';
COMMENT ON COLUMN BARS.ZAPROS.PKEY IS '';
COMMENT ON COLUMN BARS.ZAPROS.BRANCH IS '';
COMMENT ON COLUMN BARS.ZAPROS.LAST_UPDATED IS '';




PROMPT *** Create  constraint XUK_ZAPROS_KODZ ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAPROS ADD CONSTRAINT XUK_ZAPROS_KODZ UNIQUE (KODZ)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_ZAPROS_PKEY ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAPROS ADD CONSTRAINT XPK_ZAPROS_PKEY PRIMARY KEY (PKEY)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAPROS_KODZ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAPROS MODIFY (KODZ CONSTRAINT CC_ZAPROS_KODZ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAPROS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAPROS MODIFY (NAME CONSTRAINT CC_ZAPROS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_ZAPROS_ENCODING ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAPROS MODIFY (XML_ENCODING CONSTRAINT NN_ZAPROS_ENCODING NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAPROS_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAPROS MODIFY (BRANCH CONSTRAINT CC_ZAPROS_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ZAPROS_PKEY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ZAPROS_PKEY ON BARS.ZAPROS (PKEY) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ZAPROS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ZAPROS ON BARS.ZAPROS (KODZ) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAPROS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAPROS          to ABS_ADMIN;
grant SELECT                                                                 on ZAPROS          to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAPROS          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAPROS          to BARS_DM;
grant SELECT                                                                 on ZAPROS          to DPT_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAPROS          to START1;
grant SELECT                                                                 on ZAPROS          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAPROS          to WR_ALL_RIGHTS;
grant SELECT                                                                 on ZAPROS          to WR_CBIREP;
grant FLASHBACK,SELECT                                                       on ZAPROS          to WR_REFREAD;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAPROS          to ZAPROS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAPROS.sql =========*** End *** ======
PROMPT ===================================================================================== 
