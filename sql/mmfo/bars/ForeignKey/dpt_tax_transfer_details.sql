

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_TAX_TRANSFER_DETAILS.sql ====
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTTAXTRANSFDET_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TAX_TRANSFER_DETAILS ADD CONSTRAINT FK_DPTTAXTRANSFDET_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTTAXTRANSFDET_MFO ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TAX_TRANSFER_DETAILS ADD CONSTRAINT FK_DPTTAXTRANSFDET_MFO FOREIGN KEY (MFO)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_TAX_TRANSFER_DETAILS.sql ====
PROMPT ===================================================================================== 