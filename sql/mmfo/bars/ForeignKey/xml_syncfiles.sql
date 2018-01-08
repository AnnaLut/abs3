

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/XML_SYNCFILES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint XFK_XMLSYNCFILESTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_SYNCFILES ADD CONSTRAINT XFK_XMLSYNCFILESTYPE FOREIGN KEY (SYNCTYPE)
	  REFERENCES BARS.XML_SYNCTYPES (SYNCTYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/XML_SYNCFILES.sql =========*** En
PROMPT ===================================================================================== 
