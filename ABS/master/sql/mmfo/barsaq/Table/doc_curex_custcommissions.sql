

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/DOC_CUREX_CUSTCOMMISSIONS.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  table DOC_CUREX_CUSTCOMMISSIONS ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.DOC_CUREX_CUSTCOMMISSIONS 
   (	RNK NUMBER(*,0), 
	BUY_COMMISSION NUMBER(10,4), 
	SELL_COMMISSION NUMBER(10,4), 
	BANK_ID VARCHAR2(11 CHAR), 
	CONV_COMMISSION NUMBER(10,4), 
	NLS_PF VARCHAR2(15 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.DOC_CUREX_CUSTCOMMISSIONS IS 'Комісії для клієнтів при біржових операціях version 1.0';
COMMENT ON COLUMN BARSAQ.DOC_CUREX_CUSTCOMMISSIONS.RNK IS 'Ідентифікатор клієнта';
COMMENT ON COLUMN BARSAQ.DOC_CUREX_CUSTCOMMISSIONS.BUY_COMMISSION IS 'Комісія при купівлі';
COMMENT ON COLUMN BARSAQ.DOC_CUREX_CUSTCOMMISSIONS.SELL_COMMISSION IS 'Комісія при продажу';
COMMENT ON COLUMN BARSAQ.DOC_CUREX_CUSTCOMMISSIONS.BANK_ID IS '';
COMMENT ON COLUMN BARSAQ.DOC_CUREX_CUSTCOMMISSIONS.CONV_COMMISSION IS '';
COMMENT ON COLUMN BARSAQ.DOC_CUREX_CUSTCOMMISSIONS.NLS_PF IS '';




PROMPT *** Create  constraint PK_DOCCUREXCUSTCOMMISSIONS ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_CUREX_CUSTCOMMISSIONS ADD CONSTRAINT PK_DOCCUREXCUSTCOMMISSIONS PRIMARY KEY (RNK, BANK_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCCUREXCOM_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_CUREX_CUSTCOMMISSIONS MODIFY (RNK CONSTRAINT CC_DOCCUREXCOM_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCCUREXCUSTCOM_BANKID ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_CUREX_CUSTCOMMISSIONS MODIFY (BANK_ID CONSTRAINT CC_DOCCUREXCUSTCOM_BANKID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DOCCUREXCUSTCOMMISSIONS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_DOCCUREXCUSTCOMMISSIONS ON BARSAQ.DOC_CUREX_CUSTCOMMISSIONS (RNK, BANK_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DOC_CUREX_CUSTCOMMISSIONS ***
grant SELECT                                                                 on DOC_CUREX_CUSTCOMMISSIONS to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/DOC_CUREX_CUSTCOMMISSIONS.sql ======
PROMPT ===================================================================================== 
