

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WCS_STATES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WCS_STATES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WCS_STATES ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_WCS_STATES 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255), 
	PARENT VARCHAR2(100), 
	BEFORE_PROC VARCHAR2(4000), 
	AFTER_PROC VARCHAR2(4000), 
	IS_DISP NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_WCS_STATES ***
 exec bpa.alter_policies('TMP_WCS_STATES');


COMMENT ON TABLE BARS.TMP_WCS_STATES IS '';
COMMENT ON COLUMN BARS.TMP_WCS_STATES.ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_STATES.NAME IS '';
COMMENT ON COLUMN BARS.TMP_WCS_STATES.PARENT IS '';
COMMENT ON COLUMN BARS.TMP_WCS_STATES.BEFORE_PROC IS '';
COMMENT ON COLUMN BARS.TMP_WCS_STATES.AFTER_PROC IS '';
COMMENT ON COLUMN BARS.TMP_WCS_STATES.IS_DISP IS '';




PROMPT *** Create  constraint SYS_C003175578 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_STATES MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WCS_STATES.sql =========*** End **
PROMPT ===================================================================================== 
