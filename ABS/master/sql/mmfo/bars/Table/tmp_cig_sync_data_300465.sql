

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CIG_SYNC_DATA_300465.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CIG_SYNC_DATA_300465 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CIG_SYNC_DATA_300465 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_CIG_SYNC_DATA_300465 
   (	DATA_ID NUMBER(38,0), 
	DATA_TYPE NUMBER(38,0), 
	BRANCH VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_CIG_SYNC_DATA_300465 ***
 exec bpa.alter_policies('TMP_CIG_SYNC_DATA_300465');


COMMENT ON TABLE BARS.TMP_CIG_SYNC_DATA_300465 IS '';
COMMENT ON COLUMN BARS.TMP_CIG_SYNC_DATA_300465.DATA_ID IS '';
COMMENT ON COLUMN BARS.TMP_CIG_SYNC_DATA_300465.DATA_TYPE IS '';
COMMENT ON COLUMN BARS.TMP_CIG_SYNC_DATA_300465.BRANCH IS '';




PROMPT *** Create  constraint SYS_C0033495 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CIG_SYNC_DATA_300465 MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CIG_SYNC_DATA_300465.sql =========
PROMPT ===================================================================================== 
