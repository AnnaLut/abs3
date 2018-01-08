

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_TIP_BRANCH.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BR_SKRYN_TIP_REF_ETALON ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TIP_BRANCH ADD CONSTRAINT FK_BR_SKRYN_TIP_REF_ETALON FOREIGN KEY (ETALON_ID)
	  REFERENCES BARS.SKRYNKA_TIP_ETALON (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_TIP_BRANCH.sql =========*
PROMPT ===================================================================================== 
