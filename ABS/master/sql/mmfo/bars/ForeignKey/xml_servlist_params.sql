

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/XML_SERVLIST_PARAMS.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_XMLSERVPARAMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_SERVLIST_PARAMS ADD CONSTRAINT FK_XMLSERVPARAMS FOREIGN KEY (SNAM)
	  REFERENCES BARS.XML_SERVLIST (SNAM) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/XML_SERVLIST_PARAMS.sql =========
PROMPT ===================================================================================== 
