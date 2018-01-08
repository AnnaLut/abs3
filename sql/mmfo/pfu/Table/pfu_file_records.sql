

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_FILE_RECORDS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_FILE_RECORDS ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_FILE_RECORDS 
   (	ID NUMBER, 
	FILE_ID NUMBER, 
	PFU_ENVELOPE_ID NUMBER, 
	MFO VARCHAR2(30), 
	FILE_NUMBER NUMBER, 
	PAYMENT_DATE DATE, 
	REC_ID NUMBER, 
	NUM_ACC VARCHAR2(20), 
	NUM_FILIA VARCHAR2(5), 
	CODE_VKL VARCHAR2(3), 
	SUM_PAY NUMBER, 
	FULL_NAME VARCHAR2(100), 
	NUMIDENT VARCHAR2(10), 
	DATE_ENR VARCHAR2(2), 
	STATE NUMBER(2,0), 
	REF NUMBER, 
	SIGN VARCHAR2(1000), 
	FULL_REC VARCHAR2(170), 
	ERR_MESSAGE VARCHAR2(100), 
	ERR_MESS_TRACE VARCHAR2(1000), 
	SYS_DATE DATE, 
	DATE_INCOME DATE, 
	EBP_NMK VARCHAR2(100), 
	DATE_PAYBACK DATE, 
	NUM_PAYM VARCHAR2(30), 
	DATE_PAY DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_FILE_RECORDS IS '';
COMMENT ON COLUMN PFU.PFU_FILE_RECORDS.ID IS '';
COMMENT ON COLUMN PFU.PFU_FILE_RECORDS.FILE_ID IS '';
COMMENT ON COLUMN PFU.PFU_FILE_RECORDS.PFU_ENVELOPE_ID IS '';
COMMENT ON COLUMN PFU.PFU_FILE_RECORDS.MFO IS '';
COMMENT ON COLUMN PFU.PFU_FILE_RECORDS.FILE_NUMBER IS '';
COMMENT ON COLUMN PFU.PFU_FILE_RECORDS.PAYMENT_DATE IS '';
COMMENT ON COLUMN PFU.PFU_FILE_RECORDS.REC_ID IS '';
COMMENT ON COLUMN PFU.PFU_FILE_RECORDS.NUM_ACC IS '';
COMMENT ON COLUMN PFU.PFU_FILE_RECORDS.NUM_FILIA IS '';
COMMENT ON COLUMN PFU.PFU_FILE_RECORDS.CODE_VKL IS '';
COMMENT ON COLUMN PFU.PFU_FILE_RECORDS.SUM_PAY IS '';
COMMENT ON COLUMN PFU.PFU_FILE_RECORDS.FULL_NAME IS '';
COMMENT ON COLUMN PFU.PFU_FILE_RECORDS.NUMIDENT IS '';
COMMENT ON COLUMN PFU.PFU_FILE_RECORDS.DATE_ENR IS '';
COMMENT ON COLUMN PFU.PFU_FILE_RECORDS.STATE IS '';
COMMENT ON COLUMN PFU.PFU_FILE_RECORDS.REF IS '';
COMMENT ON COLUMN PFU.PFU_FILE_RECORDS.SIGN IS '';
COMMENT ON COLUMN PFU.PFU_FILE_RECORDS.FULL_REC IS '';
COMMENT ON COLUMN PFU.PFU_FILE_RECORDS.ERR_MESSAGE IS '';
COMMENT ON COLUMN PFU.PFU_FILE_RECORDS.ERR_MESS_TRACE IS '';
COMMENT ON COLUMN PFU.PFU_FILE_RECORDS.SYS_DATE IS '';
COMMENT ON COLUMN PFU.PFU_FILE_RECORDS.DATE_INCOME IS '';
COMMENT ON COLUMN PFU.PFU_FILE_RECORDS.EBP_NMK IS '';
COMMENT ON COLUMN PFU.PFU_FILE_RECORDS.DATE_PAYBACK IS '';
COMMENT ON COLUMN PFU.PFU_FILE_RECORDS.NUM_PAYM IS '';
COMMENT ON COLUMN PFU.PFU_FILE_RECORDS.DATE_PAY IS '';




PROMPT *** Create  constraint PFU_FILE_RECORDS_PK ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_FILE_RECORDS ADD CONSTRAINT PFU_FILE_RECORDS_PK PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PFUFILERECORD_RECID_NN ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_FILE_RECORDS ADD CONSTRAINT CC_PFUFILERECORD_RECID_NN CHECK (REC_ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PFUFILERECORDS_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_FILE_RECORDS ADD CONSTRAINT CC_PFUFILERECORDS_ID_NN CHECK (ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PFUFILERECORDS_FILEID_NN ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_FILE_RECORDS ADD CONSTRAINT CC_PFUFILERECORDS_FILEID_NN CHECK (FILE_ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_FILE_RECORDS_STATE ***
begin   
 execute immediate '
  CREATE INDEX PFU.I_FILE_RECORDS_STATE ON PFU.PFU_FILE_RECORDS (STATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_PFU_FILE_RECORD ***
begin   
 execute immediate '
  CREATE INDEX PFU.I_PFU_FILE_RECORD ON PFU.PFU_FILE_RECORDS (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index U1_PFUFILERECORDS ***
begin   
 execute immediate '
  CREATE INDEX PFU.U1_PFUFILERECORDS ON PFU.PFU_FILE_RECORDS (FILE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 1 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PFU_FILE_RECORDS_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PFU_FILE_RECORDS_PK ON PFU.PFU_FILE_RECORDS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PFU_FILE_RECORDS ***
grant SELECT,UPDATE                                                          on PFU_FILE_RECORDS to BARS;
grant SELECT                                                                 on PFU_FILE_RECORDS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_FILE_RECORDS.sql =========*** End *
PROMPT ===================================================================================== 
