

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/APPLIST.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_APPLIST_FRONTEND ***
begin   
 execute immediate '
  ALTER TABLE BARS.APPLIST ADD CONSTRAINT FK_APPLIST_FRONTEND FOREIGN KEY (FRONTEND)
	  REFERENCES BARS.FRONTEND (FID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/APPLIST.sql =========*** End *** 
PROMPT ===================================================================================== 
