

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DEPRICATED_PARAMS$BASE.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_PARAMS$BASE_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEPRICATED_PARAMS$BASE ADD CONSTRAINT FK_PARAMS$BASE_BANKS FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DEPRICATED_PARAMS$BASE.sql ======
PROMPT ===================================================================================== 
