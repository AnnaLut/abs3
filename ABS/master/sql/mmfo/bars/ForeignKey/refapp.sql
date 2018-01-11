

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/REFAPP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_REFAPP_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.REFAPP ADD CONSTRAINT FK_REFAPP_STAFF FOREIGN KEY (GRANTOR)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_REFAPP_METATACCESS ***
begin   
 execute immediate '
  ALTER TABLE BARS.REFAPP ADD CONSTRAINT FK_REFAPP_METATACCESS FOREIGN KEY (ACODE)
	  REFERENCES BARS.META_TACCESS (ACODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_REFAPP_METATABLES ***
begin   
 execute immediate '
  ALTER TABLE BARS.REFAPP ADD CONSTRAINT FK_REFAPP_METATABLES FOREIGN KEY (TABID)
	  REFERENCES BARS.META_TABLES (TABID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/REFAPP.sql =========*** End *** =
PROMPT ===================================================================================== 
