

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/NAEK_LINES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_NAEKLINES_DK ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES ADD CONSTRAINT FK_NAEKLINES_DK FOREIGN KEY (DK)
	  REFERENCES BARS.DK (DK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NAEKLINES_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES ADD CONSTRAINT FK_NAEKLINES_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NAEKLINES_NAEKHEADERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES ADD CONSTRAINT FK_NAEKLINES_NAEKHEADERS FOREIGN KEY (KF, FILE_YEAR, FILE_NAME)
	  REFERENCES BARS.NAEK_HEADERS (KF, FILE_YEAR, FILE_NAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NAEKLINES_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES ADD CONSTRAINT FK_NAEKLINES_BANKS FOREIGN KEY (PAYER_BANK_CODE)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NAEKLINES_BANKS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES ADD CONSTRAINT FK_NAEKLINES_BANKS2 FOREIGN KEY (PAYEE_BANK_CODE)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NAEKLINES_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_LINES ADD CONSTRAINT FK_NAEKLINES_TABVAL FOREIGN KEY (CURRENCY)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/NAEK_LINES.sql =========*** End *
PROMPT ===================================================================================== 
