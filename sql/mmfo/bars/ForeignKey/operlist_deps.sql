

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OPERLIST_DEPS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OPERLISTDEPS_OPERLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST_DEPS ADD CONSTRAINT FK_OPERLISTDEPS_OPERLIST FOREIGN KEY (ID_PARENT)
	  REFERENCES BARS.OPERLIST (CODEOPER) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPERLISTDEPS_OPERLIST2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST_DEPS ADD CONSTRAINT FK_OPERLISTDEPS_OPERLIST2 FOREIGN KEY (ID_CHILD)
	  REFERENCES BARS.OPERLIST (CODEOPER) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OPERLIST_DEPS.sql =========*** En
PROMPT ===================================================================================== 
