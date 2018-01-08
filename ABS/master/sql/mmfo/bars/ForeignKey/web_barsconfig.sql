

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WEB_BARSCONFIG.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_WEB_BARSCONFIG_GROUPTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_BARSCONFIG ADD CONSTRAINT FK_WEB_BARSCONFIG_GROUPTYPE FOREIGN KEY (GROUPTYPE)
	  REFERENCES BARS.WEB_BARSCONFIG_GROUPTYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WEB_BARSCONFIG.sql =========*** E
PROMPT ===================================================================================== 
