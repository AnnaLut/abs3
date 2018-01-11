

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ADM_RESOURCE_ACT_BACK_2402.sql ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ADM_RESOURCE_ACT_BACK_2402 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ADM_RESOURCE_ACT_BACK_2402 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_ADM_RESOURCE_ACT_BACK_2402 
   (	ID NUMBER(38,0), 
	GRANTEE_TYPE_ID NUMBER(5,0), 
	GRANTEE_ID NUMBER(38,0), 
	RESOURCE_TYPE_ID NUMBER(5,0), 
	RESOURCE_ID NUMBER(38,0), 
	ACCESS_MODE_ID NUMBER(5,0), 
	ACTION_TIME DATE, 
	ACTION_USER_ID NUMBER(38,0), 
	RESOLUTION_TYPE_ID NUMBER(5,0), 
	RESOLUTION_TIME DATE, 
	RESOLUTION_USER_ID NUMBER(38,0), 
	RESOLUTION_COMMENT VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ADM_RESOURCE_ACT_BACK_2402 ***
 exec bpa.alter_policies('TMP_ADM_RESOURCE_ACT_BACK_2402');


COMMENT ON TABLE BARS.TMP_ADM_RESOURCE_ACT_BACK_2402 IS '';
COMMENT ON COLUMN BARS.TMP_ADM_RESOURCE_ACT_BACK_2402.ID IS '';
COMMENT ON COLUMN BARS.TMP_ADM_RESOURCE_ACT_BACK_2402.GRANTEE_TYPE_ID IS '';
COMMENT ON COLUMN BARS.TMP_ADM_RESOURCE_ACT_BACK_2402.GRANTEE_ID IS '';
COMMENT ON COLUMN BARS.TMP_ADM_RESOURCE_ACT_BACK_2402.RESOURCE_TYPE_ID IS '';
COMMENT ON COLUMN BARS.TMP_ADM_RESOURCE_ACT_BACK_2402.RESOURCE_ID IS '';
COMMENT ON COLUMN BARS.TMP_ADM_RESOURCE_ACT_BACK_2402.ACCESS_MODE_ID IS '';
COMMENT ON COLUMN BARS.TMP_ADM_RESOURCE_ACT_BACK_2402.ACTION_TIME IS '';
COMMENT ON COLUMN BARS.TMP_ADM_RESOURCE_ACT_BACK_2402.ACTION_USER_ID IS '';
COMMENT ON COLUMN BARS.TMP_ADM_RESOURCE_ACT_BACK_2402.RESOLUTION_TYPE_ID IS '';
COMMENT ON COLUMN BARS.TMP_ADM_RESOURCE_ACT_BACK_2402.RESOLUTION_TIME IS '';
COMMENT ON COLUMN BARS.TMP_ADM_RESOURCE_ACT_BACK_2402.RESOLUTION_USER_ID IS '';
COMMENT ON COLUMN BARS.TMP_ADM_RESOURCE_ACT_BACK_2402.RESOLUTION_COMMENT IS '';




PROMPT *** Create  constraint SYS_C00109896 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ADM_RESOURCE_ACT_BACK_2402 MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109897 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ADM_RESOURCE_ACT_BACK_2402 MODIFY (GRANTEE_TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109898 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ADM_RESOURCE_ACT_BACK_2402 MODIFY (GRANTEE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109899 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ADM_RESOURCE_ACT_BACK_2402 MODIFY (RESOURCE_TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109900 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ADM_RESOURCE_ACT_BACK_2402 MODIFY (RESOURCE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109901 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ADM_RESOURCE_ACT_BACK_2402 MODIFY (ACCESS_MODE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109902 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ADM_RESOURCE_ACT_BACK_2402 MODIFY (ACTION_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109903 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ADM_RESOURCE_ACT_BACK_2402 MODIFY (ACTION_USER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_ADM_RESOURCE_ACT_BACK_2402 ***
grant SELECT                                                                 on TMP_ADM_RESOURCE_ACT_BACK_2402 to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_ADM_RESOURCE_ACT_BACK_2402 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ADM_RESOURCE_ACT_BACK_2402.sql ===
PROMPT ===================================================================================== 
