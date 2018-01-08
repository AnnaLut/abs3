

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/LKL_RRP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_LKL_RRP_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.LKL_RRP ADD CONSTRAINT FK_LKL_RRP_BANKS FOREIGN KEY (MFO)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_LKL_RRP_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.LKL_RRP ADD CONSTRAINT FK_LKL_RRP_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_LKL_RRP_BLK_CODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.LKL_RRP ADD CONSTRAINT FK_LKL_RRP_BLK_CODES FOREIGN KEY (BLK)
	  REFERENCES BARS.BLK_CODES (BLK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/LKL_RRP.sql =========*** End *** 
PROMPT ===================================================================================== 
