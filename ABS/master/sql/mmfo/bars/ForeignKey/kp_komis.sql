

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/KP_KOMIS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_KP_KOMIS ***
begin   
 execute immediate '
  ALTER TABLE BARS.KP_KOMIS ADD CONSTRAINT FK_KP_KOMIS FOREIGN KEY (ND)
	  REFERENCES BARS.KP_DEAL (ND) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/KP_KOMIS.sql =========*** End ***
PROMPT ===================================================================================== 
