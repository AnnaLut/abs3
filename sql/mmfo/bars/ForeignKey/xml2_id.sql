

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/XML2_ID.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_XML2ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML2_ID ADD CONSTRAINT FK_XML2ID FOREIGN KEY (BM)
	  REFERENCES BARS.XML2_BM (BM) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/XML2_ID.sql =========*** End *** 
PROMPT ===================================================================================== 
