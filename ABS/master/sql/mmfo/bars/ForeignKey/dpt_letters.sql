

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_LETTERS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTLETTERS_DOCSCHEME ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_LETTERS ADD CONSTRAINT FK_DPTLETTERS_DOCSCHEME FOREIGN KEY (DOC_SCHEME_ID)
	  REFERENCES BARS.DOC_SCHEME (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_LETTERS.sql =========*** End 
PROMPT ===================================================================================== 
