

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WCS_BCK.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WCS_BCK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WCS_BCK ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_WCS_BCK 
   (	BCK_ID NUMBER(38,0), 
	BCK_NAME VARCHAR2(128), 
	SERVICE_METHOD VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_WCS_BCK ***
 exec bpa.alter_policies('TMP_WCS_BCK');


COMMENT ON TABLE BARS.TMP_WCS_BCK IS '';
COMMENT ON COLUMN BARS.TMP_WCS_BCK.BCK_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_BCK.BCK_NAME IS '';
COMMENT ON COLUMN BARS.TMP_WCS_BCK.SERVICE_METHOD IS '';




PROMPT *** Create  constraint SYS_C003175504 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_BCK MODIFY (SERVICE_METHOD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003175503 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_BCK MODIFY (BCK_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WCS_BCK.sql =========*** End *** =
PROMPT ===================================================================================== 
