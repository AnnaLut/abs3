

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ADM_RESOURCE_BACK_2402.sql =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ADM_RESOURCE_BACK_2402 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ADM_RESOURCE_BACK_2402 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_ADM_RESOURCE_BACK_2402 
   (	GRANTEE_TYPE_ID NUMBER(5,0), 
	GRANTEE_ID NUMBER(38,0), 
	RESOURCE_TYPE_ID NUMBER(5,0), 
	RESOURCE_ID NUMBER(38,0), 
	ACCESS_MODE_ID NUMBER(5,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ADM_RESOURCE_BACK_2402 ***
 exec bpa.alter_policies('TMP_ADM_RESOURCE_BACK_2402');


COMMENT ON TABLE BARS.TMP_ADM_RESOURCE_BACK_2402 IS '';
COMMENT ON COLUMN BARS.TMP_ADM_RESOURCE_BACK_2402.GRANTEE_TYPE_ID IS '';
COMMENT ON COLUMN BARS.TMP_ADM_RESOURCE_BACK_2402.GRANTEE_ID IS '';
COMMENT ON COLUMN BARS.TMP_ADM_RESOURCE_BACK_2402.RESOURCE_TYPE_ID IS '';
COMMENT ON COLUMN BARS.TMP_ADM_RESOURCE_BACK_2402.RESOURCE_ID IS '';
COMMENT ON COLUMN BARS.TMP_ADM_RESOURCE_BACK_2402.ACCESS_MODE_ID IS '';




PROMPT *** Create  constraint SYS_C00109892 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ADM_RESOURCE_BACK_2402 MODIFY (GRANTEE_TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109893 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ADM_RESOURCE_BACK_2402 MODIFY (GRANTEE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109894 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ADM_RESOURCE_BACK_2402 MODIFY (RESOURCE_TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109895 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ADM_RESOURCE_BACK_2402 MODIFY (RESOURCE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_ADM_RESOURCE_BACK_2402 ***
grant SELECT                                                                 on TMP_ADM_RESOURCE_BACK_2402 to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_ADM_RESOURCE_BACK_2402 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ADM_RESOURCE_BACK_2402.sql =======
PROMPT ===================================================================================== 
