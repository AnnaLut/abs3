

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_DEP_JOB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_DEP_JOB ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_DEP_JOB ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_DEP_JOB 
   (	L_DEPOSIT_ID VARCHAR2(2000), 
	L_KV VARCHAR2(2000), 
	L_RNK VARCHAR2(2000), 
	L_ACC VARCHAR2(2000), 
	L_NLS VARCHAR2(2000), 
	L_DAT_BEGIN VARCHAR2(2000), 
	L_CNT_DUBL VARCHAR2(2000), 
	L_WB VARCHAR2(2000), 
	L_ZP VARCHAR2(2000), 
	L_DAOS VARCHAR2(2000), 
	L_VIDD VARCHAR2(2000), 
	L_TYPE_NAME VARCHAR2(2000), 
	L_BR_TP VARCHAR2(2000), 
	L_OST263 VARCHAR2(2000), 
	L_BDAT VARCHAR2(2000), 
	L_IR VARCHAR2(2000), 
	L_BRL VARCHAR2(2000), 
	L_FDAT_LIST VARCHAR2(2000), 
	L_KOS_LIST VARCHAR2(2000), 
	L_FOST_LIST VARCHAR2(2000), 
	L_DATD VARCHAR2(2000), 
	L_S VARCHAR2(2000), 
	L_PERIOD VARCHAR2(2000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_DEP_JOB ***
 exec bpa.alter_policies('TMP_DEP_JOB');


COMMENT ON TABLE BARS.TMP_DEP_JOB IS '';
COMMENT ON COLUMN BARS.TMP_DEP_JOB.L_DEPOSIT_ID IS '';
COMMENT ON COLUMN BARS.TMP_DEP_JOB.L_KV IS '';
COMMENT ON COLUMN BARS.TMP_DEP_JOB.L_RNK IS '';
COMMENT ON COLUMN BARS.TMP_DEP_JOB.L_ACC IS '';
COMMENT ON COLUMN BARS.TMP_DEP_JOB.L_NLS IS '';
COMMENT ON COLUMN BARS.TMP_DEP_JOB.L_DAT_BEGIN IS '';
COMMENT ON COLUMN BARS.TMP_DEP_JOB.L_CNT_DUBL IS '';
COMMENT ON COLUMN BARS.TMP_DEP_JOB.L_WB IS '';
COMMENT ON COLUMN BARS.TMP_DEP_JOB.L_ZP IS '';
COMMENT ON COLUMN BARS.TMP_DEP_JOB.L_DAOS IS '';
COMMENT ON COLUMN BARS.TMP_DEP_JOB.L_VIDD IS '';
COMMENT ON COLUMN BARS.TMP_DEP_JOB.L_TYPE_NAME IS '';
COMMENT ON COLUMN BARS.TMP_DEP_JOB.L_BR_TP IS '';
COMMENT ON COLUMN BARS.TMP_DEP_JOB.L_OST263 IS '';
COMMENT ON COLUMN BARS.TMP_DEP_JOB.L_BDAT IS '';
COMMENT ON COLUMN BARS.TMP_DEP_JOB.L_IR IS '';
COMMENT ON COLUMN BARS.TMP_DEP_JOB.L_BRL IS '';
COMMENT ON COLUMN BARS.TMP_DEP_JOB.L_FDAT_LIST IS '';
COMMENT ON COLUMN BARS.TMP_DEP_JOB.L_KOS_LIST IS '';
COMMENT ON COLUMN BARS.TMP_DEP_JOB.L_FOST_LIST IS '';
COMMENT ON COLUMN BARS.TMP_DEP_JOB.L_DATD IS '';
COMMENT ON COLUMN BARS.TMP_DEP_JOB.L_S IS '';
COMMENT ON COLUMN BARS.TMP_DEP_JOB.L_PERIOD IS '';




PROMPT *** Create  constraint SYS_C00137294 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DEP_JOB MODIFY (L_DEPOSIT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00137295 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DEP_JOB MODIFY (L_KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00137296 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DEP_JOB MODIFY (L_RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00137297 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DEP_JOB MODIFY (L_ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_DEP_JOB ***
grant SELECT                                                                 on TMP_DEP_JOB     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_DEP_JOB.sql =========*** End *** =
PROMPT ===================================================================================== 
