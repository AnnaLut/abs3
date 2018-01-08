

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SW_BANK_KEY.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SWBANKKEY_SWBANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_BANK_KEY ADD CONSTRAINT FK_SWBANKKEY_SWBANKS FOREIGN KEY (BIC)
	  REFERENCES BARS.SW_BANKS (BIC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWBANKKEY_SWBANKS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_BANK_KEY ADD CONSTRAINT FK_SWBANKKEY_SWBANKS2 FOREIGN KEY (CORR_BIC)
	  REFERENCES BARS.SW_BANKS (BIC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SW_BANK_KEY.sql =========*** End 
PROMPT ===================================================================================== 
