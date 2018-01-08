

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CIN_TAG.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CINTAG_TAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_TAG ADD CONSTRAINT FK_CINTAG_TAG FOREIGN KEY (TAG)
	  REFERENCES BARS.OP_FIELD (TAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CIN_TAG.sql =========*** End *** 
PROMPT ===================================================================================== 
