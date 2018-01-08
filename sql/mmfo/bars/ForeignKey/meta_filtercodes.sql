

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/META_FILTERCODES.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_METAFILTERCODES_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_FILTERCODES ADD CONSTRAINT FK_METAFILTERCODES_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/META_FILTERCODES.sql =========***
PROMPT ===================================================================================== 
