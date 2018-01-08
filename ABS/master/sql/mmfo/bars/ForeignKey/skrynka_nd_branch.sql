

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_ND_BRANCH.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SKR_ND_BRN_REF_TIP_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_BRANCH ADD CONSTRAINT FK_SKR_ND_BRN_REF_TIP_BRANCH FOREIGN KEY (O_SK, BRANCH)
	  REFERENCES BARS.SKRYNKA_TIP_BRANCH (O_SK, BRANCH) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_ND_BRANCH.sql =========**
PROMPT ===================================================================================== 
