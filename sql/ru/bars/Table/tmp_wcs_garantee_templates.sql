

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WCS_GARANTEE_TEMPLATES.sql =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WCS_GARANTEE_TEMPLATES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WCS_GARANTEE_TEMPLATES ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_WCS_GARANTEE_TEMPLATES 
   (	GARANTEE_ID VARCHAR2(100), 
	TEMPLATE_ID VARCHAR2(100), 
	PRINT_STATE_ID VARCHAR2(100), 
	IS_SCAN_REQUIRED NUMBER, 
	SCAN_QID VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_WCS_GARANTEE_TEMPLATES ***
 exec bpa.alter_policies('TMP_WCS_GARANTEE_TEMPLATES');


COMMENT ON TABLE BARS.TMP_WCS_GARANTEE_TEMPLATES IS '';
COMMENT ON COLUMN BARS.TMP_WCS_GARANTEE_TEMPLATES.GARANTEE_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_GARANTEE_TEMPLATES.TEMPLATE_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_GARANTEE_TEMPLATES.PRINT_STATE_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_GARANTEE_TEMPLATES.IS_SCAN_REQUIRED IS '';
COMMENT ON COLUMN BARS.TMP_WCS_GARANTEE_TEMPLATES.SCAN_QID IS '';




PROMPT *** Create  constraint SYS_C003175514 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_GARANTEE_TEMPLATES MODIFY (SCAN_QID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WCS_GARANTEE_TEMPLATES.sql =======
PROMPT ===================================================================================== 
