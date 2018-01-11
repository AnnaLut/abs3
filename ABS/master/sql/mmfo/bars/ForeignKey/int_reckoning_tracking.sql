

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/INT_RECKONING_TRACKING.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_RECK_TRACK_REF_RECKONING ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RECKONING_TRACKING ADD CONSTRAINT FK_RECK_TRACK_REF_RECKONING FOREIGN KEY (RECKONING_ID)
	  REFERENCES BARS.INT_RECKONINGS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/INT_RECKONING_TRACKING.sql ======
PROMPT ===================================================================================== 
