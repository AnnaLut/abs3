

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DEPRICATED_BRANCH_TAGS.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BRANCHTAGS_NBSOB22 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEPRICATED_BRANCH_TAGS ADD CONSTRAINT FK_BRANCHTAGS_NBSOB22 FOREIGN KEY (NBS, OB22)
	  REFERENCES BARS.SB_OB22 (R020, OB22) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DEPRICATED_BRANCH_TAGS.sql ======
PROMPT ===================================================================================== 
