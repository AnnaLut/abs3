

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAPROS_DUBLS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAPROS_DUBLS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAPROS_DUBLS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ZAPROS_DUBLS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ZAPROS_DUBLS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAPROS_DUBLS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAPROS_DUBLS 
   (	KODZ NUMBER, 
	ID NUMBER, 
	NAME VARCHAR2(65), 
	NAMEF VARCHAR2(254), 
	BINDVARS VARCHAR2(4000), 
	CREATE_STMT VARCHAR2(4000), 
	RPT_TEMPLATE VARCHAR2(12), 
	KODR NUMBER, 
	FORM_PROC VARCHAR2(254), 
	DEFAULT_VARS VARCHAR2(500), 
	CREATOR NUMBER(10,0), 
	BIND_SQL VARCHAR2(2000), 
	XSL_DATA CLOB, 
	LAST_UPDATED DATE, 
	TXT CLOB, 
	XSD_DATA CLOB, 
	XML_ENCODING VARCHAR2(12), 
	PKEY VARCHAR2(30), 
	ROWN NUMBER, 
	XSD_N CLOB, 
	XSL_N CLOB, 
	TXT_N CLOB
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (XSL_DATA) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (TXT) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (XSD_DATA) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (XSD_N) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (XSL_N) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (TXT_N) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAPROS_DUBLS ***
 exec bpa.alter_policies('ZAPROS_DUBLS');


COMMENT ON TABLE BARS.ZAPROS_DUBLS IS '';
COMMENT ON COLUMN BARS.ZAPROS_DUBLS.KODZ IS '';
COMMENT ON COLUMN BARS.ZAPROS_DUBLS.ID IS '';
COMMENT ON COLUMN BARS.ZAPROS_DUBLS.NAME IS '';
COMMENT ON COLUMN BARS.ZAPROS_DUBLS.NAMEF IS '';
COMMENT ON COLUMN BARS.ZAPROS_DUBLS.BINDVARS IS '';
COMMENT ON COLUMN BARS.ZAPROS_DUBLS.CREATE_STMT IS '';
COMMENT ON COLUMN BARS.ZAPROS_DUBLS.RPT_TEMPLATE IS '';
COMMENT ON COLUMN BARS.ZAPROS_DUBLS.KODR IS '';
COMMENT ON COLUMN BARS.ZAPROS_DUBLS.FORM_PROC IS '';
COMMENT ON COLUMN BARS.ZAPROS_DUBLS.DEFAULT_VARS IS '';
COMMENT ON COLUMN BARS.ZAPROS_DUBLS.CREATOR IS '';
COMMENT ON COLUMN BARS.ZAPROS_DUBLS.BIND_SQL IS '';
COMMENT ON COLUMN BARS.ZAPROS_DUBLS.XSL_DATA IS '';
COMMENT ON COLUMN BARS.ZAPROS_DUBLS.LAST_UPDATED IS '';
COMMENT ON COLUMN BARS.ZAPROS_DUBLS.TXT IS '';
COMMENT ON COLUMN BARS.ZAPROS_DUBLS.XSD_DATA IS '';
COMMENT ON COLUMN BARS.ZAPROS_DUBLS.XML_ENCODING IS '';
COMMENT ON COLUMN BARS.ZAPROS_DUBLS.PKEY IS '';
COMMENT ON COLUMN BARS.ZAPROS_DUBLS.ROWN IS '';
COMMENT ON COLUMN BARS.ZAPROS_DUBLS.XSD_N IS '';
COMMENT ON COLUMN BARS.ZAPROS_DUBLS.XSL_N IS '';
COMMENT ON COLUMN BARS.ZAPROS_DUBLS.TXT_N IS '';




PROMPT *** Create  constraint SYS_C0010271 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAPROS_DUBLS MODIFY (XML_ENCODING NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAPROS_DUBLS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAPROS_DUBLS    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAPROS_DUBLS    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAPROS_DUBLS.sql =========*** End *** 
PROMPT ===================================================================================== 
