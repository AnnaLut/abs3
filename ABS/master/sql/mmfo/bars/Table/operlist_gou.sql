

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OPERLIST_GOU.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OPERLIST_GOU ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OPERLIST_GOU ***
begin 
  execute immediate '
  CREATE TABLE BARS.OPERLIST_GOU 
   (	CODEOPER NUMBER(*,0), 
	NAME VARCHAR2(70), 
	DLGNAME VARCHAR2(35), 
	FUNCNAME VARCHAR2(252), 
	SEMANTIC VARCHAR2(100), 
	RUNABLE NUMBER(*,0), 
	PARENTID NUMBER(*,0), 
	ROLENAME VARCHAR2(30), 
	FRONTEND NUMBER(*,0), 
	USEARC NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OPERLIST_GOU ***
 exec bpa.alter_policies('OPERLIST_GOU');


COMMENT ON TABLE BARS.OPERLIST_GOU IS '';
COMMENT ON COLUMN BARS.OPERLIST_GOU.CODEOPER IS '';
COMMENT ON COLUMN BARS.OPERLIST_GOU.NAME IS '';
COMMENT ON COLUMN BARS.OPERLIST_GOU.DLGNAME IS '';
COMMENT ON COLUMN BARS.OPERLIST_GOU.FUNCNAME IS '';
COMMENT ON COLUMN BARS.OPERLIST_GOU.SEMANTIC IS '';
COMMENT ON COLUMN BARS.OPERLIST_GOU.RUNABLE IS '';
COMMENT ON COLUMN BARS.OPERLIST_GOU.PARENTID IS '';
COMMENT ON COLUMN BARS.OPERLIST_GOU.ROLENAME IS '';
COMMENT ON COLUMN BARS.OPERLIST_GOU.FRONTEND IS '';
COMMENT ON COLUMN BARS.OPERLIST_GOU.USEARC IS '';




PROMPT *** Create  constraint SYS_C006364 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST_GOU MODIFY (CODEOPER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006365 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST_GOU MODIFY (DLGNAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006366 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST_GOU MODIFY (FRONTEND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006367 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST_GOU MODIFY (USEARC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OPERLIST_GOU ***
grant SELECT                                                                 on OPERLIST_GOU    to BARSREADER_ROLE;
grant SELECT                                                                 on OPERLIST_GOU    to BARS_DM;
grant SELECT                                                                 on OPERLIST_GOU    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OPERLIST_GOU.sql =========*** End *** 
PROMPT ===================================================================================== 
