

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RNBU_REPORT_HEADER.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RNBU_REPORT_HEADER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RNBU_REPORT_HEADER'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''RNBU_REPORT_HEADER'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''RNBU_REPORT_HEADER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RNBU_REPORT_HEADER ***
begin 
  execute immediate '
  CREATE TABLE BARS.RNBU_REPORT_HEADER 
   (	HEADER_ID NUMBER(38,0), 
	FORM_COD VARCHAR2(2), 
	FILE_KEY VARCHAR2(2), 
	NEXT_DATE VARCHAR2(8), 
	INIT_DATE VARCHAR2(8), 
	LAST_DATE VARCHAR2(8), 
	FORM_DATE VARCHAR2(8), 
	FORM_TIME VARCHAR2(6), 
	MFO VARCHAR2(10), 
	UNIT VARCHAR2(2), 
	INF_ROW_COUNT NUMBER(38,0), 
	FILE_NAME VARCHAR2(12), 
	SPARE1 VARCHAR2(6), 
	SPARE2 VARCHAR2(64)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RNBU_REPORT_HEADER ***
 exec bpa.alter_policies('RNBU_REPORT_HEADER');


COMMENT ON TABLE BARS.RNBU_REPORT_HEADER IS '';
COMMENT ON COLUMN BARS.RNBU_REPORT_HEADER.HEADER_ID IS '';
COMMENT ON COLUMN BARS.RNBU_REPORT_HEADER.FORM_COD IS '';
COMMENT ON COLUMN BARS.RNBU_REPORT_HEADER.FILE_KEY IS '';
COMMENT ON COLUMN BARS.RNBU_REPORT_HEADER.NEXT_DATE IS '';
COMMENT ON COLUMN BARS.RNBU_REPORT_HEADER.INIT_DATE IS '';
COMMENT ON COLUMN BARS.RNBU_REPORT_HEADER.LAST_DATE IS '';
COMMENT ON COLUMN BARS.RNBU_REPORT_HEADER.FORM_DATE IS '';
COMMENT ON COLUMN BARS.RNBU_REPORT_HEADER.FORM_TIME IS '';
COMMENT ON COLUMN BARS.RNBU_REPORT_HEADER.MFO IS '';
COMMENT ON COLUMN BARS.RNBU_REPORT_HEADER.UNIT IS '';
COMMENT ON COLUMN BARS.RNBU_REPORT_HEADER.INF_ROW_COUNT IS '';
COMMENT ON COLUMN BARS.RNBU_REPORT_HEADER.FILE_NAME IS '';
COMMENT ON COLUMN BARS.RNBU_REPORT_HEADER.SPARE1 IS '';
COMMENT ON COLUMN BARS.RNBU_REPORT_HEADER.SPARE2 IS '';



PROMPT *** Create  grants  RNBU_REPORT_HEADER ***
grant SELECT                                                                 on RNBU_REPORT_HEADER to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on RNBU_REPORT_HEADER to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on RNBU_REPORT_HEADER to START1;
grant SELECT                                                                 on RNBU_REPORT_HEADER to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RNBU_REPORT_HEADER.sql =========*** En
PROMPT ===================================================================================== 
