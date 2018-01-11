

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CIN_TAG_RNK.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CINTAGRNK_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_TAG_RNK ADD CONSTRAINT FK_CINTAGRNK_RNK FOREIGN KEY (RNK)
	  REFERENCES BARS.CIN_CUST (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CINTAGRNK_TAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIN_TAG_RNK ADD CONSTRAINT FK_CINTAGRNK_TAG FOREIGN KEY (TAG)
	  REFERENCES BARS.CIN_TAG (TAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CIN_TAG_RNK.sql =========*** End 
PROMPT ===================================================================================== 
