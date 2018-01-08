

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NAEK_LINES.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NAEK_LINES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NAEK_LINES'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NAEK_LINES'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NAEK_LINES'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NAEK_LINES ***
begin 
  execute immediate '
  CREATE TABLE BARS.NAEK_LINES 
   (	FILE_YEAR NUMBER(4,0), 
	FILE_NAME VARCHAR2(12), 
	LINE_NO NUMBER(*,0), 
	VISA_FLAG VARCHAR2(1), 
	DOC_NUM VARCHAR2(10), 
	DOC_DATE DATE, 
	DOC_VALUE_DATE DATE, 
	PAYER_NAME VARCHAR2(38), 
	PAYER_ID VARCHAR2(12), 
	PAYER_BANK_NAME VARCHAR2(38), 
	PAYER_BANK_CODE VARCHAR2(9), 
	PAYER_ACCOUNT VARCHAR2(14), 
	PAYEE_NAME VARCHAR2(38), 
	PAYEE_ID VARCHAR2(12), 
	PAYEE_BANK_NAME VARCHAR2(38), 
	PAYEE_BANK_CODE VARCHAR2(9), 
	PAYEE_ACCOUNT VARCHAR2(14), 
	CURRENCY NUMBER(*,0), 
	SUMMA NUMBER, 
	CURRENCY_RATE NUMBER, 
	NARRATIVE VARCHAR2(160), 
	DK NUMBER(1,0), 
	REF NUMBER, 
	ORD NUMBER, 
	PROCESSED VARCHAR2(1) DEFAULT ''N'', 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NAEK_LINES ***
 exec bpa.alter_policies('NAEK_LINES');


COMMENT ON TABLE BARS.NAEK_LINES IS 'Строки файлов филиалов НАЕК Энергоатом';
COMMENT ON COLUMN BARS.NAEK_LINES.FILE_YEAR IS '';
COMMENT ON COLUMN BARS.NAEK_LINES.FILE_NAME IS '';
COMMENT ON COLUMN BARS.NAEK_LINES.LINE_NO IS '';
COMMENT ON COLUMN BARS.NAEK_LINES.VISA_FLAG IS '';
COMMENT ON COLUMN BARS.NAEK_LINES.DOC_NUM IS '';
COMMENT ON COLUMN BARS.NAEK_LINES.DOC_DATE IS '';
COMMENT ON COLUMN BARS.NAEK_LINES.DOC_VALUE_DATE IS '';
COMMENT ON COLUMN BARS.NAEK_LINES.PAYER_NAME IS '';
COMMENT ON COLUMN BARS.NAEK_LINES.PAYER_ID IS '';
COMMENT ON COLUMN BARS.NAEK_LINES.PAYER_BANK_NAME IS '';
COMMENT ON COLUMN BARS.NAEK_LINES.PAYER_BANK_CODE IS '';
COMMENT ON COLUMN BARS.NAEK_LINES.PAYER_ACCOUNT IS '';
COMMENT ON COLUMN BARS.NAEK_LINES.PAYEE_NAME IS '';
COMMENT ON COLUMN BARS.NAEK_LINES.PAYEE_ID IS '';
COMMENT ON COLUMN BARS.NAEK_LINES.PAYEE_BANK_NAME IS '';
COMMENT ON COLUMN BARS.NAEK_LINES.PAYEE_BANK_CODE IS '';
COMMENT ON COLUMN BARS.NAEK_LINES.PAYEE_ACCOUNT IS '';
COMMENT ON COLUMN BARS.NAEK_LINES.CURRENCY IS '';
COMMENT ON COLUMN BARS.NAEK_LINES.SUMMA IS '';
COMMENT ON COLUMN BARS.NAEK_LINES.CURRENCY_RATE IS '';
COMMENT ON COLUMN BARS.NAEK_LINES.NARRATIVE IS '';
COMMENT ON COLUMN BARS.NAEK_LINES.DK IS '';
COMMENT ON COLUMN BARS.NAEK_LINES.REF IS '';
COMMENT ON COLUMN BARS.NAEK_LINES.ORD IS '';
COMMENT ON COLUMN BARS.NAEK_LINES.PROCESSED IS '';
COMMENT ON COLUMN BARS.NAEK_LINES.KF IS '';




PROMPT *** Create  constraint CC_NAEKLINES_VISAFLAG_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES ADD CONSTRAINT CC_NAEKLINES_VISAFLAG_CC CHECK (visa_flag in (''0'',''1'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKLINES_PROCESSED_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES ADD CONSTRAINT CC_NAEKLINES_PROCESSED_CC CHECK (processed in (''Y'',''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_NAEKLINES ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES ADD CONSTRAINT PK_NAEKLINES PRIMARY KEY (KF, FILE_YEAR, FILE_NAME, LINE_NO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKLINES_FILEYEAR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES MODIFY (FILE_YEAR CONSTRAINT CC_NAEKLINES_FILEYEAR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKLINES_FILENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES MODIFY (FILE_NAME CONSTRAINT CC_NAEKLINES_FILENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKLINES_LINENO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES MODIFY (LINE_NO CONSTRAINT CC_NAEKLINES_LINENO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKLINES_VISAFLAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES MODIFY (VISA_FLAG CONSTRAINT CC_NAEKLINES_VISAFLAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKLINES_DOCNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES MODIFY (DOC_NUM CONSTRAINT CC_NAEKLINES_DOCNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKLINES_DOCDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES MODIFY (DOC_DATE CONSTRAINT CC_NAEKLINES_DOCDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKLINES_DOCVDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES MODIFY (DOC_VALUE_DATE CONSTRAINT CC_NAEKLINES_DOCVDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKLINES_PAYERNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES MODIFY (PAYER_NAME CONSTRAINT CC_NAEKLINES_PAYERNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKLINES_PAYERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES MODIFY (PAYER_ID CONSTRAINT CC_NAEKLINES_PAYERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKLINES_PAYERBN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES MODIFY (PAYER_BANK_NAME CONSTRAINT CC_NAEKLINES_PAYERBN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKLINES_PAYERBC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES MODIFY (PAYER_BANK_CODE CONSTRAINT CC_NAEKLINES_PAYERBC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKLINES_PAYERACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES MODIFY (PAYER_ACCOUNT CONSTRAINT CC_NAEKLINES_PAYERACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKLINES_PAYEENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES MODIFY (PAYEE_NAME CONSTRAINT CC_NAEKLINES_PAYEENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKLINES_PAYEEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES MODIFY (PAYEE_ID CONSTRAINT CC_NAEKLINES_PAYEEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKLINES_PAYEEBN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES MODIFY (PAYEE_BANK_NAME CONSTRAINT CC_NAEKLINES_PAYEEBN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKLINES_PAYEEBC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES MODIFY (PAYEE_BANK_CODE CONSTRAINT CC_NAEKLINES_PAYEEBC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKLINES_PAYEEACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES MODIFY (PAYEE_ACCOUNT CONSTRAINT CC_NAEKLINES_PAYEEACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKLINES_CURRENCY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES MODIFY (CURRENCY CONSTRAINT CC_NAEKLINES_CURRENCY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKLINES_SUMMA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES MODIFY (SUMMA CONSTRAINT CC_NAEKLINES_SUMMA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKLINES_CURRATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES MODIFY (CURRENCY_RATE CONSTRAINT CC_NAEKLINES_CURRATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKLINES_NARRATIVE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES MODIFY (NARRATIVE CONSTRAINT CC_NAEKLINES_NARRATIVE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKLINES_DK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES MODIFY (DK CONSTRAINT CC_NAEKLINES_DK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKLINES_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES MODIFY (REF CONSTRAINT CC_NAEKLINES_REF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKLINES_ORD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES MODIFY (ORD CONSTRAINT CC_NAEKLINES_ORD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKLINES_PROCESSED_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES MODIFY (PROCESSED CONSTRAINT CC_NAEKLINES_PROCESSED_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKLINES_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES MODIFY (KF CONSTRAINT CC_NAEKLINES_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_NAEKLINES_REF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.I_NAEKLINES_REF ON BARS.NAEK_LINES (CASE PROCESSED WHEN ''N'' THEN REF ELSE NULL END ) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NAEKLINES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NAEKLINES ON BARS.NAEK_LINES (KF, FILE_YEAR, FILE_NAME, LINE_NO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NAEK_LINES ***
grant SELECT                                                                 on NAEK_LINES      to BARSREADER_ROLE;
grant SELECT                                                                 on NAEK_LINES      to BARS_DM;
grant SELECT                                                                 on NAEK_LINES      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NAEK_LINES      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NAEK_LINES.sql =========*** End *** ==
PROMPT ===================================================================================== 
