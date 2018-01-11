

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OPERLIST.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OPERLIST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OPERLIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_OPERLIST 
   (	CODEOPER NUMBER(38,0), 
	NAME VARCHAR2(70), 
	DLGNAME VARCHAR2(35), 
	FUNCNAME VARCHAR2(250), 
	SEMANTIC VARCHAR2(100), 
	RUNABLE NUMBER(1,0), 
	PARENTID NUMBER(38,0), 
	ROLENAME VARCHAR2(30), 
	FRONTEND NUMBER(1,0), 
	USEARC NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OPERLIST ***
 exec bpa.alter_policies('TMP_OPERLIST');


COMMENT ON TABLE BARS.TMP_OPERLIST IS '';
COMMENT ON COLUMN BARS.TMP_OPERLIST.CODEOPER IS '';
COMMENT ON COLUMN BARS.TMP_OPERLIST.NAME IS '';
COMMENT ON COLUMN BARS.TMP_OPERLIST.DLGNAME IS '';
COMMENT ON COLUMN BARS.TMP_OPERLIST.FUNCNAME IS '';
COMMENT ON COLUMN BARS.TMP_OPERLIST.SEMANTIC IS '';
COMMENT ON COLUMN BARS.TMP_OPERLIST.RUNABLE IS '';
COMMENT ON COLUMN BARS.TMP_OPERLIST.PARENTID IS '';
COMMENT ON COLUMN BARS.TMP_OPERLIST.ROLENAME IS '';
COMMENT ON COLUMN BARS.TMP_OPERLIST.FRONTEND IS '';
COMMENT ON COLUMN BARS.TMP_OPERLIST.USEARC IS '';




PROMPT *** Create  constraint SYS_C009488 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OPERLIST MODIFY (CODEOPER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009489 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OPERLIST MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009490 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OPERLIST MODIFY (DLGNAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009491 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OPERLIST MODIFY (FUNCNAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009492 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OPERLIST MODIFY (FRONTEND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009493 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OPERLIST MODIFY (USEARC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_OPERLIST ***
grant SELECT                                                                 on TMP_OPERLIST    to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_OPERLIST    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OPERLIST.sql =========*** End *** 
PROMPT ===================================================================================== 
