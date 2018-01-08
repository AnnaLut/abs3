

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_PRVN_AUTOMATIC_EVENT.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_PRVN_AUTOMATIC_EVENT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_PRVN_AUTOMATIC_EVENT ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_PRVN_AUTOMATIC_EVENT 
   (	ID NUMBER(38,0), 
	REPORTING_DATE DATE, 
	REF_AGR NUMBER(38,0), 
	RNK NUMBER(38,0), 
	EVENT_TYPE NUMBER(1,0), 
	EVENT_DATE DATE, 
	OBJECT_TYPE VARCHAR2(5), 
	RESTR_END_DAT DATE, 
	CREATE_DATE DATE, 
	ZO NUMBER(*,0), 
	VIDD NUMBER, 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_PRVN_AUTOMATIC_EVENT ***
 exec bpa.alter_policies('TMP_PRVN_AUTOMATIC_EVENT');


COMMENT ON TABLE BARS.TMP_PRVN_AUTOMATIC_EVENT IS '';
COMMENT ON COLUMN BARS.TMP_PRVN_AUTOMATIC_EVENT.ID IS '';
COMMENT ON COLUMN BARS.TMP_PRVN_AUTOMATIC_EVENT.REPORTING_DATE IS '';
COMMENT ON COLUMN BARS.TMP_PRVN_AUTOMATIC_EVENT.REF_AGR IS '';
COMMENT ON COLUMN BARS.TMP_PRVN_AUTOMATIC_EVENT.RNK IS '';
COMMENT ON COLUMN BARS.TMP_PRVN_AUTOMATIC_EVENT.EVENT_TYPE IS '';
COMMENT ON COLUMN BARS.TMP_PRVN_AUTOMATIC_EVENT.EVENT_DATE IS '';
COMMENT ON COLUMN BARS.TMP_PRVN_AUTOMATIC_EVENT.OBJECT_TYPE IS '';
COMMENT ON COLUMN BARS.TMP_PRVN_AUTOMATIC_EVENT.RESTR_END_DAT IS '';
COMMENT ON COLUMN BARS.TMP_PRVN_AUTOMATIC_EVENT.CREATE_DATE IS '';
COMMENT ON COLUMN BARS.TMP_PRVN_AUTOMATIC_EVENT.ZO IS '';
COMMENT ON COLUMN BARS.TMP_PRVN_AUTOMATIC_EVENT.VIDD IS '';
COMMENT ON COLUMN BARS.TMP_PRVN_AUTOMATIC_EVENT.KF IS '';




PROMPT *** Create  constraint SYS_C00119412 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_PRVN_AUTOMATIC_EVENT MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119413 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_PRVN_AUTOMATIC_EVENT MODIFY (EVENT_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119414 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_PRVN_AUTOMATIC_EVENT MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_PRVN_AUTOMATIC_EVENT ***
grant SELECT                                                                 on TMP_PRVN_AUTOMATIC_EVENT to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_PRVN_AUTOMATIC_EVENT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_PRVN_AUTOMATIC_EVENT.sql =========
PROMPT ===================================================================================== 
