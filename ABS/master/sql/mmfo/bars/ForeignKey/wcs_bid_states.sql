

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_BID_STATES.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BIDSTATES_BID_BIDS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BID_STATES ADD CONSTRAINT FK_BIDSTATES_BID_BIDS_ID FOREIGN KEY (BID_ID)
	  REFERENCES BARS.WCS_BIDS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_BID_STATES.sql =========*** E
PROMPT ===================================================================================== 
