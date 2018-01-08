

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WEB_USERMAP.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_WEB_USERMAP_DBUSER ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_USERMAP ADD CONSTRAINT FK_WEB_USERMAP_DBUSER FOREIGN KEY (DBUSER)
	  REFERENCES BARS.STAFF$BASE (LOGNAME) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WEB_USERMAP.sql =========*** End 
PROMPT ===================================================================================== 
