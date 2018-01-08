

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/LIST_FUNCSET.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_LISTFUNCSETT_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.LIST_FUNCSET ADD CONSTRAINT FK_LISTFUNCSETT_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_LISTFUNCSET_OPERLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.LIST_FUNCSET ADD CONSTRAINT FK_LISTFUNCSET_OPERLIST FOREIGN KEY (FUNC_ID)
	  REFERENCES BARS.OPERLIST (CODEOPER) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_LISTFUNCSET_LISTSET ***
begin   
 execute immediate '
  ALTER TABLE BARS.LIST_FUNCSET ADD CONSTRAINT FK_LISTFUNCSET_LISTSET FOREIGN KEY (SET_ID)
	  REFERENCES BARS.LIST_SET (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/LIST_FUNCSET.sql =========*** End
PROMPT ===================================================================================== 
