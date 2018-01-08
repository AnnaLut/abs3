

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_APPLIST_2501.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_APPLIST_2501 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_APPLIST_2501 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_APPLIST_2501 
   (	CODEAPP VARCHAR2(30), 
	NAME VARCHAR2(140), 
	HOTKEY CHAR(1), 
	FRONTEND NUMBER(38,0), 
	ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_APPLIST_2501 ***
 exec bpa.alter_policies('TMP_APPLIST_2501');


COMMENT ON TABLE BARS.TMP_APPLIST_2501 IS '';
COMMENT ON COLUMN BARS.TMP_APPLIST_2501.CODEAPP IS '';
COMMENT ON COLUMN BARS.TMP_APPLIST_2501.NAME IS '';
COMMENT ON COLUMN BARS.TMP_APPLIST_2501.HOTKEY IS '';
COMMENT ON COLUMN BARS.TMP_APPLIST_2501.FRONTEND IS '';
COMMENT ON COLUMN BARS.TMP_APPLIST_2501.ID IS '';




PROMPT *** Create  constraint SYS_C00109334 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_APPLIST_2501 MODIFY (CODEAPP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109335 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_APPLIST_2501 MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109336 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_APPLIST_2501 MODIFY (FRONTEND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_APPLIST_2501 ***
grant SELECT                                                                 on TMP_APPLIST_2501 to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_APPLIST_2501 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_APPLIST_2501.sql =========*** End 
PROMPT ===================================================================================== 
