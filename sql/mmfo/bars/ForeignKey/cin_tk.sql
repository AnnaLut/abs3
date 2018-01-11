

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CIN_TK.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CINTK_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_TK ADD CONSTRAINT FK_CINTK_RNK FOREIGN KEY (RNK)
	  REFERENCES BARS.CIN_CUST (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CIN_TK.sql =========*** End *** =
PROMPT ===================================================================================== 
