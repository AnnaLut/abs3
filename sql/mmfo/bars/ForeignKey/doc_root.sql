

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DOC_ROOT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DOCROOT_CCVIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DOC_ROOT ADD CONSTRAINT FK_DOCROOT_CCVIDD FOREIGN KEY (VIDD)
	  REFERENCES BARS.CC_VIDD (VIDD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DOCROOT_DOCSCHEME ***
begin   
 execute immediate '
  ALTER TABLE BARS.DOC_ROOT ADD CONSTRAINT FK_DOCROOT_DOCSCHEME FOREIGN KEY (ID)
	  REFERENCES BARS.DOC_SCHEME (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DOC_ROOT.sql =========*** End ***
PROMPT ===================================================================================== 
