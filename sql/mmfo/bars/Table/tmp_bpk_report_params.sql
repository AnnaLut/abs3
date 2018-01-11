

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_BPK_REPORT_PARAMS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_BPK_REPORT_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_BPK_REPORT_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_BPK_REPORT_PARAMS 
   (	CODE VARCHAR2(20), 
	NAME VARCHAR2(100), 
	SRC VARCHAR2(100), 
	TYPE VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_BPK_REPORT_PARAMS ***
 exec bpa.alter_policies('TMP_BPK_REPORT_PARAMS');


COMMENT ON TABLE BARS.TMP_BPK_REPORT_PARAMS IS '';
COMMENT ON COLUMN BARS.TMP_BPK_REPORT_PARAMS.CODE IS '';
COMMENT ON COLUMN BARS.TMP_BPK_REPORT_PARAMS.NAME IS '';
COMMENT ON COLUMN BARS.TMP_BPK_REPORT_PARAMS.SRC IS '';
COMMENT ON COLUMN BARS.TMP_BPK_REPORT_PARAMS.TYPE IS '';




PROMPT *** Create  constraint SYS_C00119176 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BPK_REPORT_PARAMS MODIFY (CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_BPK_REPORT_PARAMS ***
grant SELECT                                                                 on TMP_BPK_REPORT_PARAMS to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_BPK_REPORT_PARAMS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_BPK_REPORT_PARAMS.sql =========***
PROMPT ===================================================================================== 
