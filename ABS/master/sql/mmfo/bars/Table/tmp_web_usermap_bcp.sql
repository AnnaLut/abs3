

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WEB_USERMAP_BCP.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WEB_USERMAP_BCP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WEB_USERMAP_BCP ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_WEB_USERMAP_BCP 
   (	WEBUSER VARCHAR2(30), 
	DBUSER VARCHAR2(30), 
	ERRMODE NUMBER(*,0), 
	WEBPASS VARCHAR2(60), 
	ADMINPASS VARCHAR2(60), 
	COMM VARCHAR2(256), 
	CHGDATE DATE, 
	BLOCKED NUMBER(1,0), 
	ATTEMPTS NUMBER(2,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_WEB_USERMAP_BCP ***
 exec bpa.alter_policies('TMP_WEB_USERMAP_BCP');


COMMENT ON TABLE BARS.TMP_WEB_USERMAP_BCP IS '';
COMMENT ON COLUMN BARS.TMP_WEB_USERMAP_BCP.COMM IS '';
COMMENT ON COLUMN BARS.TMP_WEB_USERMAP_BCP.CHGDATE IS '';
COMMENT ON COLUMN BARS.TMP_WEB_USERMAP_BCP.BLOCKED IS '';
COMMENT ON COLUMN BARS.TMP_WEB_USERMAP_BCP.ATTEMPTS IS '';
COMMENT ON COLUMN BARS.TMP_WEB_USERMAP_BCP.ADMINPASS IS '';
COMMENT ON COLUMN BARS.TMP_WEB_USERMAP_BCP.WEBUSER IS '';
COMMENT ON COLUMN BARS.TMP_WEB_USERMAP_BCP.DBUSER IS '';
COMMENT ON COLUMN BARS.TMP_WEB_USERMAP_BCP.ERRMODE IS '';
COMMENT ON COLUMN BARS.TMP_WEB_USERMAP_BCP.WEBPASS IS '';




PROMPT *** Create  constraint SYS_C00109374 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WEB_USERMAP_BCP MODIFY (DBUSER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109375 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WEB_USERMAP_BCP MODIFY (ERRMODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_WEB_USERMAP_BCP ***
grant SELECT                                                                 on TMP_WEB_USERMAP_BCP to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_WEB_USERMAP_BCP to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WEB_USERMAP_BCP.sql =========*** E
PROMPT ===================================================================================== 
