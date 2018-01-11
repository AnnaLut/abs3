

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/META_REGENTRY.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_METAREGENTRY_METAREGENTRY ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_REGENTRY ADD CONSTRAINT FK_METAREGENTRY_METAREGENTRY FOREIGN KEY (PID)
	  REFERENCES BARS.META_REGENTRY (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/META_REGENTRY.sql =========*** En
PROMPT ===================================================================================== 
