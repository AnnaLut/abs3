

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SOCIAL_TRUSTEE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SOCTRUSTEE_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_TRUSTEE ADD CONSTRAINT FK_SOCTRUSTEE_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SOCTRUSTEE_DPTTRUSTEETYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_TRUSTEE ADD CONSTRAINT FK_SOCTRUSTEE_DPTTRUSTEETYPE FOREIGN KEY (TRUST_TYPE)
	  REFERENCES BARS.DPT_TRUSTEE_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SOCTRUSTEE_SOCIALCONTRACTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_TRUSTEE ADD CONSTRAINT FK_SOCTRUSTEE_SOCIALCONTRACTS FOREIGN KEY (CONTRACT_ID)
	  REFERENCES BARS.SOCIAL_CONTRACTS (CONTRACT_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SOCTRUSTEE_SOCTRUSTEE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_TRUSTEE ADD CONSTRAINT FK_SOCTRUSTEE_SOCTRUSTEE FOREIGN KEY (UNDO_ID)
	  REFERENCES BARS.SOCIAL_TRUSTEE (TRUST_ID) ON DELETE CASCADE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SOCTRUSTEE_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_TRUSTEE ADD CONSTRAINT FK_SOCTRUSTEE_CUSTOMER FOREIGN KEY (TRUST_RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SOCTRUSTEE_CUSTOMER2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_TRUSTEE ADD CONSTRAINT FK_SOCTRUSTEE_CUSTOMER2 FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SOCTRUSTEE_DOCSCHEME ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_TRUSTEE ADD CONSTRAINT FK_SOCTRUSTEE_DOCSCHEME FOREIGN KEY (TEMPLATE_ID)
	  REFERENCES BARS.DOC_SCHEME (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SOCIAL_TRUSTEE.sql =========*** E
PROMPT ===================================================================================== 
