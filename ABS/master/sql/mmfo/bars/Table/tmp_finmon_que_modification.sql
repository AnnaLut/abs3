

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_FINMON_QUE_MODIFICATION.sql ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_FINMON_QUE_MODIFICATION ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_FINMON_QUE_MODIFICATION ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_FINMON_QUE_MODIFICATION 
   (	ID NUMBER, 
	MOD_DATE DATE, 
	MOD_TYPE VARCHAR2(1), 
	USER_ID NUMBER(38,0), 
	USER_NAME VARCHAR2(50), 
	MOD_VALUE VARCHAR2(1000), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_FINMON_QUE_MODIFICATION ***
 exec bpa.alter_policies('TMP_FINMON_QUE_MODIFICATION');


COMMENT ON TABLE BARS.TMP_FINMON_QUE_MODIFICATION IS '';
COMMENT ON COLUMN BARS.TMP_FINMON_QUE_MODIFICATION.ID IS '';
COMMENT ON COLUMN BARS.TMP_FINMON_QUE_MODIFICATION.MOD_DATE IS '';
COMMENT ON COLUMN BARS.TMP_FINMON_QUE_MODIFICATION.MOD_TYPE IS '';
COMMENT ON COLUMN BARS.TMP_FINMON_QUE_MODIFICATION.USER_ID IS '';
COMMENT ON COLUMN BARS.TMP_FINMON_QUE_MODIFICATION.USER_NAME IS '';
COMMENT ON COLUMN BARS.TMP_FINMON_QUE_MODIFICATION.MOD_VALUE IS '';
COMMENT ON COLUMN BARS.TMP_FINMON_QUE_MODIFICATION.KF IS '';




PROMPT *** Create  constraint SYS_C00119120 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_FINMON_QUE_MODIFICATION MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119121 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_FINMON_QUE_MODIFICATION MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_FINMON_QUE_MODIFICATION ***
grant SELECT                                                                 on TMP_FINMON_QUE_MODIFICATION to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_FINMON_QUE_MODIFICATION to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_FINMON_QUE_MODIFICATION.sql ======
PROMPT ===================================================================================== 
