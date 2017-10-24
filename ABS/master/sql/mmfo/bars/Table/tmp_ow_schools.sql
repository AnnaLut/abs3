

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OW_SCHOOLS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OW_SCHOOLS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OW_SCHOOLS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_OW_SCHOOLS 
   (	SCHOOLID NUMBER(*,0), 
	SCHOOLTYPEID NUMBER(*,0), 
	NAME VARCHAR2(250), 
	SHORTNAME VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OW_SCHOOLS ***
 exec bpa.alter_policies('TMP_OW_SCHOOLS');


COMMENT ON TABLE BARS.TMP_OW_SCHOOLS IS '';
COMMENT ON COLUMN BARS.TMP_OW_SCHOOLS.SCHOOLID IS '';
COMMENT ON COLUMN BARS.TMP_OW_SCHOOLS.SCHOOLTYPEID IS '';
COMMENT ON COLUMN BARS.TMP_OW_SCHOOLS.NAME IS '';
COMMENT ON COLUMN BARS.TMP_OW_SCHOOLS.SHORTNAME IS '';




PROMPT *** Create  constraint SYS_C00119192 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OW_SCHOOLS MODIFY (SCHOOLID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119194 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OW_SCHOOLS MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119193 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OW_SCHOOLS MODIFY (SCHOOLTYPEID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OW_SCHOOLS.sql =========*** End **
PROMPT ===================================================================================== 
