

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WCS_CREDITDATA_BASE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WCS_CREDITDATA_BASE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WCS_CREDITDATA_BASE ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_WCS_CREDITDATA_BASE 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255), 
	TYPE_ID VARCHAR2(100), 
	STATE_ID VARCHAR2(100), 
	ORD NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_WCS_CREDITDATA_BASE ***
 exec bpa.alter_policies('TMP_WCS_CREDITDATA_BASE');


COMMENT ON TABLE BARS.TMP_WCS_CREDITDATA_BASE IS '';
COMMENT ON COLUMN BARS.TMP_WCS_CREDITDATA_BASE.NAME IS '';
COMMENT ON COLUMN BARS.TMP_WCS_CREDITDATA_BASE.TYPE_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_CREDITDATA_BASE.STATE_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_CREDITDATA_BASE.ORD IS '';
COMMENT ON COLUMN BARS.TMP_WCS_CREDITDATA_BASE.ID IS '';




PROMPT *** Create  constraint SYS_C003175508 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_CREDITDATA_BASE MODIFY (ORD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003175507 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_CREDITDATA_BASE MODIFY (STATE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003175506 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_CREDITDATA_BASE MODIFY (TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003175505 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_CREDITDATA_BASE MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WCS_CREDITDATA_BASE.sql =========*
PROMPT ===================================================================================== 
