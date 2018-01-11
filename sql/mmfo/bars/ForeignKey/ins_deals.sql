

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/INS_DEALS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_INSDEALS_PARTNERTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEALS ADD CONSTRAINT FK_INSDEALS_PARTNERTYPES FOREIGN KEY (PARTNER_ID, TYPE_ID, KF)
	  REFERENCES BARS.INS_PARTNER_TYPES (PARTNER_ID, TYPE_ID, KF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSDEALS_BRANCH_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEALS ADD CONSTRAINT FK_INSDEALS_BRANCH_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSDEALS_STFID_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEALS ADD CONSTRAINT FK_INSDEALS_STFID_STAFF FOREIGN KEY (STAFF_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSDEALS_STSID_STATUSES ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEALS ADD CONSTRAINT FK_INSDEALS_STSID_STATUSES FOREIGN KEY (STATUS_ID)
	  REFERENCES BARS.INS_DEAL_STATUSES (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSDEALS_SKV_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEALS ADD CONSTRAINT FK_INSDEALS_SKV_TABVAL FOREIGN KEY (SUM_KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSDEALS_OT_OBJTYPES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEALS ADD CONSTRAINT FK_INSDEALS_OT_OBJTYPES_ID FOREIGN KEY (OBJECT_TYPE)
	  REFERENCES BARS.INS_OBJECT_TYPES (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSDEALS_RNK_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEALS ADD CONSTRAINT FK_INSDEALS_RNK_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSDEALS_GRTID_GRTDEALS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEALS ADD CONSTRAINT FK_INSDEALS_GRTID_GRTDEALS FOREIGN KEY (GRT_ID)
	  REFERENCES BARS.GRT_DEALS (DEAL_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSDEALS_ND_CCDEAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEALS ADD CONSTRAINT FK_INSDEALS_ND_CCDEAL FOREIGN KEY (ND)
	  REFERENCES BARS.CC_DEAL (ND) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSDEALS_PF_FREQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEALS ADD CONSTRAINT FK_INSDEALS_PF_FREQ FOREIGN KEY (PAY_FREQ)
	  REFERENCES BARS.FREQ (FREQ) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSDEALS_NEWID_INSDEALS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEALS ADD CONSTRAINT FK_INSDEALS_NEWID_INSDEALS FOREIGN KEY (RENEW_NEWID, KF)
	  REFERENCES BARS.INS_DEALS (ID, KF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/INS_DEALS.sql =========*** End **
PROMPT ===================================================================================== 
