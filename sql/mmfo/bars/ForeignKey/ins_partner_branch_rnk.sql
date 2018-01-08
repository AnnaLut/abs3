

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/INS_PARTNER_BRANCH_RNK.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_PTRBRANCHRNK_PID_PARTNERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_BRANCH_RNK ADD CONSTRAINT FK_PTRBRANCHRNK_PID_PARTNERS FOREIGN KEY (PARTNER_ID, KF)
	  REFERENCES BARS.INS_PARTNERS (ID, KF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PTRBRANCHRNK_B_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_BRANCH_RNK ADD CONSTRAINT FK_PTRBRANCHRNK_B_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PTRBRANCHRNK_RNK_CUSTOMERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_BRANCH_RNK ADD CONSTRAINT FK_PTRBRANCHRNK_RNK_CUSTOMERS FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/INS_PARTNER_BRANCH_RNK.sql ======
PROMPT ===================================================================================== 
