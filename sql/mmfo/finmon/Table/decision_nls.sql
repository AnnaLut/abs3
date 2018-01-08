

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/DECISION_NLS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  table DECISION_NLS ***
begin 
  execute immediate '
  CREATE TABLE FINMON.DECISION_NLS 
   (	ID NUMBER(*,0), 
	IDD VARCHAR2(15), 
	NLS VARCHAR2(14), 
	KV NUMBER(3,0), 
	ACC NUMBER(38,0), 
	BRANCH_ID VARCHAR2(15)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.DECISION_NLS IS '';
COMMENT ON COLUMN FINMON.DECISION_NLS.ID IS '';
COMMENT ON COLUMN FINMON.DECISION_NLS.IDD IS '';
COMMENT ON COLUMN FINMON.DECISION_NLS.NLS IS '';
COMMENT ON COLUMN FINMON.DECISION_NLS.KV IS '';
COMMENT ON COLUMN FINMON.DECISION_NLS.ACC IS '';
COMMENT ON COLUMN FINMON.DECISION_NLS.BRANCH_ID IS '';




PROMPT *** Create  constraint SYS_C0032139 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.DECISION_NLS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0032140 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.DECISION_NLS MODIFY (IDD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0032141 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.DECISION_NLS MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0032142 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.DECISION_NLS MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109333 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.DECISION_NLS MODIFY (BRANCH_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DECISION_NLS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.PK_DECISION_NLS ON FINMON.DECISION_NLS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_DECISIONNLS_IDD ***
begin   
 execute immediate '
  CREATE INDEX FINMON.XIE_DECISIONNLS_IDD ON FINMON.DECISION_NLS (IDD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DECISION_NLS ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on DECISION_NLS    to BARS;
grant SELECT                                                                 on DECISION_NLS    to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/DECISION_NLS.sql =========*** End **
PROMPT ===================================================================================== 
