

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_BRATES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTBRATES_MODCODE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BRATES ADD CONSTRAINT FK_DPTBRATES_MODCODE FOREIGN KEY (MOD_CODE)
	  REFERENCES BARS.BARS_SUPP_MODULES (MOD_CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTBRATES_BASEY ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BRATES ADD CONSTRAINT FK_DPTBRATES_BASEY FOREIGN KEY (BASEY)
	  REFERENCES BARS.BASEY (BASEY) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_BRATES.sql =========*** End *
PROMPT ===================================================================================== 
