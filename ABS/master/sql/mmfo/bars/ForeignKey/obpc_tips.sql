

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OBPC_TIPS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OBPCTIPS_TIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TIPS ADD CONSTRAINT FK_OBPCTIPS_TIPS FOREIGN KEY (TIP)
	  REFERENCES BARS.TIPS (TIP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OBPC_TIPS.sql =========*** End **
PROMPT ===================================================================================== 