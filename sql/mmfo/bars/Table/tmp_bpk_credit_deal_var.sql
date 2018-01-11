

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_BPK_CREDIT_DEAL_VAR.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_BPK_CREDIT_DEAL_VAR ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_BPK_CREDIT_DEAL_VAR ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_BPK_CREDIT_DEAL_VAR 
   (	REPORT_DT DATE, 
	DEAL_ND NUMBER(24,0), 
	DEAL_SUM NUMBER(24,0), 
	DEAL_RNK NUMBER(24,0), 
	RATE NUMBER(5,3), 
	MATUR_DT DATE, 
	SS NUMBER(24,0), 
	SN NUMBER(24,0), 
	SP NUMBER(24,0), 
	SPN NUMBER(24,0), 
	CR9 NUMBER(24,0), 
	CREATE_DT DATE, 
	ADJ_FLG NUMBER(1,0), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_BPK_CREDIT_DEAL_VAR ***
 exec bpa.alter_policies('TMP_BPK_CREDIT_DEAL_VAR');


COMMENT ON TABLE BARS.TMP_BPK_CREDIT_DEAL_VAR IS '';
COMMENT ON COLUMN BARS.TMP_BPK_CREDIT_DEAL_VAR.REPORT_DT IS '';
COMMENT ON COLUMN BARS.TMP_BPK_CREDIT_DEAL_VAR.DEAL_ND IS '';
COMMENT ON COLUMN BARS.TMP_BPK_CREDIT_DEAL_VAR.DEAL_SUM IS '';
COMMENT ON COLUMN BARS.TMP_BPK_CREDIT_DEAL_VAR.DEAL_RNK IS '';
COMMENT ON COLUMN BARS.TMP_BPK_CREDIT_DEAL_VAR.RATE IS '';
COMMENT ON COLUMN BARS.TMP_BPK_CREDIT_DEAL_VAR.MATUR_DT IS '';
COMMENT ON COLUMN BARS.TMP_BPK_CREDIT_DEAL_VAR.SS IS '';
COMMENT ON COLUMN BARS.TMP_BPK_CREDIT_DEAL_VAR.SN IS '';
COMMENT ON COLUMN BARS.TMP_BPK_CREDIT_DEAL_VAR.SP IS '';
COMMENT ON COLUMN BARS.TMP_BPK_CREDIT_DEAL_VAR.SPN IS '';
COMMENT ON COLUMN BARS.TMP_BPK_CREDIT_DEAL_VAR.CR9 IS '';
COMMENT ON COLUMN BARS.TMP_BPK_CREDIT_DEAL_VAR.CREATE_DT IS '';
COMMENT ON COLUMN BARS.TMP_BPK_CREDIT_DEAL_VAR.ADJ_FLG IS '';
COMMENT ON COLUMN BARS.TMP_BPK_CREDIT_DEAL_VAR.KF IS '';




PROMPT *** Create  constraint SYS_C00119415 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BPK_CREDIT_DEAL_VAR MODIFY (REPORT_DT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119416 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BPK_CREDIT_DEAL_VAR MODIFY (DEAL_ND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119417 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BPK_CREDIT_DEAL_VAR MODIFY (DEAL_SUM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119418 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BPK_CREDIT_DEAL_VAR MODIFY (DEAL_RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119419 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BPK_CREDIT_DEAL_VAR MODIFY (RATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119420 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BPK_CREDIT_DEAL_VAR MODIFY (CREATE_DT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119421 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BPK_CREDIT_DEAL_VAR MODIFY (ADJ_FLG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119422 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BPK_CREDIT_DEAL_VAR MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_BPK_CREDIT_DEAL_VAR ***
grant SELECT                                                                 on TMP_BPK_CREDIT_DEAL_VAR to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_BPK_CREDIT_DEAL_VAR to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_BPK_CREDIT_DEAL_VAR.sql =========*
PROMPT ===================================================================================== 
