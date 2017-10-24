

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WCS_PRINT_STATES.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WCS_PRINT_STATES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WCS_PRINT_STATES ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_WCS_PRINT_STATES 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_WCS_PRINT_STATES ***
 exec bpa.alter_policies('TMP_WCS_PRINT_STATES');


COMMENT ON TABLE BARS.TMP_WCS_PRINT_STATES IS '';
COMMENT ON COLUMN BARS.TMP_WCS_PRINT_STATES.ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_PRINT_STATES.NAME IS '';




PROMPT *** Create  constraint SYS_C003175526 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_PRINT_STATES MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WCS_PRINT_STATES.sql =========*** 
PROMPT ===================================================================================== 
