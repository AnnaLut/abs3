

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/GERC_STATECODES.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_GERC_STATECODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.GERC_STATECODES ADD CONSTRAINT FK_GERC_STATECODES FOREIGN KEY (ID)
	  REFERENCES BARS.SOS (SOS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/GERC_STATECODES.sql =========*** 
PROMPT ===================================================================================== 
