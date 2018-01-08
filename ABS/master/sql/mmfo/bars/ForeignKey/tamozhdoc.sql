

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/TAMOZHDOC.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_TAMOZHDOC_CONTRACTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TAMOZHDOC ADD CONSTRAINT FK_TAMOZHDOC_CONTRACTS FOREIGN KEY (ID)
	  REFERENCES BARS.CONTRACTS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TAMOZHDOC_TOPCONTRACTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TAMOZHDOC ADD CONSTRAINT FK_TAMOZHDOC_TOPCONTRACTS FOREIGN KEY (PID)
	  REFERENCES BARS.TOP_CONTRACTS (PID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TAMOZHDOC_TAMOZHDOCREESTR ***
begin   
 execute immediate '
  ALTER TABLE BARS.TAMOZHDOC ADD CONSTRAINT FK_TAMOZHDOC_TAMOZHDOCREESTR FOREIGN KEY (IDR)
	  REFERENCES BARS.TAMOZHDOC_REESTR (IDR) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TAMOZHDOC_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.TAMOZHDOC ADD CONSTRAINT FK_TAMOZHDOC_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/TAMOZHDOC.sql =========*** End **
PROMPT ===================================================================================== 
