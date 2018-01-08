

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CRKR_CA_TRANSFER.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CRKR_CA_TRANSFER_STATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CRKR_CA_TRANSFER ADD CONSTRAINT FK_CRKR_CA_TRANSFER_STATE FOREIGN KEY (STATE_ID)
	  REFERENCES BARS.CRKR_CA_TRANSFER_STATE (STATE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CRKR_CA_TRANSFER.sql =========***
PROMPT ===================================================================================== 
