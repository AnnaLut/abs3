

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCP_ACCOUNTS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCP_ACCOUNTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCP_ACCOUNTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ACCP_ACCOUNTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCP_ACCOUNTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCP_ACCOUNTS 
   (	OKPO VARCHAR2(10), 
	MFO VARCHAR2(6), 
	NLS VARCHAR2(14), 
	CHECK_ON NUMBER(2,0) DEFAULT 1
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCP_ACCOUNTS ***
 exec bpa.alter_policies('ACCP_ACCOUNTS');


COMMENT ON TABLE BARS.ACCP_ACCOUNTS IS 'довідник рахунків організацій';
COMMENT ON COLUMN BARS.ACCP_ACCOUNTS.OKPO IS 'Код ЄДРПОУ організації';
COMMENT ON COLUMN BARS.ACCP_ACCOUNTS.MFO IS 'Код банку організації ';
COMMENT ON COLUMN BARS.ACCP_ACCOUNTS.NLS IS 'Розрахунковий рахунок організації';
COMMENT ON COLUMN BARS.ACCP_ACCOUNTS.CHECK_ON IS '';




PROMPT *** Create  constraint CC_ACCPACC_OKPO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCP_ACCOUNTS MODIFY (OKPO CONSTRAINT CC_ACCPACC_OKPO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCPACC_MFO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCP_ACCOUNTS MODIFY (MFO CONSTRAINT CC_ACCPACC_MFO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCPACC_NLS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCP_ACCOUNTS MODIFY (NLS CONSTRAINT CC_ACCPACC_NLS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ACCPACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCP_ACCOUNTS ADD CONSTRAINT PK_ACCPACCOUNTS PRIMARY KEY (MFO, NLS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCPACCOUNTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCPACCOUNTS ON BARS.ACCP_ACCOUNTS (MFO, NLS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCP_ACCOUNTS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCP_ACCOUNTS   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCP_ACCOUNTS   to UPLD;
grant FLASHBACK,SELECT                                                       on ACCP_ACCOUNTS   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCP_ACCOUNTS.sql =========*** End ***
PROMPT ===================================================================================== 
