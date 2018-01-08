

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/INS_PARTNERS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_INSPARTNERS_RNK_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNERS ADD CONSTRAINT FK_INSPARTNERS_RNK_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSPARTNERS_TID_TARIFFS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNERS ADD CONSTRAINT FK_INSPARTNERS_TID_TARIFFS FOREIGN KEY (TARIFF_ID, KF)
	  REFERENCES BARS.INS_TARIFFS (ID, KF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSPARTNERS_FID_FEES ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNERS ADD CONSTRAINT FK_INSPARTNERS_FID_FEES FOREIGN KEY (FEE_ID, KF)
	  REFERENCES BARS.INS_FEES (ID, KF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSPARTNERS_LID_LIMITS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNERS ADD CONSTRAINT FK_INSPARTNERS_LID_LIMITS FOREIGN KEY (LIMIT_ID, KF)
	  REFERENCES BARS.INS_LIMITS (ID, KF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/INS_PARTNERS.sql =========*** End
PROMPT ===================================================================================== 
