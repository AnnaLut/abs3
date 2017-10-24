

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OPERLIST_BAK.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OPERLIST_BAK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OPERLIST_BAK ***
begin 
  execute immediate '
  CREATE TABLE BARS.OPERLIST_BAK 
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




PROMPT *** ALTER_POLICIES to OPERLIST_BAK ***
 exec bpa.alter_policies('OPERLIST_BAK');


COMMENT ON TABLE BARS.OPERLIST_BAK IS '';
COMMENT ON COLUMN BARS.OPERLIST_BAK.CODEOPER IS '';
COMMENT ON COLUMN BARS.OPERLIST_BAK.NAME IS '';
COMMENT ON COLUMN BARS.OPERLIST_BAK.DLGNAME IS '';
COMMENT ON COLUMN BARS.OPERLIST_BAK.FUNCNAME IS '';
COMMENT ON COLUMN BARS.OPERLIST_BAK.SEMANTIC IS '';
COMMENT ON COLUMN BARS.OPERLIST_BAK.RUNABLE IS '';
COMMENT ON COLUMN BARS.OPERLIST_BAK.PARENTID IS '';
COMMENT ON COLUMN BARS.OPERLIST_BAK.ROLENAME IS '';
COMMENT ON COLUMN BARS.OPERLIST_BAK.FRONTEND IS '';
COMMENT ON COLUMN BARS.OPERLIST_BAK.USEARC IS '';




PROMPT *** Create  constraint SYS_C0025779 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST_BAK MODIFY (CODEOPER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025780 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST_BAK MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025784 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST_BAK MODIFY (USEARC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025782 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST_BAK MODIFY (FUNCNAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025783 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST_BAK MODIFY (FRONTEND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025781 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST_BAK MODIFY (DLGNAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OPERLIST_BAK.sql =========*** End *** 
PROMPT ===================================================================================== 
