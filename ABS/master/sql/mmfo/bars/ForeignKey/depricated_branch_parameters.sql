

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DEPRICATED_BRANCH_PARAMETERS.sql 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BRANCHPARAMS_BRANCHTAGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEPRICATED_BRANCH_PARAMETERS ADD CONSTRAINT FK_BRANCHPARAMS_BRANCHTAGS FOREIGN KEY (TAG)
	  REFERENCES BARS.DEPRICATED_BRANCH_TAGS (TAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DEPRICATED_BRANCH_PARAMETERS.sql 
PROMPT ===================================================================================== 
