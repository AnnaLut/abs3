

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SWI_CTS_LIST.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SWI_CTS_LIST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SWI_CTS_LIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_SWI_CTS_LIST 
   (	ID VARCHAR2(30), 
	NAME VARCHAR2(256), 
	CTS_URL VARCHAR2(2000), 
	CTS_IMG VARCHAR2(2000), 
	PARAMS VARCHAR2(2000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SWI_CTS_LIST ***
 exec bpa.alter_policies('TMP_SWI_CTS_LIST');


COMMENT ON TABLE BARS.TMP_SWI_CTS_LIST IS '';
COMMENT ON COLUMN BARS.TMP_SWI_CTS_LIST.ID IS '';
COMMENT ON COLUMN BARS.TMP_SWI_CTS_LIST.NAME IS '';
COMMENT ON COLUMN BARS.TMP_SWI_CTS_LIST.CTS_URL IS '';
COMMENT ON COLUMN BARS.TMP_SWI_CTS_LIST.CTS_IMG IS '';
COMMENT ON COLUMN BARS.TMP_SWI_CTS_LIST.PARAMS IS '';




PROMPT *** Create  constraint SYS_C00119138 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SWI_CTS_LIST MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119139 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SWI_CTS_LIST MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119140 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SWI_CTS_LIST MODIFY (CTS_URL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119141 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SWI_CTS_LIST MODIFY (CTS_IMG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_SWI_CTS_LIST ***
grant SELECT                                                                 on TMP_SWI_CTS_LIST to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_SWI_CTS_LIST to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SWI_CTS_LIST.sql =========*** End 
PROMPT ===================================================================================== 
