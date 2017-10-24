

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_PAYMENTS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_PAYMENTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_PAYMENTS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DPT_PAYMENTS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_PAYMENTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_PAYMENTS 
   (	DPT_ID NUMBER(38,0), 
	REF NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	RNK NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_PAYMENTS ***
 exec bpa.alter_policies('DPT_PAYMENTS');


COMMENT ON TABLE BARS.DPT_PAYMENTS IS 'Хранилище платежей по депозитным договорам ФЛ';
COMMENT ON COLUMN BARS.DPT_PAYMENTS.RNK IS 'РНК клієнта (довіреної особи)';
COMMENT ON COLUMN BARS.DPT_PAYMENTS.DPT_ID IS 'Идентификатор договора';
COMMENT ON COLUMN BARS.DPT_PAYMENTS.REF IS 'Референс платежа';
COMMENT ON COLUMN BARS.DPT_PAYMENTS.KF IS '';
COMMENT ON COLUMN BARS.DPT_PAYMENTS.BRANCH IS '';




PROMPT *** Create  constraint FK_DPTPAYMENTS_OPER2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_PAYMENTS ADD CONSTRAINT FK_DPTPAYMENTS_OPER2 FOREIGN KEY (KF, REF)
	  REFERENCES BARS.OPER (KF, REF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTPAYMENTS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_PAYMENTS ADD CONSTRAINT FK_DPTPAYMENTS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTPAYMENTS_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_PAYMENTS ADD CONSTRAINT FK_DPTPAYMENTS_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTPAYMENTS_DPTDPTALL2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_PAYMENTS ADD CONSTRAINT FK_DPTPAYMENTS_DPTDPTALL2 FOREIGN KEY (KF, DPT_ID)
	  REFERENCES BARS.DPT_DEPOSIT_ALL (KF, DEPOSIT_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTPAYMENTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_PAYMENTS ADD CONSTRAINT PK_DPTPAYMENTS PRIMARY KEY (DPT_ID, REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTPAYMENTS_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_PAYMENTS MODIFY (BRANCH CONSTRAINT CC_DPTPAYMENTS_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTPAYMENTS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_PAYMENTS MODIFY (KF CONSTRAINT CC_DPTPAYMENTS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTPAYMENTS_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_PAYMENTS MODIFY (REF CONSTRAINT CC_DPTPAYMENTS_REF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTPAYMENTS_DPTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_PAYMENTS MODIFY (DPT_ID CONSTRAINT CC_DPTPAYMENTS_DPTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_DPTPAYMENTS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_DPTPAYMENTS ON BARS.DPT_PAYMENTS (DPT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTPAYMENTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTPAYMENTS ON BARS.DPT_PAYMENTS (DPT_ID, REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_PAYMENTS ***
grant SELECT                                                                 on DPT_PAYMENTS    to BARSUPL;
grant SELECT                                                                 on DPT_PAYMENTS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_PAYMENTS    to BARS_SUP;
grant SELECT                                                                 on DPT_PAYMENTS    to RPBN001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_PAYMENTS    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_PAYMENTS.sql =========*** End *** 
PROMPT ===================================================================================== 
