

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/GERC_ORDERS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_GERC_OPRDERS_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.GERC_ORDERS ADD CONSTRAINT FK_GERC_OPRDERS_TTS FOREIGN KEY (OPERATIONTYPE)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GERC_OPRDERS_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.GERC_ORDERS ADD CONSTRAINT FK_GERC_OPRDERS_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GERC_OPRDERS_DOCUMENTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.GERC_ORDERS ADD CONSTRAINT FK_GERC_OPRDERS_DOCUMENTTYPE FOREIGN KEY (DOCUMENTTYPE)
	  REFERENCES BARS.VOB (VOB) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GERC_OPRDERS_DEBITMFO ***
begin   
 execute immediate '
  ALTER TABLE BARS.GERC_ORDERS ADD CONSTRAINT FK_GERC_OPRDERS_DEBITMFO FOREIGN KEY (DEBITMFO)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GERC_OPRDERS_CREDITMFO ***
begin   
 execute immediate '
  ALTER TABLE BARS.GERC_ORDERS ADD CONSTRAINT FK_GERC_OPRDERS_CREDITMFO FOREIGN KEY (CREDITMFO)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GERC_OPRDERS_DEBITFLAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.GERC_ORDERS ADD CONSTRAINT FK_GERC_OPRDERS_DEBITFLAG FOREIGN KEY (DEBITFLAG)
	  REFERENCES BARS.DK (DK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/GERC_ORDERS.sql =========*** End 
PROMPT ===================================================================================== 
