

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DWH_CBIREP_QUERIES_DATA.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DWH_CBIREP_QUERIES_DATA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DWH_CBIREP_QUERIES_DATA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DWH_CBIREP_QUERIES_DATA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DWH_CBIREP_QUERIES_DATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.DWH_CBIREP_QUERIES_DATA 
   (	ID NUMBER, 
	CBIREP_QUERIES_ID NUMBER, 
	RESULT_FILE_NAME VARCHAR2(254), 
	LENGTH_FILE NUMBER, 
	FIL BLOB
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSDYND 
 LOB (FIL) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
  PARTITION BY RANGE (CBIREP_QUERIES_ID) INTERVAL (1) 
 (PARTITION INITIAL_PARTITION  VALUES LESS THAN (1) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSDYND 
 LOB (FIL) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DWH_CBIREP_QUERIES_DATA ***
 exec bpa.alter_policies('DWH_CBIREP_QUERIES_DATA');


COMMENT ON TABLE BARS.DWH_CBIREP_QUERIES_DATA IS '';
COMMENT ON COLUMN BARS.DWH_CBIREP_QUERIES_DATA.ID IS '';
COMMENT ON COLUMN BARS.DWH_CBIREP_QUERIES_DATA.CBIREP_QUERIES_ID IS '';
COMMENT ON COLUMN BARS.DWH_CBIREP_QUERIES_DATA.RESULT_FILE_NAME IS '';
COMMENT ON COLUMN BARS.DWH_CBIREP_QUERIES_DATA.LENGTH_FILE IS '';
COMMENT ON COLUMN BARS.DWH_CBIREP_QUERIES_DATA.FIL IS '';



PROMPT *** Create  grants  DWH_CBIREP_QUERIES_DATA ***
grant SELECT                                                                 on DWH_CBIREP_QUERIES_DATA to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DWH_CBIREP_QUERIES_DATA to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DWH_CBIREP_QUERIES_DATA to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DWH_CBIREP_QUERIES_DATA.sql =========*
PROMPT ===================================================================================== 
