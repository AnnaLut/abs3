

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WCS_MAC_TYPES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WCS_MAC_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WCS_MAC_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_WCS_MAC_TYPES 
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




PROMPT *** ALTER_POLICIES to TMP_WCS_MAC_TYPES ***
 exec bpa.alter_policies('TMP_WCS_MAC_TYPES');


COMMENT ON TABLE BARS.TMP_WCS_MAC_TYPES IS '';
COMMENT ON COLUMN BARS.TMP_WCS_MAC_TYPES.ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_MAC_TYPES.NAME IS '';




PROMPT *** Create  constraint SYS_C003175522 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_MAC_TYPES MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WCS_MAC_TYPES.sql =========*** End
PROMPT ===================================================================================== 
