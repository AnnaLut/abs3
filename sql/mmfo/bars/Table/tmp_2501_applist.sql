

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_2501_APPLIST.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_2501_APPLIST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_2501_APPLIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_2501_APPLIST 
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




PROMPT *** ALTER_POLICIES to TMP_2501_APPLIST ***
 exec bpa.alter_policies('TMP_2501_APPLIST');


COMMENT ON TABLE BARS.TMP_2501_APPLIST IS '';
COMMENT ON COLUMN BARS.TMP_2501_APPLIST.CODEAPP IS '';
COMMENT ON COLUMN BARS.TMP_2501_APPLIST.NAME IS '';
COMMENT ON COLUMN BARS.TMP_2501_APPLIST.HOTKEY IS '';
COMMENT ON COLUMN BARS.TMP_2501_APPLIST.FRONTEND IS '';
COMMENT ON COLUMN BARS.TMP_2501_APPLIST.ID IS '';




PROMPT *** Create  constraint SYS_C00109337 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_2501_APPLIST MODIFY (CODEAPP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109339 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_2501_APPLIST MODIFY (FRONTEND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109338 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_2501_APPLIST MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_2501_APPLIST.sql =========*** End 
PROMPT ===================================================================================== 
