

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WCS_SERVICES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WCS_SERVICES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WCS_SERVICES ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_WCS_SERVICES 
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




PROMPT *** ALTER_POLICIES to TMP_WCS_SERVICES ***
 exec bpa.alter_policies('TMP_WCS_SERVICES');


COMMENT ON TABLE BARS.TMP_WCS_SERVICES IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SERVICES.ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SERVICES.NAME IS '';




PROMPT *** Create  constraint SYS_C003175573 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_SERVICES MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WCS_SERVICES.sql =========*** End 
PROMPT ===================================================================================== 
