

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_FILE_SUBST.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTFILESUBST_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_SUBST ADD CONSTRAINT FK_DPTFILESUBST_BRANCH FOREIGN KEY (PARENT_BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTFILESUBST_BRANCH2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_SUBST ADD CONSTRAINT FK_DPTFILESUBST_BRANCH2 FOREIGN KEY (CHILD_BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_FILE_SUBST.sql =========*** E
PROMPT ===================================================================================== 
