

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STAFF_BRANCH_K.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_STAFFBRANCHK_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_BRANCH_K ADD CONSTRAINT FK_STAFFBRANCHK_BRANCH FOREIGN KEY (BRANCH_K)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFFBRANCHK_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_BRANCH_K ADD CONSTRAINT FK_STAFFBRANCHK_STAFF FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STAFF_BRANCH_K.sql =========*** E
PROMPT ===================================================================================== 
